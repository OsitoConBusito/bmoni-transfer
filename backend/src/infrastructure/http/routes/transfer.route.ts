import { Router } from "express";
import { z } from "zod";
import type { CreateTransferUseCase } from "../../../application/create-transfer.use-case.js";
import { ErrorCode, validationError } from "../../../shared/errors.js";
import { toTransferResponse } from "../dto/transfer-dto.js";
import { errorResponse, okResponse } from "../http-response.js";

const bodySchema = z.object({ quoteId: z.string().min(1) });

/**
 * POST /transfers. Body carries only quoteId; identity of the request is the Idempotency-Key header.
 * Thin handler: validate structure -> use case -> map Result to HTTP (201 created, 200 replayed).
 */
export const transferRouter = (createTransfer: CreateTransferUseCase): Router => {
  const router = Router();

  router.post("/transfers", (req, res) => {
    const idempotencyKey = req.header("Idempotency-Key");
    if (idempotencyKey === undefined || idempotencyKey.trim() === "") {
      errorResponse(
        res,
        validationError(ErrorCode.IDEMPOTENCY_KEY_REQUIRED, "Idempotency-Key header is required"),
      );
      return;
    }

    const parsed = bodySchema.safeParse(req.body);
    if (!parsed.success) {
      errorResponse(
        res,
        validationError(ErrorCode.QUOTE_ID_REQUIRED, "quoteId is required", "quoteId"),
      );
      return;
    }

    const result = createTransfer.execute({ quoteId: parsed.data.quoteId, idempotencyKey });
    if (!result.ok) {
      errorResponse(res, result.error);
      return;
    }
    okResponse(res, result.value.replayed ? 200 : 201, toTransferResponse(result.value.transfer));
  });

  return router;
};
