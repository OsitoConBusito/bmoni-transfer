# backend — rules (Node/TS)

Backend-specific rules. Cross-cutting invariants (money, idempotency) and the
contract: see [/CLAUDE.md](../CLAUDE.md) and
[/.specs/features/mxn-usd-transfer.md](../.specs/features/mxn-usd-transfer.md).

## Architecture — hexagonal-light
Dependencies point inward: `infrastructure → application → domain`. Tree in
the spec's § Architecture.
- `domain/` is PURE: no Express, no `http`, no I/O of any kind. Only VOs,
  entities, rules, and **ports** (the `RateProvider`, `Repository`
  interfaces).
- `application/` orchestrates use cases and returns `Result<T, AppError>`.
  It never builds HTTP responses.
- `infrastructure/` implements the ports (Frankfurter/stub, in-memory
  repos) and exposes the handlers.
- `shared/` = `Result`, error types, config.

## Thin handlers
One handler: parse the input (Zod) → call the use case → map the `Result`
to HTTP with a helper. No business logic, domain validation, or storage in
the handler.

## Errors as values
Use cases return `Result<T, AppError>`; the expected failure path goes
through `err(...)`, never `throw`. `try/catch` is allowed only at (a) the
handler boundary (mapping the unexpected to 500) and (b) best-effort side
effects with `logger.warn`. No `catch` that swallows an error without
logging or transforming it.

## Validation and input
- Zod at the boundary for the request's **shape** (body structure, field
  presence). **Business validation of the amount** (exact numeric,
  positive, min/max, covers the fee) lives in the use case and travels as
  `Result<_, AppError>` — parsing exact money requires `Money`, not a Zod
  coerce.
- A final error middleware logs the unexpected and responds with a curated
  500 envelope (never stack traces).
- Error codes as a closed union `as const` (no magic strings). Consistent
  envelope: `{ error: { code, message, field? } }`.

## TypeScript
- TS strict, no `any` (use `unknown` + narrow). `as` only after real
  validation.
- Money in integer minor units (see the cross-cutting invariant). The wire
  carries integers, never decimals.

## Storage
In-memory behind the `Repository` port (swappable for a DB later). State:
maps of quotes, transfers, idempotency keys, and used quotes. Rate cache
with a TTL (over the `Clock` port).

## Security (see [/.specs/features/security.md](../.specs/features/security.md))
helmet + CORS allowlist (no wildcard) + express-rate-limit + body-size
limit + pino with redaction. Errors never leak stack traces/internals: only
the curated envelope; 500s are logged, not exposed. The amount isn't
editable: the client sends only `quoteId`; the backend recalculates from
the stored quote and verifies its **HMAC** signature (server-side secret,
never sent to the client). Determinism via the `Clock` port.
