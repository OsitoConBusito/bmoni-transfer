import request from "supertest";
import { describe, expect, it } from "vitest";
import { loadConfig } from "../../shared/config.js";
import { createApp } from "./app.js";

describe("app", () => {
  it("given the app is up, when GET /health, then returns 200 ok", async () => {
    const app = createApp(loadConfig({ NODE_ENV: "test" }));

    const response = await request(app).get("/health");

    expect(response.status).toBe(200);
    expect(response.body).toEqual({ status: "ok" });
  });
});
