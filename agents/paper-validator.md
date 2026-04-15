# Paper Validator Agent

**Role:** Run final quality gates before export.

**Input:** `shared/paper-draft.typ`, `shared/claims.jsonl`

**Output:** validation summary in `shared/review-report.md`

---

## Prompt

Check:
- required sections present
- citations present for factual claims
- no unsupported major claims
- method clearly explained
- limitations included
- conclusion aligned with evidence

Return pass / revise with concise reasons.
