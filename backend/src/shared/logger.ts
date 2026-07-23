import { pino } from "pino";

/**
 * Structured logger (never console.log). Sensitive fields are redacted so secrets
 * and auth material never reach the logs.
 */
export const logger = pino({
  level: process.env.LOG_LEVEL ?? "info",
  redact: {
    paths: ["req.headers.authorization", "*.hmacSecret", "*.HMAC_SECRET"],
    censor: "[redacted]",
  },
});
