import type { Clock } from "../../domain/ports/clock.js";

/** Controllable clock for deterministic tests of expiry and cache TTL. */
export class FakeClock implements Clock {
  constructor(private current: number) {}

  now(): number {
    return this.current;
  }

  advance(ms: number): void {
    this.current += ms;
  }
}
