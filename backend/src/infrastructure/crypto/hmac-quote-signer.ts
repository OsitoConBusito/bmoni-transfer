import { createHmac, timingSafeEqual } from "node:crypto";
import type { QuoteSigner } from "../../domain/ports/quote-signer.js";

/** HMAC-SHA256 quote signer. The secret is server-side only. Verify is constant-time. */
export class HmacQuoteSigner implements QuoteSigner {
  constructor(private readonly secret: string) {}

  sign(payload: string): string {
    return createHmac("sha256", this.secret).update(payload).digest("hex");
  }

  verify(payload: string, signature: string): boolean {
    const expected = Buffer.from(this.sign(payload));
    const actual = Buffer.from(signature);
    return expected.length === actual.length && timingSafeEqual(expected, actual);
  }
}
