# Spec: frontend-foundation — design system, i18n and theming

> Status: DRAFT
> Last reviewed: 2026-07-22
> Cross-cutting for the Flutter app. The `transfer` feature consumes this
> foundation. Business contract: see [mxn-usd-transfer.md](mxn-usd-transfer.md).

---

## Goal

A consistent UI foundation for the app: a **minimal design system** (tokens
+ widgets), **i18n** (English + Spanish, extensible to any language), and a
**light/dark theme**. Principle: consistent and usable, not pixel-perfect
(matching the brief).

## Out of scope
- Rich components (empty states, shimmers, dialogs, banners) beyond what
  the `transfer` feature's 3 screens use.
- Translating into Nigerian languages **today** (the infra supports it; add
  them by adding a translation file — see Backlog). BMONI operates the
  Nigeria corridor, so this stays ready to localize.

---

## Design system (`core/design_system/`)

### Tokens (`tokens/`)
Semantic constants, the single source of truth. No magic numbers/hex in
widgets.
- **Spacing:** the `AppSpacing` scale (`xs 4, sm 8, md 16, lg 24, xl 32`).
- **Radii:** `AppRadii` (`sm 8, md 12, lg 16`).
- **Typography:** `AppTypography` — derives from Material 3's `TextTheme`;
  named roles (`amountDisplay`, `rateCaption`, `bodyLabel`).
- **Semantic colors:** live in a `ThemeExtension` (see Theming), not as
  loose constants.

### Widgets (`widgets/`)
A minimal, reusable set, all widgets-as-classes:
- `AppScaffold` — consistent padding and structure.
- `AppButton` — primary/secondary, with `isLoading`/`isEnabled` state
  (supports the double-submit barrier).
- `AppTextField` — input with a label, inline error, and a numeric
  `keyboardType` for the amount.
- `AppCard` — container for the quote breakdown.
- `AppMoneyText` — renders a `Money` with `intl` per its `Currency`
  (MXN→es_MX, USD→en_US); uses the semantic color (positive/negative) when
  applicable. Money is **never** hand-concatenated.
- States: `AppLoading`, `AppErrorState` (with retry) — used by the
  transfer spec's states.

---

## i18n (`slang`)

- **slang** (type-safe, no `BuildContext`): translations in
  `lib/i18n/*.i18n.json`, accessed via `t.x.y`.
- **Locales today:** `en` (base) + `es`. Adding a language = adding
  `strings_<locale>.i18n.json` + regenerating; zero code changes. Document
  in the README how to add one (e.g. `pcm`, `yo`, `ha`, `ig`).
- **Runtime language switch** via a Riverpod provider (`localeProvider`);
  default = the device's locale, falling back to `en`.
- **Hard rule:** zero hardcoded UI strings; every visible string comes from
  `t.*`. Backend error messages are mapped by `code` to an i18n key (the
  raw wire `message` is never shown).

---

## Source of truth for the UI: the Claude Design mockup

`design/BMONI.dc.html` (imported from the "BMONI remesas fintech UI"
project) is the **authoritative visual reference**. Implemented **without
the onboarding screen** (a user decision). The DS widgets and theme are
derived from its tokens (below).

### Brand assets
`app/assets/brand/`: `bmoni-logo.webp`, `bmoni-logo-white.webp`,
`bmoni-favicon.png` (from bmoni.com). Note: the mockup uses its own
logo-mark (a "b" on a teal gradient). Decide at implementation time between
the mockup's mark and the real logo; both are available.

### Design tokens (extracted from `BMONI.dc.html`) — dark fintech theme, teal accent
- **Fonts:** `Plus Jakarta Sans` (UI/body) + `Space Grotesk` (amount
  display / brand).
- **Accent:** `teal #37C2CB` (primary) · `#5AD3DB` (hover) · `#0F7A82`
  (deep) · `#04262A` (darkest).
- **Surfaces (dark):** `#0B0F14` (base background) · `#12181F` ·
  `#1A222B` · `#1C2530` · `#263039` (cards/borders).
- **Text:** `#F3F5F7` (bright) · `#E7ECF1` (primary) · `#A2AEBB`/`#9AA6B2`
  (secondary) · `#6B7683` (muted).
- **Radii:** cards `12/16/18`, pill `999`, hero `42`. **Money semantics:**
  define `positive` (USD received), `negative`/`fee`, `warning` (expiry)
  from the mockup's palette.

## Theming (`core/theme/`)

- `ThemeData` built from **`ColorScheme.fromSeed(seedColor: teal #37C2CB,
  brightness: dark)`** as the base (the mockup is dark-first) + a light
  variant. An `AppColors` ThemeExtension carries the money semantics. Exact
  values come from `BMONI.dc.html`'s tokens.
- **`AppColors` (ThemeExtension)** with the semantic colors M3 doesn't
  cover: `positive` (USD received), `negative`/`fee`, `warning` (quote
  about to expire). Resolved per theme brightness; widgets read
  `Theme.of(context).extension<AppColors>()`, never raw hex.
- **`ThemeMode`**: defaults to `system` (follows the OS) + a manual toggle
  via a Riverpod provider (`themeModeProvider`).
- Both themes must look correct; the expiry countdown uses `warning`, the
  USD received uses `positive`.

---

## Acceptance criteria
- **CA-F1:** Switching locale (es↔en) translates all visible text; no
  string is left hardcoded.
- **CA-F2:** Adding a new locale requires only a translation file (no
  widget changes).
- **CA-F3:** In dark theme, every color (including money semantics)
  resolves legibly; the toggle switches theme at runtime and `system`
  follows the OS.
- **CA-F4:** `AppMoneyText` formats MXN (`$1,000.00` es_MX) and USD
  (en_US) via `intl`, never by hand.
- **CA-F5:** Backend error messages are shown translated by `code`, never
  the raw `message`.

## Backlog / future iteration
- Localization into Nigerian languages (Nigerian Pidgin `pcm`, Yoruba `yo`,
  Hausa `ha`, Igbo `ig`): just add the translation files; the infra already
  supports it. Relevant to BMONI's real corridor.
- Additional DS components if the screens grow.
