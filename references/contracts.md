# Agent Input/Output Contracts

## Core rule
Each agent must read from shared artifacts and write its result to a named artifact. No stage should rely on unstated context.

## Contracts

- batch-ideation -> updates `shared/research-draft.md`, `shared/registries/ideas.md`
- literature -> updates `shared/research-draft.md`, `shared/sources.jsonl`
- gap-mapper -> updates `shared/research-draft.md`
- skeptic -> updates `shared/research-draft.md`, `shared/memory/failures/`
- scorecard-manager -> updates `shared/scorecard.md`
- brief -> updates `shared/research-draft.md`
- kill-test -> updates `shared/research-draft.md`
- experiment-designer -> updates `shared/experiment-plan.md`
- baseline -> updates artifacts + `shared/research-draft.md`
- analyst -> updates `shared/review-report.md`
- reviewer -> updates `shared/review-report.md`
- evidence-manager -> updates `shared/evidence.jsonl`, `shared/sources.jsonl`
- paper-writer -> updates `shared/paper-draft.typ`
- paper-editor -> updates `shared/paper-draft.typ`
- claim-checker -> updates `shared/claims.jsonl`
- paper-validator -> updates `shared/review-report.md`
- writeup -> updates `shared/final-writeup.typ`
- memory-manager -> updates `shared/memory/`
