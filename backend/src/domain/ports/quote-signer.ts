/**
 * Signs and verifies a quote's integrity payload with a server-side secret (HMAC). Defense in
 * depth: the client only ever sends a quoteId, so amounts are already non-editable; this catches
 * tampering/corruption of stored state and readies stateless validation. The secret never leaves
 * the backend.
 */
export interface QuoteSigner {
  sign(payload: string): string;
  verify(payload: string, signature: string): boolean;
}
