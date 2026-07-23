# Spec: mxn-usd-transfer — quote y confirmación de transferencia MXN → USD

> Estado: DRAFT
> Última revisión: 2026-07-22
> Contexto: take-home de BMONI (slice vertical, 2-3h). El spec es el contrato:
> si el código lo contradice, se corrige el spec primero, luego el código.

---

## Objetivo

Permitir a un usuario en México cotizar y confirmar una transferencia **MXN → USD**:
teclea un monto en MXN, ve en vivo el equivalente en USD, el tipo de cambio y el fee,
revisa un desglose y confirma. El backend provee el rate y registra la transferencia
de forma **retry-safe** (llamar dos veces no crea dos transferencias).

---

## Fuera de alcance (no gastar tiempo)

Auth, pagos reales, KYC real, base de datos, y diseño pixel-perfect. Storage en memoria.
Solo la dirección MXN → USD (no USD → MXN). Un solo par de divisas.

---

## Las dos cosas que este dominio castiga (foco de la evaluación)

1. **Representación de dinero:** cómo se guarda y redondea MXN/USD. → ver § Modelo de dinero.
2. **Transferencia retry-safe:** `POST /transfers` dos veces no debe doble-cobrar. → ver § Idempotencia.

---

## Arquitectura

Principio: arquitectura **intencional pero calibrada al slice** — capas reales, cero ceremonia.
El acoplamiento va hacia adentro (infra → application → domain); domain no conoce Express, HTTP
ni Flutter. Errores como valor con un `Result<T,E>` propio (hand-rolled, sin dependencia) en ambos
lados; `try/catch` solo en el borde. Ver reglas en [/CLAUDE.md](../../CLAUDE.md).

### Backend — Hexagonal-light (ports & adapters)
```
backend/src/
├── domain/            money, rate, quote, transfer, fee; ports/ (RateProvider, Repository, Clock)
├── application/       get-quote.use-case, create-transfer.use-case  (devuelven Result)
├── infrastructure/    http/ (handlers, router, error-map, pino) · rate/ (frankfurter, stub, cached) · persistence/ (in-memory) · clock/ (system, fake)
└── shared/            Result, errors, config
```
Los **puertos** (`RateProvider`, `Repository`) hacen swappable el rate (stub↔real) y el storage
(memoria↔DB) sin tocar el dominio. Handlers finos: parse+Zod → use case → map `Result` a HTTP.

### Frontend — Clean Arch domain-first, feature-first (una feature `transfer`)
```
app/lib/
├── core/                       Money, Result, http client, env/config
└── features/transfer/
    ├── domain/        entities (money, quote, transfer) · transfer_repository (iface) · usecases
    ├── data/          dtos · datasources (http) · mappers · transfer_repository_impl
    └── presentation/  providers (Riverpod notifiers) · pages (amount_entry, confirmation, result) · widgets (por estado)
```
`domain` no importa `data` ni Flutter. El dinero llega del BE y se mapea a `Money` en `data/`; el
cliente nunca recalcula el rate. Estado con **Riverpod 3.0 codegen**; `AsyncValue` → loading/error/data.

---

## Modelo de dinero (§ crítica)

Enfoque adoptado de dinero.js/decimal.js, implementado en un value object **propio**
(sin dependencia externa — decisión: una lib de dinero es over-kill para 2 divisas).

- **Minor units enteros, nunca floats.** MXN se guarda en **centavos** (`int`), USD en
  **cents** (`int`). El wire (JSON) transporta enteros de minor units, no decimales.
- **Scale alto durante el cálculo, redondeo una sola vez en el borde.** La multiplicación
  `MXN * rate` y el `1%` del fee producen fracciones. Se opera con precisión extendida y se
  **redondea half-up a la unidad mínima destino exactamente una vez**, al materializar el USD.
  Esto evita el sesgo por doble redondeo.
- **Modo de redondeo: half-up** (0.5 sube). Documentado y testeado. Aplica al monto USD final
  y al componente porcentual del fee.
