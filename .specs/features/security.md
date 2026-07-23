# Spec: security — threat model del slice MXN → USD

> Estado: DRAFT
> Última revisión: 2026-07-22
> Cross-cutting. Garantiza que la información viaje segura (app↔BE), que los montos
> no sean editables, y hardening en los tres planos: app, tránsito y backend.
> Contrato de negocio: ver [mxn-usd-transfer.md](mxn-usd-transfer.md).

---

## Alcance y supuestos
Este slice **no** tiene auth/KYC (fuera del brief). El threat model cubre la integridad del
movimiento de dinero, no la identidad del usuario. Donde una defensa depende de identidad, se
documenta como **fuera de alcance explícito** (no como olvido).

**Activos a proteger:** integridad del monto y del rate de una quote, no-duplicación de transfers,
confidencialidad en tránsito, y que el BE no filtre internals.

---

## Plano 1 — En tránsito (app ↔ BE)
- **TLS obligatorio en prod:** el cliente solo habla HTTPS contra el host de prod; rechaza `http`
  no-localhost. **HSTS** en el BE. En **dev** se permite `http://localhost` (sin TLS local, normal).
- **Certificate pinning — DIFERIDO (no implementado).** Decisión consciente: la ventana de
  evaluación es corta (<1 semana) y el host de prod (PaaS) rota su cert Let's Encrypt cada ~60-90
  días, lo que volvería frágil un APK distribuido con pin al cert hoja. TLS + CA pública cubren MITM
  para este scope. Ruta futura: pinning al SPKI del intermedio con backup pin, saltado en localhost.
- **Sin datos sensibles en la URL** más allá del `amount` (no-sensible). Nada de secretos en query/logs.

## Plano 2 — Integridad del monto (no editable) — § crítica
- **El cliente nunca envía dinero.** `POST /api/v1/transfers` lleva solo `quoteId` + `Idempotency-Key`.
  El BE **recupera la quote server-stored y recalcula** rate/fee/USD desde sus propios valores.
  Un body con montos manipulados se ignora (CA-12). → el monto es **estructuralmente** no editable.
- **HMAC sobre la quote (defensa en profundidad):** al emitir la quote, el BE firma
  `HMAC_SHA256(secret, quoteId|amounts|rate|expiresAt)` y guarda/expone la firma. Al confirmar,
  revalida la firma antes de crear el transfer → detecta cualquier tampering o corrupción de estado,
  y habilita validación stateless a futuro. El `secret` es server-side (env), nunca va al cliente.
- **Dinero como enteros minor units** validados (rechazo de floats) — sin pérdidas ni overflow silencioso.

## Plano 3 — Backend hardening
- **helmet** (security headers). **CORS** restringido a un **allowlist** por env (no wildcard en prod).
- **express-rate-limit** (anti abuso/brute) + **límite de tamaño de body** (anti DoS por payload).
- **Validación Zod** en el borde; `amount` acotado por `MIN/MAX` (evita DoS por montos gigantes).
- **pino con redacción** de campos sensibles (el `hmacSecret`, headers). Nunca `console.log`.
- **Errores no filtran internals:** el envelope `{ error: { code, message, field? } }` es curado;
  jamás stack traces ni detalles de infra al cliente. Los 500 se loguean, no se exponen.
- **Idempotencia** (3 capas, ver spec transfer) evita el double-charge por replay.

## Plano 4 — App hardening
- **Sin secretos en el cliente:** el `hmacSecret` vive solo en el BE. La app no guarda datos sensibles
  en reposo (no hay auth/tokens en este slice).
- **Ofuscación de Dart:** `flutter build apk --release --obfuscate --split-debug-info=build/symbols`
  → nombres de símbolos ofuscados; los símbolos de debug se guardan aparte (no en el APK).
- **Minificación + shrinking (Android R8/ProGuard):** en `android/app/build.gradle` release →
  `isMinifyEnabled = true` + `isShrinkResources = true`. Reglas ProGuard (`proguard-rules.pro`) con
  los `-keep` que Flutter/plugins requieren (evitar romper reflection de dio/flutter). Reduce tamaño
  y dificulta el reversing.
- **Manifest release endurecido:** `android:allowBackup="false"` (no exfiltrar estado por backup),
  `android:debuggable="false"`, y **network security config** que prohíbe cleartext salvo `localhost`
  (coherente con TLS-obligatorio-en-prod). Sin `usesCleartextTraffic` global.
- **Sin logging de datos sensibles** en la app; el logger de dev se desactiva/limita en release.
- **Validación client-side = UX, no frontera de seguridad:** el BE revalida todo. La barrera de
  doble-submit es UX + defensa; la autoridad de no-duplicación es el BE (idempotencia).
- **(Opcional, si sobra tiempo):** `FLAG_SECURE` en pantallas con montos para bloquear screenshots
  en el recientes; detección básica de root/emulador queda fuera de scope.

---

## Fuera de alcance explícito (documentado, no omitido)
- **AuthN/AuthZ:** sin identidad de usuario, cualquier cliente puede crear un transfer y cualquiera
  con un `quoteId` podría consumirlo. En producción, quotes y transfers se scopean al usuario
  autenticado (token) y el `sub` sale del token, nunca del body. **Es el gap #1 a cerrar tras el slice.**
- KYC/AML, detección de fraude, límites regulatorios por usuario, cifrado en reposo de PII.

## Criterios de aceptación
- **CA-S1:** Un `POST /transfers` con montos manipulados en el body produce un transfer con los
  valores de la quote guardada (no los del body).
- **CA-S2:** Una quote con firma HMAC inválida/alterada → `409`/`400` de integridad, no se crea transfer.
- **CA-S3:** El cliente rechaza una URL `http` no-localhost en prod (TLS obligatorio). (Cert pinning
  diferido — ver Plano 1.)
- **CA-S4:** Un 500 nunca devuelve stack trace ni internals; responde el envelope curado y loguea aparte.
- **CA-S5:** CORS en prod solo permite orígenes del allowlist; el rate-limit responde `429` al exceder.
