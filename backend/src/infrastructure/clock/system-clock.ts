import type { Clock } from "../../domain/ports/clock.js";

/** Production clock backed by the system time. */
export class SystemClock implements Clock {
  now(): number {
    return Date.now();
  }
}
