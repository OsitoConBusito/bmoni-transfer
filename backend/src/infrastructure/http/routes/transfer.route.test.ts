import type { Express } from "express";
import request from "supertest";
import { beforeEach, describe, expect, it } from "vitest";
import { loadConfig } from "../../../shared/config.js";
import { composeDependencies } from "../../composition-root.js";
import { createApp } from "../app.js";

// One app instance per test so the in-memory stores are shared across the multi-step flow.
let app: Express;

beforeEach(() => {
  const config = loadConfig({ NODE_ENV: "test", RATE_PROVIDER: "stub" });
  app = createApp(config, composeDependencies(config));
});

const createQuote = async (amount = "1000"): Promise<string> => {
  const response = await request(app).get(`/api/v1/quote?amount=${amount}`);
  return response.body.quoteId as string;
};

describe("POST /api/v1/transfers", () => {
  it("given a valid quote + key, when POST, then 201 with a COMPLETED transfer", async () => {
    const quoteId = await createQuote();

    const response = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({ quoteId });

    expect(response.status).toBe(201);
    expect(response.body.status).toBe("COMPLETED");
    expect(response.body.destAmount).toEqual({ minorUnits: 5624, currency: "USD" });
  });

  // CA-8 at the HTTP boundary: calling twice does not create two transfers.
  it("given the same key twice, when POST twice, then 200 replay with the same transferId", async () => {
    const quoteId = await createQuote();
    const first = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({ quoteId });
    const second = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({ quoteId });

    expect(first.status).toBe(201);
    expect(second.status).toBe(200);
    expect(second.body.transferId).toBe(first.body.transferId);
  });

  // CA-12: money in the body is ignored; the stored quote's values are used.
  it("given manipulated amounts in the body, when POST, then the quote values win", async () => {
    const quoteId = await createQuote();

    const response = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({
        quoteId,
        destAmount: { minorUnits: 999999, currency: "USD" },
        fee: { minorUnits: 0 },
      });

    expect(response.status).toBe(201);
    expect(response.body.destAmount.minorUnits).toBe(5624);
    expect(response.body.fee.minorUnits).toBe(2000);
  });

  it("given no Idempotency-Key, when POST, then 400 IDEMPOTENCY_KEY_REQUIRED", async () => {
    const quoteId = await createQuote();
    const response = await request(app).post("/api/v1/transfers").send({ quoteId });

    expect(response.status).toBe(400);
    expect(response.body.error.code).toBe("IDEMPOTENCY_KEY_REQUIRED");
  });

  it("given no quoteId, when POST, then 400 QUOTE_ID_REQUIRED", async () => {
    const response = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.error.code).toBe("QUOTE_ID_REQUIRED");
  });

  it("given an unknown quoteId, when POST, then 404 QUOTE_NOT_FOUND", async () => {
    const response = await request(app)
      .post("/api/v1/transfers")
      .set("Idempotency-Key", "key-1")
      .send({ quoteId: "does-not-exist" });

    expect(response.status).toBe(404);
    expect(response.body.error.code).toBe("QUOTE_NOT_FOUND");
  });
});
