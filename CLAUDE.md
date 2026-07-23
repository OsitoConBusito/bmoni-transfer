# bmoni-transfer

Vertical slice **MXN → USD**: quote + confirm a transfer. Node/TS backend
(`backend/`) + Flutter app (`app/`). Take-home (2-3h). The global Clean Code
rules (`~/.claude/CLAUDE.md`) apply; only bmoni's **cross-cutting** invariants
go here.

## Documentation map (where things live)
| You need… | It's in… |
|---|---|
| The contract: endpoints, entities, business rules, architecture, ACs | [.specs/features/mxn-usd-transfer.md](.specs/features/mxn-usd-transfer.md) — **source of truth** |
| Backend rules (hexagonal, Express+Zod, Result) | [backend/CLAUDE.md](backend/CLAUDE.md) — auto-loaded in `backend/` |
| Frontend rules (Riverpod, Clean Arch, widgets) | [app/CLAUDE.md](app/CLAUDE.md) — auto-loaded in `app/` |
| How to run / setup | `README.md` |
| Why behind the decisions | `DECISIONS.txt` |

Golden rule: if something contradicts the spec, **fix the spec first**, then
the code. Don't duplicate the spec here or in the nested CLAUDE.md files —
point to it.

## Cross-cutting invariants (the two things this domain punishes)
Apply to **both** sides; the detail lives in the spec.

1. **Money.** Never a decimal `float`/`double`/`number`. Everything goes
   through the `Money` value object in integer minor units (MXN cents /
   USD cents). Rounding is **half-up exactly once** at the boundary (no
   double rounding). The **rate is never hardcoded on the client**: it
   comes from the backend.
2. **Idempotency (retry-safe).** Calling `POST /transfers` twice doesn't
   create two transfers: single-use quote + `Idempotency-Key` header +
   double-submit barrier in Flutter. The backend never trusts money from
   the client: it retrieves the quote and recalculates.

## Gitflow — Trunk-Based with feature branches via PR
`main` is the trunk (always green). Every unit of work goes on a
**short-lived feature branch** and lands via **Pull Request** against
`main`, using the `.github/pull_request_template.md` template.
- Branch names: `feat/<slug>`, `fix/<slug>`, `chore/<slug>`, `docs/<slug>`.
- Small, atomic commits, Conventional Commits (`feat(be):`, `feat(app):`,
  `chore:`, `docs:`, `test:`).
- The PR documents what/why, files touched, spec CAs covered, a test plan,
  and **estimated vs. actual time** (for the tracking the evaluation asks
  for). Run the reviewer for the side touched before marking it ready.

## Review
Before committing a unit of work, run the reviewer for the side touched over
the diff: `ts-reviewer` (backend) / `flutter-reviewer` (app). Read-only,
they report findings.
