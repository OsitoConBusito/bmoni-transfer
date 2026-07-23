# Spec: frontend-foundation — design system, i18n y theming

> Estado: DRAFT
> Última revisión: 2026-07-22
> Cross-cutting del app Flutter. La feature `transfer` consume esta base.
> Contrato de negocio: ver [mxn-usd-transfer.md](mxn-usd-transfer.md).

---

## Objetivo

Base de UI consistente para el app: un **design system mínimo** (tokens + widgets),
**i18n** (inglés + español, extensible a cualquier idioma) y **tema claro/oscuro**.
Principio: consistente y usable, no pixel-perfect (alineado con el brief).

## Fuera de alcance
- Componentes ricos (empty states, shimmers, dialogs, banners) más allá de lo que usan las
  3 pantallas de `transfer`.
- Traducción a idiomas de Nigeria **hoy** (la infra los soporta; se agregan añadiendo un archivo
  de traducción — ver Backlog). BMONI opera el corredor Nigeria↔; queda listo para localizar.

---

## Design system (`core/design_system/`)

### Tokens (`tokens/`)
Constantes semánticas, única fuente de verdad. Nada de magic numbers/hex en widgets.
- **Spacing:** escala `AppSpacing` (`xs 4, sm 8, md 16, lg 24, xl 32`).
- **Radii:** `AppRadii` (`sm 8, md 12, lg 16`).
- **Typography:** `AppTypography` — deriva del `TextTheme` de Material 3; roles nombrados
  (`amountDisplay`, `rateCaption`, `bodyLabel`).
- **Semantic colors:** viven en un `ThemeExtension` (ver Theming), no como constantes sueltas.

### Widgets (`widgets/`)
Set mínimo reutilizable, todos widgets-como-clase:
- `AppScaffold` — padding y estructura consistentes.
- `AppButton` — primario/secundario, con estado `isLoading`/`isEnabled` (soporta la barrera de doble-submit).
- `AppTextField` — input con label, error inline y `keyboardType` numérico para el monto.
- `AppCard` — contenedor del desglose de la quote.
- `AppMoneyText` — renderiza un `Money` con `intl` según su `Currency` (MXN→es_MX, USD→en_US);
  usa el color semántico (positive/negative) cuando aplica. **Nunca** se concatena dinero a mano.
- Estados: `AppLoading`, `AppErrorState` (con reintento) — usados por los estados del spec de transfer.

---

## i18n (`slang`)

- **slang** (type-safe, sin `BuildContext`): traducciones en `lib/i18n/*.i18n.json`, acceso `t.x.y`.
- **Locales hoy:** `en` (base) + `es`. Agregar un idioma = agregar `strings_<locale>.i18n.json` +
  regenerar; cero cambios de código. Documentar en README cómo sumar (ej. `pcm`, `yo`, `ha`, `ig`).
- **Cambio de idioma en runtime** vía provider Riverpod (`localeProvider`); default = locale del dispositivo
  con fallback a `en`.
- **Regla dura:** cero strings de UI hardcodeados; todo texto visible sale de `t.*`. Los mensajes de
  error del BE se mapean por `code` a una clave de i18n (no se muestra el `message` crudo del wire).

---

## Branding BMONI (assets reales)

Assets oficiales en `app/assets/brand/` (descargados de bmoni.com): `bmoni-logo.webp`,
`bmoni-logo-white.webp` (para fondos oscuros), `bmoni-favicon.png` (1032², base del ícono de app).
**Paleta de marca** (extraída del sitio) — familia púrpura/magenta:
- `brandMagenta #C94CD7` (seed principal) · `brandDeep #370E36` (base oscura) ·
  `brandLavender #D8B4D7` · `brandPink #FDA9FF` · `brandStrong #B001B0`.
Uso como homenaje/prototipo para el take-home (entregable a la propia BMONI), no producción.

## Theming (`core/theme/`)

- `ThemeData` claro y oscuro desde **`ColorScheme.fromSeed(seedColor: brandMagenta)`** — M3.
  (Si Claude Design entrega tokens afinados, reemplazan estos valores.)
- **`AppColors` (ThemeExtension)** con los colores semánticos que M3 no cubre:
  `positive` (recibe USD), `negative`/`fee`, `warning` (quote por expirar). Se resuelven por brillo
  del tema; los widgets leen `Theme.of(context).extension<AppColors>()`, nunca hex.
- **`ThemeMode`**: default `system` (sigue el SO) + toggle manual vía provider Riverpod (`themeModeProvider`).
- Ambos temas deben verse correctos; el countdown de expiración usa `warning`, el USD recibido `positive`.

---

## Criterios de aceptación
- **CA-F1:** Cambiar el locale (es↔en) traduce todo el texto visible; no queda ningún string hardcodeado.
- **CA-F2:** Agregar un locale nuevo requiere solo un archivo de traducción (sin tocar widgets).
- **CA-F3:** En tema oscuro, todos los colores (incl. semánticos de dinero) se resuelven legibles;
  el toggle cambia el tema en runtime y `system` sigue al SO.
- **CA-F4:** `AppMoneyText` formatea MXN (`$1,000.00` es_MX) y USD (en_US) vía `intl`, no a mano.
- **CA-F5:** Los mensajes de error del BE se muestran traducidos por `code`, nunca el `message` crudo.

## Backlog / iteración futura
- Localización a idiomas de Nigeria (Nigerian Pidgin `pcm`, Yoruba `yo`, Hausa `ha`, Igbo `ig`):
  solo agregar los archivos de traducción; la infra ya lo soporta. Relevante para el corredor real de BMONI.
- Componentes DS adicionales si crecen las pantallas.
