#!/usr/bin/env bash
set -euo pipefail

IDEA="${1:-}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SHARED="$ROOT/shared"
DATE="$(date -u +%F)"

if [[ -z "$IDEA" ]]; then
  echo "Usage: $(basename "$0") \"raw idea\""
  exit 1
fi

mkdir -p "$ROOT/workspaces" "$SHARED/registries"

cat > "$SHARED/research-draft.md" <<EOF
# Research Draft

## Raw Idea
$IDEA

## Notes & Iteration Log
- Initialized by run_research_cycle.sh on $DATE
- Mode: exploration first, exploitation second

## Batch Ideation

## Hypotheses

## Literature Review

## Gap Map

## Skeptic Report

## Critique

## Research Brief

## Kill Test

## Experiment Plan Summary

## Baseline Results

## Analyst Summary

## Reviewer Summary
EOF

cat > "$SHARED/scorecard.md" <<EOF
# Research Scorecard

## Candidate Directions

| Direction | Novelty | Feasibility | Impact | Data | Eval Clarity | Publication Potential | Total | Decision |
|-----------|---------|-------------|--------|------|--------------|-----------------------|-------|----------|
| _fill in after ideation/lit/gap/skeptic_ | | | | | | | | |

## Mandatory Gate
- Total < 6.5 → Kill
- 6.5 to 7.2 → Revise
- > 7.2 → Proceed
- No brief unless a direction is marked Proceed.
- No baseline unless reviewer verdict is at least promising.
EOF

cat > "$SHARED/experiment-plan.md" <<EOF
# Experiment Plan

## Objective

## Main Hypothesis

## Experiments

## Baselines

## Minimum Gain To Matter

## Expected Failure Case

## Ablations

## Datasets

## Metrics

## Failure Criteria

## Risks / Confounds

## Compute / Time Estimate
EOF

cat > "$SHARED/review-report.md" <<EOF
# Review Report

## Analyst Section

## Reviewer Section
EOF

cat > "$SHARED/run-manifest.json" <<EOF
{
  "topic": "${IDEA//"/\"}",
  "mode": "proposal",
  "stage": "batch-ideation",
  "status": "active",
  "requiredArtifacts": [
    "research-draft.md",
    "scorecard.md",
    "experiment-plan.md",
    "review-report.md"
  ],
  "gates": {
    "scorecard": false,
    "evidence_ready": false,
    "draft_ready": false,
    "final_validated": false
  }
}
EOF

echo "Initialized research cycle in: $SHARED"
echo "Next recommended order: batch-ideation -> literature (shallow) -> gap-mapper -> skeptic -> scorecard-manager -> idea/critique on top candidates -> brief -> kill-test -> experiment-designer -> baseline -> analyst -> reviewer -> memory-manager"
