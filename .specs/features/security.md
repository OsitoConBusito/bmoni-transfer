# Spec: security — threat model for the MXN → USD slice

> Status: DRAFT
> Last reviewed: 2026-07-22
> Cross-cutting. Ensures information travels securely (app↔backend), amounts
> aren't editable, and hardening across three planes: app, transit, backend.
> Business contract: see [mxn-usd-transfer.md](mxn-usd-transfer.md).

---

## Scope and assumptions
This slice has **no** auth/KYC (out of the brief). The threat model covers
the integrity of the money movement, not the user's identity. Where a
defense depends on identity, it's documented as **explicitly out of
scope** (not an oversight).

**Assets to protect:** the integrity of a quote's amount and rate,
non-duplication of transfers, confidentiality in transit, and the backend
never leaking internals.

---

## Plane 1 — In transit (app ↔ backend)
- **TLS mandatory in prod:** the client only speaks HTTPS to the prod host;
  it rejects non-localhost `http`. **HSTS** on the backend. In **dev**,
  `http://localhost` is allowed (no local TLS, as usual).
- **Certificate pinning — DEFERRED (not implemented).** A conscious
  decision: the evaluation window is short (<1 week) and the prod host
  (PaaS) rotates its Let's Encrypt cert every ~60-90 days, which would make
  a distributed APK pinned to the leaf cert fragile. TLS + a public CA
  cover MITM for this scope. Future path: pin the intermediate's SPKI with
  a backup pin, skipped on localhost.
- **No sensitive data in the URL** beyond `amount` (non-sensitive). No
  secrets in query strings or logs.

## Plane 2 — Amount integrity (non-editable) — § critical
- **The client never sends money.** `POST /api/v1/transfers` carries only
  `quoteId` + `Idempotency-Key`. The backend **retrieves the server-stored
  quote and recalculates** rate/fee/USD from its own values. A body with
  tampered amounts is ignored (CA-12). → the amount is **structurally**
  non-editable.
- **HMAC over the quote (defense in depth):** when issuing the quote, the
  backend signs `HMAC_SHA256(secret, quoteId|amounts|rate|expiresAt)` and
  stores/exposes the signature. On confirmation, it re-validates the
  signature before creating the transfer → catches any tampering or state
  corruption, and enables stateless validation down the road. The
  `secret` is server-side (env), never sent to the client.
- **Money as validated integer minor units** (floats rejected) — no
  precision loss or silent overflow.

## Plane 3 — Backend hardening
- **helmet** (security headers). **CORS** restricted to an **allowlist**
  via env (no wildcard in prod).
- **express-rate-limit** (anti abuse/brute-force) + a **body-size limit**
  (anti payload-based DoS).
- **Zod validation** at the boundary; `amount` bounded by `MIN/MAX`
  (prevents DoS via huge amounts).
- **pino with redaction** of sensitive fields (`hmacSecret`, headers).
  Never `console.log`.
- **Errors never leak internals:** the `{ error: { code, message, field? } }`
  envelope is curated; stack traces or infra details are never sent to the
  client. 500s are logged, never exposed.
- **Idempotency** (3 layers, see the transfer spec) prevents double-charge
  via replay.

## Plane 4 — App hardening
- **No secrets on the client:** `hmacSecret` lives only on the backend.
  The app doesn't store sensitive data at rest (no auth/tokens in this
  slice).
- **Dart obfuscation:** `flutter build apk --release --obfuscate
  --split-debug-info=build/symbols` → symbol names are obfuscated; debug
  symbols are stored separately (not in the APK).
- **Minification + shrinking (Android R8/ProGuard):** in
  `android/app/build.gradle`'s release config →
  `isMinifyEnabled = true` + `isShrinkResources = true`. ProGuard rules
  (`proguard-rules.pro`) with the `-keep` entries Flutter/plugins need
  (avoids breaking dio/Flutter reflection). Shrinks size and hinders
  reverse-engineering.
- **Hardened release manifest:** `android:allowBackup="false"` (no state
  exfiltration via backup), `android:debuggable="false"`, and a **network
  security config** that forbids cleartext except on `localhost`
  (consistent with TLS-mandatory-in-prod). No global
  `usesCleartextTraffic`.
- **No logging of sensitive data** in the app; the dev logger is
  disabled/limited in release.
- **Client-side validation = UX, not the security boundary:** the backend
  revalidates everything. The double-submit barrier is UX plus defense;
  the backend (idempotency) is the authority on non-duplication.
- **(Optional, if time allows):** `FLAG_SECURE` on screens showing amounts
  to block screenshots in the recents view; basic root/emulator detection
  is out of scope.

---

## Explicitly out of scope (documented, not omitted)
- **AuthN/AuthZ:** with no user identity, any client can create a transfer
  and anyone with a `quoteId` could consume it. In production, quotes and
  transfers would be scoped to the authenticated user (token), and `sub`
  would come from the token, never the body. **This is gap #1 to close
  after the slice.**
- KYC/AML, fraud detection, per-user regulatory limits, encryption of PII
  at rest.

## Acceptance criteria
- **CA-S1:** A `POST /transfers` with tampered amounts in the body
  produces a transfer with the stored quote's values (not the body's).
- **CA-S2:** A quote with an invalid/altered HMAC signature → an integrity
  `409`/`400`, no transfer is created.
- **CA-S3:** The client rejects a non-localhost `http` URL in prod (TLS
  mandatory). (Cert pinning deferred — see Plane 1.)
- **CA-S4:** A 500 never returns a stack trace or internals; it responds
  with the curated envelope and logs separately.
- **CA-S5:** CORS in prod only allows origins from the allowlist; the
  rate-limiter responds `429` when exceeded.
