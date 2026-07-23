# Spec: mxn-usd-transfer — MXN → USD transfer quote and confirmation

> Status: DRAFT
> Last reviewed: 2026-07-22
> Context: BMONI take-home (vertical slice, 2-3h). The spec is the contract:
> if the code contradicts it, fix the spec first, then the code.

---

## Goal

Let a user in Mexico quote and confirm an **MXN → USD** transfer: type an
amount in MXN, see the USD equivalent, the exchange rate and the fee live,
review a breakdown, and confirm. The backend provides the rate and records
the transfer in a **retry-safe** way (calling it twice doesn't create two
transfers).

---

## Out of scope (don't spend time here)

Auth, real payments, real KYC, a database, and pixel-perfect design.
In-memory storage. Only the MXN → USD direction (not USD → MXN). A single
currency pair.

---

## The two things this domain punishes (the evaluation's focus)

1. **Money representation:** how MXN/USD is stored and rounded. → see § Money model.
2. **Retry-safe transfer:** calling `POST /transfers` twice must not double-charge. → see § Idempotency.

---

## Architecture

Principle: **intentional but calibrated to the slice** architecture — real
layers, zero ceremony. Coupling points inward (infra → application →
domain); domain knows nothing about Express, HTTP, or Flutter. Errors as
values with a custom `Result<T,E>` (hand-rolled, no dependency) on both
sides; `try/catch` only at the boundary. See rules in
[/CLAUDE.md](../../CLAUDE.md).

### Backend — Hexagonal-light (ports & adapters)
```
backend/src/
├── domain/            money, rate, quote, transfer, fee; ports/ (RateProvider, Repository, Clock)
├── application/       get-quote.use-case, create-transfer.use-case  (return Result)
├── infrastructure/    http/ (handlers, router, error-map, pino) · rate/ (frankfurter, stub, cached) · persistence/ (in-memory) · clock/ (system, fake)
└── shared/            Result, errors, config
```
The **ports** (`RateProvider`, `Repository`) make the rate (stub↔real) and
storage (in-memory↔DB) swappable without touching the domain. Thin
handlers: parse+Zod → use case → map `Result` to HTTP.

### Frontend — Clean Arch domain-first, feature-first (one `transfer` feature)
```
app/lib/
├── core/                       Money, Result, http client, env/config
└── features/transfer/
    ├── domain/        entities (money, quote, transfer) · transfer_repository (interface) · use cases
    ├── data/          dtos · datasources (http) · mappers · transfer_repository_impl
    └── presentation/  providers (Riverpod notifiers) · pages (amount_entry, confirmation, result) · widgets (per state)
```
`domain` never imports `data` or Flutter. Money comes from the backend and
gets mapped to `Money` in `data/`; the client never recomputes the rate.
State via **Riverpod 3.0 codegen**; `AsyncValue` → loading/error/data.

---

## Money model (§ critical)

An approach borrowed from money.js/decimal.js, implemented in a **custom**
value object (no external dependency — decision: a money library is
overkill for 2 currencies).

- **Integer minor units, never floats.** MXN is stored in **cents** (`int`),
  USD in **cents** (`int`). The wire (JSON) carries integer minor units,
  never decimals.
- **High scale during computation, rounded once at the boundary.** The
  `MXN * rate` multiplication and the fee's 1% produce fractions.
  Computation runs at extended precision and **rounds half-up to the
  destination's smallest unit exactly once**, when the USD amount is
  materialized. This avoids double-rounding bias.
- **Rounding mode: half-up** (0.5 rounds up). Documented and tested.
  Applies to the final USD amount and the fee's percentage component.
- **Rounding direction:** the fee and rounding never favor the client in a
  way that unbalances the books; half-up is symmetric and explicit.

### Regulatory basis (backing the decision)
- **Mexico's Monetary Law:** rounding to multiples of 5 cents applies
  **only to cash**; payments that don't involve handing over cash are made
  for the **exact amount**. A digital transfer is non-cash → we operate in
  **exact cents, no rounding to 5 cents**. Half-up to the smallest
  divisible unit is consistent with "exact amount".
