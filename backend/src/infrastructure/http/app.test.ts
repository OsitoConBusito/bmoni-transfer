import request from "supertest";
import { describe, expect, it } from "vitest";
import { loadConfig } from "../../shared/config.js";
import { composeDependencies } from "../composition-root.js";
import { createApp } from "./app.js";

const testApp = () => {
  const config = loadConfig({ NODE_ENV: "test", RATE_PROVIDER: "stub" });
  return createApp(config, composeDependencies(config));
};

describe("app", () => {
  it("given the app is up, when GET /health, then returns 200 ok", async () => {
    const response = await request(testApp()).get("/health");

    expect(response.status).toBe(200);
    expect(response.body).toEqual({ status: "ok" });
  });
});
