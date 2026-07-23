# backend — reglas (Node/TS)

Reglas específicas del backend. Cross-cutting (dinero, idempotencia) y contrato:
ver [/CLAUDE.md](../CLAUDE.md) y [/.specs/features/mxn-usd-transfer.md](../.specs/features/mxn-usd-transfer.md).

## Arquitectura — hexagonal-light
Dependencias hacia adentro: `infrastructure → application → domain`. Árbol en § Arquitectura del spec.
- `domain/` es PURO: no importa Express, `http`, ni nada de I/O. Solo VOs, entities, reglas y **ports**
  (interfaces `RateProvider`, `Repository`).
- `application/` orquesta use cases y devuelve `Result<T, AppError>`. No arma respuestas HTTP.
- `infrastructure/` implementa los ports (Frankfurter/stub, repos in-memory) y expone los handlers.
- `shared/` = `Result`, tipos de error, config.

## Handlers finos
Un handler: parsea el input (Zod) → llama al use case → mapea el `Result` a HTTP con un helper.
Sin lógica de negocio, validación de dominio, ni storage en el handler.

## Errores como valor
Use cases devuelven `Result<T, AppError>`; el camino de fallo esperado va por `err(...)`, nunca `throw`.
`try/catch` permitido solo en (a) el borde del handler (mapear lo inesperado a 500) y (b) side-effects
best-effort con `logger.warn`. Nada de `catch` que trague el error sin log ni transformación.

## Validación e input
- Zod en el borde. `amount` del query se valida y se escala a centavos antes de tocar el dominio.
- Códigos de error como unión cerrada `as const` (no strings mágicos). Envelope consistente:
  `{ error: { code, message, field? } }`.

## TypeScript
- TS strict, sin `any` (usar `unknown` + narrow). `as` solo tras validación real.
- Money en minor units enteros (ver invariante cross-cutting). El wire transporta enteros, no decimales.

## Storage
In-memory detrás del port `Repository` (swappable a DB después). Estado: maps de quotes, transfers,
idempotency keys, y quotes usadas. Caché de rate con TTL (sobre el port `Clock`).

## Seguridad (ver [/.specs/features/security.md](../.specs/features/security.md))
helmet + CORS allowlist (no wildcard) + express-rate-limit + límite de body + pino con redacción.
Errores nunca filtran stack traces/internals: solo el envelope curado; los 500 se loguean, no se exponen.
El monto no es editable: el cliente manda solo `quoteId`; el BE recalcula desde la quote guardada y
valida su firma **HMAC** (secret server-side, nunca al cliente). Determinismo vía port `Clock`.