- **Banxico exchange rate (FIX):** published at **4 decimals**, in the
  USD/MXN direction (pesos per dollar). We use MXN→USD (the inverse), which
  needs more decimals; we store the rate at the source's precision. Path to
  an official rate: take the FIX as USD/MXN at 4 decimals and invert it.
  (Today: Frankfurter/ECB.)

### `Money` value object (both sides, conceptual mirror)
| Field | Type | Note |
|---|---|---|
| `minorUnits` | `int` | Amount in the smallest unit (MXN cents / USD cents) |
| `currency` | `Currency` enum | `MXN` \| `USD` (defines the exponent: 2) |

Operations: `fromMajor(decimal)` (validates it's an integer after scaling),
`toMajor()` (display only), `applyRate(rate, targetCurrency)` (high scale →
round half-up), `plus`/`minus` (same currency). Building a `Money` from a
raw `double` without going through the validating factory is forbidden.

---

## Domain

### Enums
- `Currency { MXN, USD }` — exponent 2 for both.
- `TransferStatus { PENDING, COMPLETED, FAILED, EXPIRED }`.

### `Quote` entity
| Field | Type | Note |
|---|---|---|
| `id` | `string` (uuid) | Generated by the backend |
| `sourceAmount` | `Money(MXN)` | Amount the user types |
| `rate` | `Rate` | MXN→USD rate used (see § Rate) |
| `fee` | `Money(MXN)` | Tiered fee (see § Fee) |
| `destAmount` | `Money(USD)` | `(sourceAmount − fee) * rate`, rounded half-up |
| `createdAt` | `timestamp` | |
| `expiresAt` | `timestamp` | `createdAt + 60s` |

Getter: `isExpired(now) => now >= expiresAt`.

### `Transfer` entity
| Field | Type | Note |
|---|---|---|
| `id` | `string` (uuid) | |
| `quoteId` | `string` | The quote it consumed |
| `sourceAmount` / `destAmount` / `fee` / `rate` | (snapshot) | Copied from the quote on creation (immutable) |
| `status` | `TransferStatus` | |
| `idempotencyKey` | `string` | The key it was created with |
| `createdAt` | `timestamp` | |

### `Rate` (value object)
| Field | Type | Note |
|---|---|---|
| `value` | `decimal` (string on the wire) | MXN→USD, e.g. `0.05739` |
| `source` | `string` | `frankfurter` \| `stub` |
| `asOf` | `date` | The rate's date (ECB publishes a daily rate) |

---

## Business rules

### § Rate (the rate is NOT hardcoded on the client)
- The backend exposes the rate; the client **never** computes or hardcodes
  it.
- Sourced behind a `RateProvider` interface, selectable via the
  `RATE_PROVIDER` env var:
  - `FrankfurterRateProvider` (default) → `GET https://api.frankfurter.dev/v1/latest?base=MXN&symbols=USD` (no API key, daily ECB rate).
  - `StubRateProvider` → a fixed, deterministic rate (tests and fallback).
- **In-memory cache with a TTL** for the rate: quoting doesn't trigger a
  network call on every request.
- **Fallback:** if Frankfurter fails and there's no valid cached rate →
  respond `503` with an actionable error (never invent a rate). The
  frontend treats 503 as a "network error" to retry.

### § Tiered fee (flat + percentage)
Parameters (defaults; configurable via env):
- `FEE_FLAT_MXN = 20.00` (2000 cents)
- `FEE_THRESHOLD_MXN = 5000.00` (500000 cents)
- `FEE_PERCENT = 0.01` (1%)

Rule:
```
fee = FEE_FLAT
if sourceAmount > FEE_THRESHOLD:
    fee += FEE_PERCENT * sourceAmount   (rounded half-up to cents)
```
Examples: 500 MXN→20 · 5,000→20 · 10,000→120 · 50,000→520.
`destAmount` is computed over `(sourceAmount − fee)` (the fee is deducted
from the send).

### § Amount limits (backend validation)
- `MIN_AMOUNT_MXN = 10.00`, `MAX_AMOUNT_MXN = 100,000.00`.
- Out of range, zero, negative, non-numeric, or `sourceAmount ≤ fee` →
  `400` with an actionable code.

### § Quote expiry and determinism
- TTL = **60s**. `POST /transfers` with an expired quote → `409 QUOTE_EXPIRED`.
- **Injected `Clock` port** (`now()`) instead of inline `Date.now()`: the
  domain never touches the global clock. `SystemClock` in prod, `FakeClock`
  in tests → expiry is tested deterministically, with no real waits. (A
  seam that's usually missing when `Date.now()` is used directly.)
- **Rate cache:** its own TTL (`RATE_CACHE_TTL_MS`, default 60s) over the
  `Clock`. Quoting doesn't trigger a network call per request; on cold
  start, the first request fills the cache.

---

## Idempotency (defense in depth — § critical)

Three layers so `POST /transfers` never double-charges:

1. **Single-use quote (natural key):** each `quoteId` is consumed once. A
   second POST with the same quote (same idempotency key) returns the
   **same** already-created `Transfer`, `200`. A POST with the same quote
   but a **different** idempotency key → `409 QUOTE_ALREADY_USED`.
2. **`Idempotency-Key` header (Stripe pattern):** the client generates a
   UUID per logical attempt. The backend stores `key → transferId`. A
   retry with the same key → returns the same transfer (`200`), without
   creating another. Missing key on `POST /transfers` →
   `400 IDEMPOTENCY_KEY_REQUIRED`.
3. **Control barrier in Flutter:** a double-submit guard (disabled button +
   an `isSubmitting` flag on the notifier) so a double-tap doesn't even
   fire two requests.

Conflict rules:
- Same `Idempotency-Key` + same `quoteId` → idempotent, `200` with the
  existing transfer.
- Same `Idempotency-Key` + different `quoteId` → `409 IDEMPOTENCY_KEY_REUSED`
  (key misuse).

---

## API contract

Base path: **`/api/v1`** (versioned). Every path below hangs off it (e.g.
`GET /api/v1/quote`). Plus `GET /health` → `200 { status: "ok" }`
(unversioned). CORS enabled (lets Flutter run on web). Structured **pino**
logger (never `console.log`).

### `GET /quote?amount=<MXN major>`
`amount` in major units (e.g. `1000.50`). The backend scales it to cents
and validates it.

**200:**
```json
{
  "quoteId": "uuid",
  "sourceAmount": { "minorUnits": 100050, "currency": "MXN" },
  "fee":          { "minorUnits": 2000,   "currency": "MXN" },
  "feeBreakdown": {
    "fixed":    { "minorUnits": 2000,   "currency": "MXN" },
    "variable": { "minorUnits": 0,      "currency": "MXN" },
    "threshold":{ "minorUnits": 500000, "currency": "MXN" },
    "percentBasisPoints": 100
  },
  "destAmount":   { "minorUnits": 5624,   "currency": "USD" },
  "rate": { "value": "0.05739", "source": "frankfurter", "asOf": "2026-07-22" },
  "createdAt": "2026-07-22T19:00:00Z",
  "expiresAt": "2026-07-22T19:00:60Z"
}
```

`createdAt` lets the client compute the quote's real TTL (`expiresAt −
createdAt`) instead of assuming a fixed value — needed for a correct
countdown if the confirmation screen remounts with the same quote (e.g.
the user goes back and forward again without re-quoting).
`feeBreakdown` explains how the fee was composed, so the client can
display it **without hardcoding the policy**: `fixed` (the flat part) +
`variable` (the percentage part, `0` below the threshold), plus the rule
(`threshold`, `percentBasisPoints`). The total `fee` = `fixed + variable`.
The percentage is applied to the full amount above the threshold (see §
Tiered fee). The client never recomputes: it only presents these values.

**Errors:** `400` (`AMOUNT_REQUIRED`, `AMOUNT_NOT_NUMERIC`,
`AMOUNT_TOO_LOW`, `AMOUNT_TOO_HIGH`, `AMOUNT_NOT_POSITIVE`,
`AMOUNT_BELOW_FEE`), `503 RATE_UNAVAILABLE`.
`AMOUNT_BELOW_FEE`: the amount doesn't cover the fee (`sourceAmount ≤ fee`)
— possible because the minimum (10 MXN) is lower than the flat fee
(20 MXN); without this, `destAmount` would be negative.

### `POST /transfers`
Headers: `Idempotency-Key: <uuid>` (required).
```json
{ "quoteId": "uuid" }
```
The body carries **only** `quoteId`. The backend retrieves the stored
quote, checks expiry, and **recalculates/uses its own** rate/USD/fee
values. It never trusts money sent by the client.

**201** (created) / **200** (idempotent retry):
```json
{
  "transferId": "uuid",
  "status": "COMPLETED",
  "quoteId": "uuid",
  "sourceAmount": { "minorUnits": 100050, "currency": "MXN" },
  "destAmount":   { "minorUnits": 5624,   "currency": "USD" },
  "fee":          { "minorUnits": 2000,   "currency": "MXN" },
  "rate": { "value": "0.05739", "source": "frankfurter", "asOf": "2026-07-22" },
  "createdAt": "2026-07-22T19:00:30Z"
}
```
**Errors:** `400` (`IDEMPOTENCY_KEY_REQUIRED`, `QUOTE_ID_REQUIRED`),
`404 QUOTE_NOT_FOUND`, `409` (`QUOTE_EXPIRED`, `QUOTE_ALREADY_USED`,
`IDEMPOTENCY_KEY_REUSED`, `QUOTE_TAMPERED`).
`QUOTE_TAMPERED`: the stored quote's HMAC signature doesn't verify
(integrity; see security.md CA-S2).

### Error envelope (consistent)
```json
{ "error": { "code": "AMOUNT_TOO_HIGH", "message": "Amount 150000 MXN exceeds max 100000 MXN", "field": "amount" } }
```

---

## Backend state (in-memory)
- `Map<quoteId, Quote>`, `Map<transferId, Transfer>`,
  `Map<idempotencyKey, transferId>`, `Set<usedQuoteId>`. No DB. The rate
  cache is a `{ rate, cachedAt }` object with a TTL.

---

## Frontend — states and flow

Screens: **AmountEntry** → **Confirmation** → **Result**.

### AmountEntry
- Numeric MXN input; typing with a **~400ms debounce** calls `GET /quote`
  → shows USD, rate, fee live. Each request cancels the previous one
  (avoids out-of-order replies).
- **Money formatting with `intl`:** MXN in the `es_MX` locale
  (`$1,000.00`), USD in `en_US`. Never hand-concatenate money strings; the
  display comes from `Money.toMajor()` formatted by `intl`.
- States: `idle` · `loading` (quoting) · `data` (valid quote) · `error`
  (network/`RATE_UNAVAILABLE` → retry) · `invalid` (0/negative/out of
  range → inline message).

### Confirmation
- A clear breakdown: sending X MXN · fee · rate · receiving Y USD ·
  expires in NN s (countdown).
- If the quote expires before confirming → **expired** state with a
  "Get a new quote" CTA.
- Confirm → double-submit guard → `POST /transfers` with an
  `Idempotency-Key` generated on entering confirmation (stable across
  retries of the same logical attempt).

### Result
- `success` (status COMPLETED/PENDING) with a summary · `failure`
  (network/409 expired/FAILED) with an actionable cause and a retry.

### State management
- **Riverpod 3.0 with code generation** (`@riverpod`). `AsyncValue` maps
  directly to loading/error/data.
- A quote notifier (debounce + cancelling the previous request) and a
  transfer notifier (with `isSubmitting` for the double-submit barrier).
  Providers are testable via overrides.

---

## Acceptance criteria

### Backend — quote
- **CA-1:** `GET /quote?amount=1000` → 200 with `destAmount` =
  `(1000 − fee) * rate` in USD cents, half-up.
- **CA-2:** `amount=5000` → 20 MXN fee; `amount=10000` → 120 MXN fee
  (flat + 1%).
- **CA-3:** `amount=0` / negative / non-numeric → 400 with the matching
  code.
- **CA-4:** `amount=5` (< min) → 400 `AMOUNT_TOO_LOW`; `amount=150000` →
  400 `AMOUNT_TOO_HIGH`.
- **CA-5:** The rate comes from the `RateProvider` (never hardcoded); with
  `RATE_PROVIDER=stub` it's deterministic.
- **CA-6:** Real provider down and no cache → 503 `RATE_UNAVAILABLE` (never
  invents a rate).

### Backend — transfer / idempotency
- **CA-7:** `POST /transfers` with a valid quote + key → 201 with status
  and a money snapshot.
- **CA-8 (retry-safe):** two identical POSTs (same key, same quoteId) → a
  single Transfer; the 2nd returns 200 with the same `transferId`.
  **Never** creates two.
- **CA-9:** POST with an expired quote → 409 `QUOTE_EXPIRED`.
- **CA-10:** POST without `Idempotency-Key` → 400
  `IDEMPOTENCY_KEY_REQUIRED`.
- **CA-11:** Same key with a different `quoteId` → 409
  `IDEMPOTENCY_KEY_REUSED`.
- **CA-12:** A body with tampered rate/fee/USD is ignored; the backend
  uses the quote's own values.
- **CA-13:** Unknown `quoteId` → 404 `QUOTE_NOT_FOUND`.

### Money
- **CA-14:** No money operation ever uses a raw `float`/`double`;
  everything goes through `Money`.
- **CA-15:** Double rounding avoided: `(amount−fee)*rate` is rounded
  half-up **exactly once**.

### Frontend
- **CA-16:** Typing a valid amount (debounced) shows the live quote's
  USD/rate/fee.
- **CA-17:** Amount 0/negative/out of range → inline message, without
  unnecessarily calling the backend.
- **CA-18:** Network error while quoting → error state with a retry.
- **CA-19:** Expired quote in Confirmation → expired state with
  "Get a new quote".
- **CA-20:** Double-tap on Confirm → a single call to `POST /transfers`
  (control barrier).

---

## Test strategy (budget concentrated where the domain punishes)

Not even coverage; focus on the two things being evaluated plus the
failure paths.
- **Backend (Vitest):** exhaustive `Money` VO (half-up, no double
  rounding, float rejection) · tiered fee (the CA-2 examples) ·
  idempotency (CA-8: two POSTs = one transfer; CA-9/10/11) · use cases
  with `FakeClock` + `StubRateProvider` (deterministic expiry) · a handful
  of endpoint integration tests (supertest) for the HTTP contract.
- **Frontend (flutter_test + mocktail):** widget/notifier tests for the
  states the spec requires (CA-17 invalid, CA-19 expired, CA-20
  double-submit) + DTO→`Money` mapping.
- Traceability: annotate `// CA-N` in tests to close the loop from spec to
  test.

## Backlog / future iteration (out of the 2-3h scope)
- **`contract-checker` agent (BE↔FE):** verify the API contract (error
  codes, DTO shapes, envelope) doesn't drift between the TS backend and
  the Flutter client. Ideal once the contract grows; today it's a single
  pair of endpoints, kept in sync by hand against this spec.
- Real persistence (a DB) + more currency pairs + choosing the USD↔MXN
  direction.
- A real async transfer status/webhook (today PENDING→COMPLETED is
  immediate).