- **Dirección del redondeo:** el fee y el redondeo nunca favorecen al cliente de forma que
  descuadre la cuenta; half-up es simétrico y explícito.

### Fundamento regulatorio (respaldo de la decisión)
- **Ley Monetaria de los Estados Unidos Mexicanos:** el redondeo a múltiplos de 5 centavos aplica
  **solo a efectivo**; los pagos que no implican entrega de efectivo se hacen por el **monto exacto**.
  Una transferencia digital es no-efectivo → operamos en **centavos/cents exactos, sin redondeo a
  5 centavos**. half-up al mínimo divisible es consistente con "monto exacto".
- **Tipo de cambio Banxico (FIX):** se publica a **4 decimales**, en dirección USD/MXN (pesos por
  dólar). Usamos MXN→USD (inverso), que requiere más decimales; guardamos el rate a la precisión de
  la fuente. Ruta a rate oficial: tomar el FIX como USD/MXN a 4 decimales e invertir. (Hoy: Frankfurter/ECB.)

### Value object `Money` (ambos lados, espejo conceptual)
| Prop | Tipo | Nota |
|---|---|---|
| `minorUnits` | `int` | Cantidad en la unidad mínima (centavos MXN / cents USD) |
| `currency` | `Currency` enum | `MXN` \| `USD` (define el exponente: 2) |

Operaciones: `fromMajor(decimal)` (valida entero tras escalar), `toMajor()` (solo display),
`applyRate(rate, targetCurrency)` (scale alto → round half-up), `plus`/`minus` (misma divisa).
Prohibido construir `Money` desde un `double` sin pasar por el factory que valida.

---

## Dominio

### Enums
- `Currency { MXN, USD }` — exponente 2 para ambas.
- `TransferStatus { PENDING, COMPLETED, FAILED, EXPIRED }`.

### Entidad `Quote`
| Campo | Tipo | Nota |
|---|---|---|
| `id` | `string` (uuid) | Generado por el BE |
| `sourceAmount` | `Money(MXN)` | Monto que teclea el usuario |
| `rate` | `Rate` | Rate MXN→USD usado (ver § Rate) |
| `fee` | `Money(MXN)` | Fee escalonado (ver § Fee) |
| `destAmount` | `Money(USD)` | `(sourceAmount − fee) * rate`, redondeado half-up |
| `createdAt` | `timestamp` | |
| `expiresAt` | `timestamp` | `createdAt + 60s` |

Getter: `isExpired(now) => now >= expiresAt`.

### Entidad `Transfer`
| Campo | Tipo | Nota |
|---|---|---|
| `id` | `string` (uuid) | |
| `quoteId` | `string` | La quote que consumió |
| `sourceAmount` / `destAmount` / `fee` / `rate` | (snapshot) | Copiados de la quote al crear (inmutables) |
| `status` | `TransferStatus` | |
| `idempotencyKey` | `string` | Key con la que se creó |
| `createdAt` | `timestamp` | |

### `Rate` (value object)
| Campo | Tipo | Nota |
|---|---|---|
| `value` | `decimal` (string en wire) | MXN→USD, ej. `0.05739` |
| `source` | `string` | `frankfurter` \| `stub` |
| `asOf` | `date` | Fecha del rate (ECB da rate diario) |

---

## Reglas de negocio

### § Rate (el rate NO se hardcodea en el cliente)
- El backend expone el rate; el cliente **nunca** lo calcula ni lo hardcodea.
- Fuente detrás de una interfaz `RateProvider`, seleccionable por env `RATE_PROVIDER`:
  - `FrankfurterRateProvider` (default) → `GET https://api.frankfurter.dev/v1/latest?base=MXN&symbols=USD` (sin API key, rate ECB diario).
  - `StubRateProvider` → rate fijo determinista (tests y fallback).
