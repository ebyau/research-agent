# Workflow Gates

## Gate 1: Scorecard
Required before brief:
- `shared/scorecard.md` populated
- at least one candidate marked Proceed

## Gate 2: Evidence Ready
Required before paper-writer:
- `shared/sources.jsonl` exists with real sources
- `shared/evidence.jsonl` contains supporting evidence
- major factual claims in draft have backing

## Gate 3: Draft Ready
Required before paper-editor:
- `shared/paper-draft.typ` exists
- all required sections for current mode exist
- citations present where expected

## Gate 4: Final Validation
Required before export:
- `shared/claims.jsonl` reviewed
- no unsupported major claims
- validator status = pass or pass-with-minor-caveats
