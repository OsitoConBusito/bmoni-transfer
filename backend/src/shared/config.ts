import { z } from "zod";

/** Dev/test-only fallback secret. Rejected at load time when NODE_ENV=production. */
const INSECURE_DEV_SECRET = "dev-insecure-secret-change-me";

/**
 * Loads and validates environment config once at startup. Fails fast (throws) on
 * invalid config — that is a programming/deploy error, not an expected failure path.
 * Money-related values are read as MXN major units here and converted to minor units
 * where they enter the domain.
 */
const envSchema = z
  .object({
    NODE_ENV: z.enum(["development", "production", "test"]).default("development"),
    PORT: z.coerce.number().int().positive().default(3000),
    CORS_ALLOWLIST: z.string().default("http://localhost:8080"),

    RATE_PROVIDER: z.enum(["frankfurter", "stub"]).default("frankfurter"),
    RATE_CACHE_TTL_MS: z.coerce.number().int().positive().default(60_000),

    QUOTE_TTL_MS: z.coerce.number().int().positive().default(60_000),

    FEE_FLAT_MXN: z.coerce.number().nonnegative().default(20),
    FEE_THRESHOLD_MXN: z.coerce.number().nonnegative().default(5_000),
    FEE_PERCENT: z.coerce.number().min(0).max(1).default(0.01),

    MIN_AMOUNT_MXN: z.coerce.number().positive().default(10),
    MAX_AMOUNT_MXN: z.coerce.number().positive().default(100_000),

    HMAC_SECRET: z.string().min(1).default(INSECURE_DEV_SECRET),
  })
  .refine(
    (config) => !(config.NODE_ENV === "production" && config.HMAC_SECRET === INSECURE_DEV_SECRET),
    {
      message: "HMAC_SECRET must be set to a non-default value in production",
      path: ["HMAC_SECRET"],
    },
  );

export type Config = z.infer<typeof envSchema>;

export const loadConfig = (env: NodeJS.ProcessEnv = process.env): Config => {
  const parsed = envSchema.safeParse(env);
  if (!parsed.success) {
    throw new Error(`Invalid environment config: ${parsed.error.message}`);
  }
  return parsed.data;
};

export const corsOrigins = (config: Config): string[] =>
  config.CORS_ALLOWLIST.split(",")
    .map((origin) => origin.trim())
    .filter((origin) => origin.length > 0);
