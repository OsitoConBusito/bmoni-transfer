# bmoni-transfer — reglas del proyecto

Slice vertical MXN → USD: backend Node/TS (`backend/`) + app Flutter (`app/`).
Contrato y decisiones en [.specs/features/mxn-usd-transfer.md](.specs/features/mxn-usd-transfer.md).
El spec es la fuente de verdad; si el código lo contradice, se corrige el spec primero.

Las reglas globales de Clean Code (~/.claude/CLAUDE.md) aplican. Aquí van solo las
**invariantes duras específicas de bmoni** — son las que el dominio de remesas castiga.

## Gitflow — TBD
- Trunk-Based Development sobre `main`. Commits pequeños y atómicos con Conventional Commits
  (`feat(be):`, `feat(app):`, `chore:`, `docs:`, `test:`). Ramas de vida muy corta solo si hace falta.

## Dinero (INVARIANTE — la evaluación lo castiga)
- **Nunca** `float`/`double`/`number` decimal para dinero. Todo pasa por el value object `Money`
  en minor units enteros (centavos MXN, cents USD). Construir `Money` desde un decimal solo por
  el factory que valida que sea entero tras escalar.
- El wire (JSON) transporta minor units enteros + `currency`, no decimales.
- Redondeo **half-up**, aplicado **una sola vez** en el borde (materializar el USD). Scale alto
  durante el cálculo `(amount − fee) * rate`; prohibido redondear dos veces (doble redondeo).
- El **rate nunca se hardcodea en el cliente**: viene del BE (`RateProvider`).

## Idempotencia (INVARIANTE — retry-safe)
- `POST /transfers` debe ser seguro de llamar dos veces. Tres capas: quote single-use +
  `Idempotency-Key` header + barrera de doble-submit en Flutter. Ver § Idempotencia del spec.
- El BE nunca confía en dinero enviado por el cliente: recupera la quote y recalcula.

## Backend (Node/TS)
- Express + Zod. Validación de input con Zod en el borde; errores tipados con envelope
  `{ error: { code, message, field? } }`. Códigos de error como unión cerrada de string-literals
  (`as const`), nunca strings mágicos sueltos.
- **Errores como valor** en la lógica (Result/discriminated union), no `throw` como control de flujo.
  `try/catch` solo en el borde del handler (mapear lo inesperado a 500) o side-effects best-effort con log.
- Storage in-memory detrás de una interfaz de repositorio (swappable a DB luego). Sin `any` (usar `unknown` + narrow).
- TS strict. Handlers finos: parsear → validar → caso de uso → mapear Result a HTTP.

## Frontend (Flutter)
- **Riverpod 3.0 con code generation** (`@riverpod`). `ref.watch` en `build`, `ref.read` en callbacks.
  Nunca mutar un provider síncronamente en `initState`/`build` (crashea). `AsyncValue` → loading/error/data.
- Clean Arch domain-first: `domain` no importa `data` ni Flutter. Dinero del BE se mapea a `Money`
  en `data/`, nunca se re-calcula el rate en el cliente.
- Widgets siempre como clase (`StatelessWidget`/`StatefulWidget`), nunca `Widget _buildX()`.
  Estados de UI (loading/error/data/expired) cada uno en su widget.
- Manejar SIEMPRE: loading, network error, input inválido/cero/negativo, quote expirada.

## Review
Antes de commitear una unidad de trabajo, correr el reviewer correspondiente sobre el diff:
`ts-reviewer` (backend) / `flutter-reviewer` (app). Read-only, reportan hallazgos.
