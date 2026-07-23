import request from "supertest";
import { describe, expect, it } from "vitest";
import { loadConfig } from "../../../shared/config.js";
import { composeDependencies } from "../../composition-root.js";
import { createApp } from "../app.js";

const testApp = () => {
  const config = loadConfig({ NODE_ENV: "test", RATE_PROVIDER: "stub" });
  return createApp(config, composeDependencies(config));
};

describe("GET /api/v1/quote", () => {
  it("given a valid amount, when GET, then 200 with priced quote (integer minor units)", async () => {
    const response = await request(testApp()).get("/api/v1/quote?amount=1000");

    expect(response.status).toBe(200);
    expect(response.body.quoteId).toBeDefined();
    expect(response.body.sourceAmount).toEqual({ minorUnits: 100000, currency: "MXN" });
    expect(response.body.destAmount).toEqual({ minorUnits: 5624, currency: "USD" });
    expect(response.body.rate.source).toBe("stub");
    expect(typeof response.body.expiresAt).toBe("string");
  });

  it("given no amount, when GET, then 400 AMOUNT_REQUIRED envelope", async () => {
    const response = await request(testApp()).get("/api/v1/quote");

    expect(response.status).toBe(400);
    expect(response.body.error.code).toBe("AMOUNT_REQUIRED");
    expect(response.body.error.field).toBe("amount");
  });

  it("given an amount below the minimum, when GET, then 400 AMOUNT_TOO_LOW", async () => {
    const response = await request(testApp()).get("/api/v1/quote?amount=5");

    expect(response.status).toBe(400);
    expect(response.body.error.code).toBe("AMOUNT_TOO_LOW");
  });
});
