# bmoni-transfer

Slice vertical **MXN → USD**: quote + confirmación de transferencia. Backend Node/TS
(`backend/`) + app Flutter (`app/`). Take-home (2-3h). Las reglas globales de Clean Code
(`~/.claude/CLAUDE.md`) aplican; aquí van solo las invariantes **cross-cutting** de bmoni.

## Mapa de documentación (dónde vive qué)
| Necesitas… | Está en… |
|---|---|
| El contrato: endpoints, entidades, reglas de negocio, arquitectura, CAs | [.specs/features/mxn-usd-transfer.md](.specs/features/mxn-usd-transfer.md) — **fuente de verdad** |
| Reglas del backend (hexagonal, Express+Zod, Result) | [backend/CLAUDE.md](backend/CLAUDE.md) — se auto-carga en `backend/` |
| Reglas del frontend (Riverpod, Clean Arch, widgets) | [app/CLAUDE.md](app/CLAUDE.md) — se auto-carga en `app/` |
| Cómo correr / setup | `README.md` |
| Por qué de las decisiones | `DECISIONS.txt` |

Regla de oro: si algo contradice el spec, **se corrige el spec primero**, luego el código.
No dupliques el spec aquí ni en los CLAUDE.md anidados — apunta a él.

## Invariantes cross-cutting (las dos cosas que el dominio castiga)
Aplican a **ambos** lados; el detalle vive en el spec.

1. **Dinero.** Nunca `float`/`double`/`number` decimal. Todo pasa por el value object `Money`
   en minor units enteros (centavos MXN / cents USD). Redondeo **half-up una sola vez** en el
   borde (sin doble redondeo). El **rate nunca se hardcodea en el cliente**: viene del BE.
2. **Idempotencia (retry-safe).** `POST /transfers` dos veces no crea dos transfers: quote
   single-use + `Idempotency-Key` header + barrera de doble-submit en Flutter. El BE nunca
   confía en dinero del cliente: recupera la quote y recalcula.

## Gitflow — TBD
Trunk-Based sobre `main`. Commits pequeños y atómicos, Conventional Commits
(`feat(be):`, `feat(app):`, `chore:`, `docs:`, `test:`). Ramas de vida muy corta solo si hace falta.

## Review
Antes de commitear una unidad de trabajo, correr el reviewer del lado tocado sobre el diff:
`ts-reviewer` (backend) / `flutter-reviewer` (app). Read-only, reportan hallazgos.
