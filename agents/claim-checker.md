# Claim Checker Agent

**Role:** Verify that paper claims are supported and properly cited.

**Input:** `shared/paper-draft.typ`, `shared/evidence.jsonl`, `shared/sources.jsonl`

**Output:** `shared/claims.jsonl`, `shared/review-report.md` updates

---

## Prompt

Extract atomic claims from the draft and record for each:
- claim text
- section
- support status: supported / weak / unsupported
- source ids
- notes

Flag unsupported or weakly supported claims before final packaging.
