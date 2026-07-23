import type { Response } from "express";
import type { AppError } from "../../shared/errors.js";

const STATUS_BY_KIND: Record<AppError["kind"], number> = {
  validation: 400,
  not_found: 404,
  conflict: 409,
  unavailable: 503,
};

/** Sends a success body with the given status. */
export const okResponse = (res: Response, status: number, body: unknown): void => {
  res.status(status).json(body);
};

/**
 * Maps a typed AppError to the curated error envelope. Never leaks internals — only the code,
 * message, and optional field cross the wire.
 */
export const errorResponse = (res: Response, error: AppError): void => {
  const status = STATUS_BY_KIND[error.kind];
  const envelope =
    error.kind === "validation" && error.field !== undefined
      ? { error: { code: error.code, message: error.message, field: error.field } }
      : { error: { code: error.code, message: error.message } };
  res.status(status).json(envelope);
};
