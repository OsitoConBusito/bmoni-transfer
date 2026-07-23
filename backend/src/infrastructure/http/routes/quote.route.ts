import { Router } from "express";
import type { GetQuoteUseCase } from "../../../application/get-quote.use-case.js";
import { toQuoteResponse } from "../dto/quote-dto.js";
import { errorResponse, okResponse } from "../http-response.js";

/** GET /quote?amount=<MXN>. Thin handler: read query -> use case -> map Result to HTTP. */
export const quoteRouter = (getQuote: GetQuoteUseCase): Router => {
  const router = Router();

  router.get("/quote", async (req, res) => {
    const amount = typeof req.query.amount === "string" ? req.query.amount : undefined;
    const result = await getQuote.execute(amount);
    if (!result.ok) {
      errorResponse(res, result.error);
      return;
    }
    okResponse(res, 200, toQuoteResponse(result.value));
  });

  return router;
};