- **Caché en memoria con TTL** del rate: el quote no dispara una llamada de red por request.
- **Fallback:** si Frankfurter falla y no hay rate cacheado válido → responder `503`
  con error accionable (no inventar un rate). El frontend trata 503 como "network error" reintentar.

### § Fee escalonado (flat + porcentual)
Parámetros (defaults; configurables por env):
- `FEE_FLAT_MXN = 20.00` (2000 centavos)
- `FEE_THRESHOLD_MXN = 5000.00` (500000 centavos)
- `FEE_PERCENT = 0.01` (1%)

Regla:
```
fee = FEE_FLAT
if sourceAmount > FEE_THRESHOLD:
    fee += FEE_PERCENT * sourceAmount   (redondeado half-up a centavos)
```
Ejemplos: 500 MXN→20 · 5 000→20 · 10 000→120 · 50 000→520.
El `destAmount` se calcula sobre `(sourceAmount − fee)` (el fee se deduce del envío).

### § Límites de monto (validación BE)
- `MIN_AMOUNT_MXN = 10.00`, `MAX_AMOUNT_MXN = 100 000.00`.
- Fuera de rango, cero, negativo, no-numérico, o `sourceAmount ≤ fee` → `400` con código accionable.

### § Expiración de quote y determinismo
- TTL = **60s**. `POST /transfers` con una quote expirada → `409 QUOTE_EXPIRED`.
- **Puerto `Clock`** (`now()`) inyectado en vez de `Date.now()` inline: el dominio no toca el reloj
  global. `SystemClock` en prod, `FakeClock` en tests → la expiración se prueba de forma determinista
  sin esperas reales. (Costura que suele faltar cuando se usa `Date.now()` directo.)
- **Caché de rate:** TTL propio (`RATE_CACHE_TTL_MS`, default 60s) sobre el `Clock`. El quote no
  dispara una llamada de red por request; en cold start la primera request llena la caché.

---

## Idempotencia (defensa en profundidad — § crítica)

Tres capas para que `POST /transfers` no doble-cobre:

1. **Quote single-use (clave natural):** cada `quoteId` se consume una vez. Un segundo POST
   con la misma quote (misma idempotency key) devuelve el **mismo** `Transfer` ya creado, `200`.
   Un POST con la misma quote pero **distinta** idempotency key → `409 QUOTE_ALREADY_USED`.
2. **`Idempotency-Key` header (patrón Stripe):** el cliente genera un UUID por intento lógico.
   El BE guarda `key → transferId`. Reintento con la misma key → devuelve el mismo transfer (`200`),
   sin crear otro. Key ausente en `POST /transfers` → `400 IDEMPOTENCY_KEY_REQUIRED`.
3. **Barrera de control en Flutter:** guard de doble-submit (botón deshabilitado + flag
   `isSubmitting` en el notifier) para que un doble-tap no dispare dos requests siquiera.

Reglas de conflicto:
- Misma `Idempotency-Key` + mismo `quoteId` → idempotente, `200` con el transfer existente.
- Misma `Idempotency-Key` + `quoteId` distinto → `409 IDEMPOTENCY_KEY_REUSED` (uso indebido).

---

## Contrato de la API

Base path: **`/api/v1`** (versionado). Todos los paths de abajo cuelgan de ahí
(ej. `GET /api/v1/quote`). Además `GET /health` → `200 { status: "ok" }` (sin versionar).
CORS habilitado (permite correr el Flutter en web). Logger estructurado **pino** (nunca `console.log`).

### `GET /quote?amount=<MXN major>`
`amount` en unidades mayores (ej. `1000.50`). El BE lo escala a centavos y valida.

