# app — rules (Flutter/Dart)

Frontend-specific rules. Cross-cutting invariants (money, idempotency) and
the contract: see [/CLAUDE.md](../CLAUDE.md) and
[/.specs/features/mxn-usd-transfer.md](../.specs/features/mxn-usd-transfer.md).

## Architecture — Clean Arch domain-first, feature-first
One `transfer` feature with `domain / data / presentation` + `core/`. Tree
in the spec's § Architecture.
- `domain/` never imports `data` or Flutter: entities, `TransferRepository`
  (interface), use cases.
- `data/` — DTOs, HTTP datasources, mappers, `TransferRepositoryImpl`. DTOs
  live **only** here.
- `presentation/` — Riverpod providers, pages, widgets. Never jumps
  straight to `data`.

## State — Riverpod 3.0 with code generation
- `@riverpod` for providers/notifiers. `ref.watch` in `build`, `ref.read`
  in callbacks.
- Transformation logic in derived providers, not in `build`.
- **Never** mutate a provider **synchronously** in
  `initState`/`didChangeDependencies`/`build`/`dispose` (it crashes: "modify
  a provider while the widget tree was building"). Defer with
  `addPostFrameCallback` (guarded by `mounted`) or register the listener in
  the controller's constructor.
- `AsyncValue` maps to loading / error / data.

## Money and the contract
- Rate/fee/USD come from the backend and get mapped to `Money` in `data/`.
  The client **never** recomputes the rate or operates on money with
  `double`.

## Widgets and states
- Widgets are always classes (`StatelessWidget`/`StatefulWidget`), **never**
  a `Widget _buildX()` method.
- ALWAYS handle: loading, network error, invalid/zero/negative input,
  expired quote. Each state gets its own identity (loading/error/expired/
  success) in its own widget.
- Double-submit barrier on confirm (`isSubmitting` + disabled button).

## Errors
A custom `Result<T>` (sealed class `Ok`/`Err`) — no fpdart. `try/catch`
only in the datasource (the boundary).

## UI foundation — design system, i18n, theming (see [/.specs/features/frontend-foundation.md](../.specs/features/frontend-foundation.md))
- Consume the DS from `core/design_system/` (tokens + `AppButton`/
  `AppTextField`/`AppCard`/`AppMoneyText`… widgets). Zero magic numbers/hex
  in widgets: everything comes from tokens or the `ThemeExtension`.
- **i18n with slang:** zero hardcoded UI strings; every string comes from
  `t.*`. Backend errors are translated by `code`, never the raw wire
  `message`. Locales today: `en` + `es` (extensible with a single file).
- **Theming:** light/dark from `ColorScheme.fromSeed` + the `AppColors`
  ThemeExtension (positive/negative/warning). `ThemeMode.system` by default
  + a toggle. Colors always come from the theme, never inline hex.

## Security (see [/.specs/features/security.md](../.specs/features/security.md))
No secrets on the client. TLS mandatory in prod (reject non-localhost
`http`); **certificate pinning deferred** (a conscious decision given the
evaluation window — see the spec). Client-side validation is UX, not the
boundary: the backend is the authority. Obfuscated release build.
