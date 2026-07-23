# app — reglas (Flutter/Dart)

Reglas específicas del frontend. Cross-cutting (dinero, idempotencia) y contrato:
ver [/CLAUDE.md](../CLAUDE.md) y [/.specs/features/mxn-usd-transfer.md](../.specs/features/mxn-usd-transfer.md).

## Arquitectura — Clean Arch domain-first, feature-first
Una feature `transfer` con `domain / data / presentation` + `core/`. Árbol en § Arquitectura del spec.
- `domain/` no importa `data` ni Flutter: entities, `TransferRepository` (interface), use cases.
- `data/` DTOs, datasources HTTP, mappers, `TransferRepositoryImpl`. Los DTOs viven **solo** aquí.
- `presentation/` providers Riverpod, pages, widgets. No salta a `data` directo.

## Estado — Riverpod 3.0 con code generation
- `@riverpod` para providers/notifiers. `ref.watch` en `build`, `ref.read` en callbacks.
- Lógica de transformación en providers derivados, no en `build`.
- **Nunca** mutar un provider de forma **síncrona** en `initState`/`didChangeDependencies`/`build`/
  `dispose` (crashea: "modify a provider while the widget tree was building"). Diferir con
  `addPostFrameCallback` (guard `mounted`) o registrar el listener en el constructor del controller.
- `AsyncValue` mapea a loading / error / data.

## Dinero y contrato
- El rate/fee/USD llegan del BE y se mapean a `Money` en `data/`. El cliente **nunca** recalcula el
  rate ni opera dinero con `double`.

## Widgets y estados
- Widgets siempre como clase (`StatelessWidget`/`StatefulWidget`), **nunca** `Widget _buildX()`.
- Manejar SIEMPRE: loading, network error, input inválido/cero/negativo, quote expirada. Cada estado
  con identidad (loading/error/expired/success) en su propio widget.
- Barrera de doble-submit al confirmar (`isSubmitting` + botón deshabilitado).

## Errores
`Result<T>` propio (sealed class `Ok`/`Err`) — sin fpdart. `try/catch` solo en el datasource (borde).

## Base de UI — design system, i18n, theming (ver [/.specs/features/frontend-foundation.md](../.specs/features/frontend-foundation.md))
- Consumir el DS de `core/design_system/` (tokens + widgets `AppButton`/`AppTextField`/`AppCard`/
  `AppMoneyText`…). Cero magic numbers/hex en widgets: todo sale de tokens o del `ThemeExtension`.
- **i18n con slang:** cero strings de UI hardcodeados; todo texto de `t.*`. Errores del BE se traducen
  por `code`, nunca el `message` crudo del wire. Locales hoy: `en` + `es` (extensible con solo un archivo).
- **Theming:** claro/oscuro desde `ColorScheme.fromSeed` + `AppColors` ThemeExtension (positive/negative/
  warning). `ThemeMode.system` por defecto + toggle. Colores desde el theme, nunca hex inline.

## Seguridad (ver [/.specs/features/security.md](../.specs/features/security.md))
Sin secretos en el cliente. TLS obligatorio en prod (rechazar `http` no-localhost); **certificate
pinning diferido** (decisión consciente por la ventana de evaluación — ver spec). La validación
client-side es UX, no frontera: el BE es la autoridad. Build release ofuscado.