**200:**
```json
{
  "quoteId": "uuid",
  "sourceAmount": { "minorUnits": 100050, "currency": "MXN" },
  "fee":          { "minorUnits": 2000,   "currency": "MXN" },
  "destAmount":   { "minorUnits": 5624,   "currency": "USD" },
  "rate": { "value": "0.05739", "source": "frankfurter", "asOf": "2026-07-22" },
  "expiresAt": "2026-07-22T19:00:60Z"
}
```
**Errores:** `400` (`AMOUNT_REQUIRED`, `AMOUNT_NOT_NUMERIC`, `AMOUNT_TOO_LOW`, `AMOUNT_TOO_HIGH`,
`AMOUNT_NOT_POSITIVE`, `AMOUNT_BELOW_FEE`), `503 RATE_UNAVAILABLE`.
`AMOUNT_BELOW_FEE`: el monto no cubre el fee (`sourceAmount ≤ fee`) — posible porque el mínimo
(10 MXN) es menor que el fee flat (20 MXN); sin esto el `destAmount` sería negativo.

### `POST /transfers`
Headers: `Idempotency-Key: <uuid>` (requerido).
```json
{ "quoteId": "uuid" }
```
El body **solo** lleva `quoteId`. El BE recupera la quote guardada, verifica expiración, y
**recalcula/usa sus propios** valores de rate/USD/fee. Nunca confía en dinero enviado por el cliente.

**201** (creado) / **200** (reintento idempotente):
```json
{
  "transferId": "uuid",
  "status": "COMPLETED",
  "quoteId": "uuid",
  "sourceAmount": { "minorUnits": 100050, "currency": "MXN" },
  "destAmount":   { "minorUnits": 5624,   "currency": "USD" },
  "fee":          { "minorUnits": 2000,   "currency": "MXN" },
  "createdAt": "2026-07-22T19:00:30Z"
}
```
**Errores:** `400` (`IDEMPOTENCY_KEY_REQUIRED`, `QUOTE_ID_REQUIRED`), `404 QUOTE_NOT_FOUND`,
`409` (`QUOTE_EXPIRED`, `QUOTE_ALREADY_USED`, `IDEMPOTENCY_KEY_REUSED`).

### Envelope de error (consistente)
```json
{ "error": { "code": "AMOUNT_TOO_HIGH", "message": "Amount 150000 MXN exceeds max 100000 MXN", "field": "amount" } }
```

---

## Estado del backend (in-memory)
- `Map<quoteId, Quote>`, `Map<transferId, Transfer>`, `Map<idempotencyKey, transferId>`,
  `Set<usedQuoteId>`. Sin DB. La caché de rate es un objeto `{ rate, cachedAt }` con TTL.

---

## Frontend — estados y flujo

Pantallas: **AmountEntry** → **Confirmation** → **Result**.

### AmountEntry
- Input MXN numérico; al teclear con **debounce ~400ms** llama `GET /quote` → muestra USD, rate, fee
  en vivo. Cada request cancela la anterior (evita respuestas fuera de orden).
- **Formato de dinero con `intl`:** MXN en locale `es_MX` (`$1,000.00`), USD en `en_US`. Nunca
  concatenar strings de dinero a mano; el display sale de `Money.toMajor()` formateado por `intl`.
- Estados: `idle` · `loading` (cotizando) · `data` (quote válida) · `error`
  (network/`RATE_UNAVAILABLE` → reintentar) · `invalid` (0/negativo/fuera de rango → mensaje inline).

### Confirmation
- Desglose claro: envías X MXN · fee · rate · recibe Y USD · expira en NN s (countdown).
- Si la quote expira antes de confirmar → estado **expired** con CTA "Volver a cotizar".
- Confirmar → guard de doble-submit → `POST /transfers` con `Idempotency-Key` generada al entrar
  a la confirmación (estable ante reintentos del mismo intento lógico).

### Result
- `success` (status COMPLETED/PENDING) con resumen · `failure` (network/409 expired/FAILED)
  con causa accionable y reintento.

### State management
- **Riverpod 3.0 con code generation** (`@riverpod`). `AsyncValue` mapea directo a loading/error/data.
- Notifier de quote (debounce + cancelación de la request anterior) y notifier de transfer
  (con `isSubmitting` para la barrera de doble-submit). Providers testeables con overrides.

