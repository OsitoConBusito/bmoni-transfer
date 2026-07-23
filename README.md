# bmoni-transfer

Slice vertical **MXN → USD**: cotizar y confirmar una transferencia de forma
**retry-safe**. Backend Node/TS (`backend/`) + app Flutter (`app/`).

- **El contrato** (endpoints, entidades, reglas de negocio, criterios de aceptación)
  vive en [.specs/features/mxn-usd-transfer.md](.specs/features/mxn-usd-transfer.md) — fuente de verdad.
- **El porqué** de cada decisión técnica está en [DECISIONS.txt](DECISIONS.txt).

---

## Requisitos

| Herramienta | Versión usada |
|---|---|
| Node    | ≥ 22 (LTS, ESM) |
| Flutter | 3.44.x (stable) — Dart 3.9 |

No hace falta base de datos: el estado del backend es in-memory detrás de un puerto
de repositorio (swappable a DB después).

---

## Backend (`backend/`)

```bash
cd backend
npm install
npm run dev          # tsx watch — http://localhost:3000
```

Verificación rápida:

```bash
curl http://localhost:3000/health                     # {"status":"ok"}
curl "http://localhost:3000/api/v1/quote?amount=1000" # cotización MXN→USD
```

Scripts:

| Script | Qué hace |
|---|---|
| `npm run dev`       | Servidor en watch mode (tsx), sin build |
| `npm run build`     | Compila TS a `dist/` (tsc) |
| `npm start`         | Corre el build (`node dist/main.js`) — usado en prod |
| `npm test`          | Suite Vitest (unit + integración con supertest) |
| `npm run typecheck` | `tsc --noEmit` |
| `npm run lint`      | Biome check |

### Configuración (env vars)

Todas tienen default seguro para desarrollo; el server valida con Zod al arrancar y
**falla rápido** si algo es inválido. Los montos se declaran en unidades mayores (MXN)
y se convierten a centavos al entrar al dominio.

| Var | Default | Nota |
|---|---|---|
| `PORT`             | `3000` | |
| `NODE_ENV`         | `development` | En `production` se exige `HMAC_SECRET` no-default |
| `CORS_ALLOWLIST`   | `http://localhost:8080` | Orígenes separados por coma (sin wildcard) |
| `RATE_PROVIDER`    | `frankfurter` | `frankfurter` (ECB, sin API key) o `stub` (determinista) |
| `RATE_CACHE_TTL_MS`| `60000` | TTL de la caché de rate en memoria |
| `QUOTE_TTL_MS`     | `60000` | Vigencia de una cotización |
| `FEE_FLAT_MXN`     | `20` | Fee plano bajo el umbral |
| `FEE_THRESHOLD_MXN`| `5000` | Sobre este monto aplica fee porcentual |
| `FEE_PERCENT`      | `0.01` | 1% sobre el umbral |
| `MIN_AMOUNT_MXN`   | `10` | |
| `MAX_AMOUNT_MXN`   | `100000` | |
| `HMAC_SECRET`      | *(dev fallback)* | **Obligatorio** en producción — firma la quote |

---

## App Flutter (`app/`)

```bash
cd app
flutter pub get
flutter run          # apunta al backend local por defecto
```

El endpoint del backend se inyecta en build-time con `--dart-define BASE_URL`.
El **default es `http://10.0.2.2:3000`** (loopback del host desde el emulador Android),
así que `flutter run` a secas ya habla con el backend local corriendo en tu máquina.

| Escenario | Comando |
|---|---|
| Emulador Android → backend local | `flutter run` (default `10.0.2.2:3000`) |
| iOS simulator / desktop → backend local | `flutter run --dart-define BASE_URL=http://localhost:3000` |
| Dispositivo físico → backend en tu LAN | `flutter run --dart-define BASE_URL=http://<IP-de-tu-máquina>:3000` |
| Contra el backend desplegado | `flutter run --dart-define BASE_URL=https://<prod-url>` |

Tests y análisis:

```bash
flutter analyze
flutter test
```

### APK de release

El binario release va ofuscado y apunta al backend de producción:

```bash
flutter build apk --release \
  --dart-define BASE_URL=https://<prod-url> \
  --obfuscate --split-debug-info=build/symbols
```

El APK firmado se distribuye por **GitHub Releases** de este repo.

---

## API (resumen)

Base path: `/api/v1`. Detalle completo y criterios de aceptación en el
[spec](.specs/features/mxn-usd-transfer.md).

| Método | Path | Descripción |
|---|---|---|
| `GET`  | `/health` | Liveness → `{ "status": "ok" }` |
| `GET`  | `/api/v1/quote?amount=<MXN>` | Cotiza; devuelve `quoteId`, desglose y `expiresAt` |
| `POST` | `/api/v1/transfers` | Confirma. Header `Idempotency-Key` **requerido**; body solo `{ "quoteId" }` |

El dinero viaja como **enteros en minor units** (`{ minorUnits, currency }`), nunca
como decimales. El cliente **nunca** envía ni recalcula rate/fee/USD: manda solo el
`quoteId` y el backend recalcula desde la quote guardada (ver [DECISIONS.txt](DECISIONS.txt)).

---

## Estructura

```
bmoni-transfer/
├── backend/   Node/TS — hexagonal-light (domain / application / infrastructure)
├── app/       Flutter — Clean Arch feature-first (transfer: domain / data / presentation) + core + shared
└── .specs/    Spec SDD (fuente de verdad del contrato)
```
