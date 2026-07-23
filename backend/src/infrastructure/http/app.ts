import cors from "cors";
import express, { type Express, type NextFunction, type Request, type Response } from "express";
import rateLimit from "express-rate-limit";
import helmet from "helmet";
import { pinoHttp } from "pino-http";
import { type Config, corsOrigins } from "../../shared/config.js";
import { logger } from "../../shared/logger.js";
import type { AppDependencies } from "../composition-root.js";
import { quoteRouter } from "./routes/quote.route.js";

const MAX_BODY_BYTES = "16kb";
const RATE_LIMIT_WINDOW_MS = 60_000;
const RATE_LIMIT_MAX = 120;

/**
 * Builds the Express app with the security/observability middleware stack.
 * Returned without listening so tests (supertest) can exercise it directly.
 * Feature routers are mounted under /api/v1 as they are implemented.
 */
export const createApp = (config: Config, deps: AppDependencies): Express => {
  const app = express();

  app.use(helmet());
  app.use(cors({ origin: corsOrigins(config) }));
  app.use(express.json({ limit: MAX_BODY_BYTES }));
  app.use(pinoHttp({ logger }));
  app.use(
    rateLimit({
      windowMs: RATE_LIMIT_WINDOW_MS,
      max: RATE_LIMIT_MAX,
      standardHeaders: true,
      legacyHeaders: false,
    }),
  );

  app.get("/health", (_req, res) => {
    res.status(200).json({ status: "ok" });
  });

  app.use("/api/v1", quoteRouter(deps.getQuote));

  // Final safety net: unexpected errors are logged, never leaked. Clients get a curated envelope.
  app.use((error: unknown, _req: Request, res: Response, _next: NextFunction) => {
    logger.error({ err: error }, "unhandled error");
    res.status(500).json({ error: { code: "INTERNAL", message: "Internal server error" } });
  });

  return app;
};
