# Adversarial write → review → fact-check harness

Every load-bearing claim is drafted, attacked, and grounded against real sources
before it is allowed into camera-ready prose. This file is the run recipe;
[`claims.md`](claims.md) is the live ledger.

## Roles

| Role | Job | Must not |
|------|-----|----------|
| **Author** | Draft or expand one section. Cite only keys that exist in `common/refs.bib`. Mark each load-bearing assertion `\CLAIM{...}`. | Invent citations. Soften a claim to dodge review. |
| **Adversarial reviewer** | Attack each claim on the [rubric](checklists/reviewer-rubric.md): novel, sound, not over-claimed, evidenced. Propose the strongest counter-example. | Wave things through. Accept "it's obvious". |
| **Fact-checker** | Open every cited source and confirm it says what it is cited for. Replace every `UNVERIFIED` note with a verified entry, or cut the citation. | Approve a source it did not open. Leave an unverified key cited. |
| **Editor** | Adjudicate: move each claim's status in the ledger; only `survived` claims stay in the text. | — |

## The loop (per section)

1. **Author** drafts the section and adds a `\CLAIM{}` per load-bearing assertion.
2. **Reviewer** files objections against each claim → ledger status `challenged`.
3. **Fact-checker** grounds the surviving claims and their citations → `grounded`.
4. **Editor** accepts or cuts → `survived` or removed. A claim that cannot be
   grounded is cut or downgraded, never shipped on faith.

Sections run as independent lanes in parallel; they do not touch the same files.

## Definition of done (camera-ready gate)

- Zero `UNVERIFIED` notes on cited bibliography entries.
- Every `\CLAIM` is resolved to prose or listed `survived` in the ledger.
- No `\TODO` or `\NEEDCITE` left.
- The [submission checklist](checklists/submission.md) passes.
