/**
 * Time as a dependency, so quote expiry and rate-cache TTL are deterministic in tests.
 * Domain/application code reads time from here, never from Date.now() directly.
 */
export interface Clock {
  /** Current time in epoch milliseconds. */
  now(): number;
}