---

## Criterios de aceptación

### Backend — quote
- **CA-1:** `GET /quote?amount=1000` → 200 con `destAmount` = `(1000 − fee) * rate` en cents USD, half-up.
- **CA-2:** `amount=5000` → fee 20 MXN; `amount=10000` → fee 120 MXN (flat + 1%).
- **CA-3:** `amount=0` / negativo / no numérico → 400 con el código correspondiente.
- **CA-4:** `amount=5` (< min) → 400 `AMOUNT_TOO_LOW`; `amount=150000` → 400 `AMOUNT_TOO_HIGH`.
- **CA-5:** El rate proviene del `RateProvider` (no hardcodeado); con `RATE_PROVIDER=stub` es determinista.
- **CA-6:** Provider real caído y sin caché → 503 `RATE_UNAVAILABLE` (no inventa rate).

### Backend — transfer / idempotencia
- **CA-7:** `POST /transfers` con quote válida + key → 201 con status y snapshot de montos.
- **CA-8 (retry-safe):** dos POST idénticos (misma key, mismo quoteId) → un solo Transfer; el 2º
  devuelve 200 con el mismo `transferId`. **Nunca** se crean dos.
- **CA-9:** POST con quote expirada → 409 `QUOTE_EXPIRED`.
- **CA-10:** POST sin `Idempotency-Key` → 400 `IDEMPOTENCY_KEY_REQUIRED`.
- **CA-11:** Misma key con `quoteId` distinto → 409 `IDEMPOTENCY_KEY_REUSED`.
- **CA-12:** El body con rate/fee/USD manipulados se ignora; el BE usa los valores de la quote.
- **CA-13:** `quoteId` inexistente → 404 `QUOTE_NOT_FOUND`.

### Money
- **CA-14:** Ninguna operación de dinero usa `float`/`double` directo; todo pasa por `Money`.
- **CA-15:** Doble redondeo evitado: `(amount−fee)*rate` se redondea half-up **una sola vez**.

### Frontend
- **CA-16:** Al teclear un monto válido (debounce), se ve USD/rate/fee de la quote en vivo.
- **CA-17:** Monto 0/negativo/fuera de rango → mensaje inline, sin llamar al BE innecesariamente.
- **CA-18:** Error de red al cotizar → estado error con reintento.
- **CA-19:** Quote expirada en Confirmation → estado expired con "Volver a cotizar".
- **CA-20:** Doble-tap en Confirmar → una sola llamada a `POST /transfers` (barrera de control).

---

## Estrategia de tests (presupuesto concentrado donde el dominio castiga)

No cobertura pareja; foco en las dos cosas evaluadas + los caminos de fallo.
- **Backend (Vitest):** `Money` VO exhaustivo (half-up, sin doble redondeo, rechazo de floats) ·
  fee escalonado (los ejemplos de CA-2) · idempotencia (CA-8: dos POST = un transfer; CA-9/10/11) ·
  use cases con `FakeClock` + `StubRateProvider` (expiración determinista) · un puñado de tests de
  integración de los endpoints (supertest) para el contrato HTTP.
- **Frontend (flutter_test + mocktail):** widget/notifier tests de los estados que el spec exige
  (CA-17 inválido, CA-19 expirada, CA-20 doble-submit) + mapeo DTO→`Money`.
- Trazabilidad: anotar `// CA-N` en los tests para cerrar spec→test.

## Backlog / iteración futura (fuera del scope 2-3h)
- **`contract-checker` agent (BE↔FE):** verificar que el contrato de la API (códigos de error,
  shapes de DTO, envelope) no driftee entre el backend TS y el cliente Flutter. Ideal cuando el
  contrato crezca; hoy es un solo par de endpoints y se mantiene a mano contra este spec.
- Persistencia real (DB) + más pares de divisas + selección de dirección USD↔MXN.
- Webhook/estado asíncrono real del transfer (hoy PENDING→COMPLETED es inmediato).
