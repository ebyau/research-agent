# Research Agent Workflow

## Recommended Workspace Layout

```text
research-agent/
├── SKILL.md
├── agents/
│   ├── coordinator.md
│   ├── idea.md
│   ├── literature.md
│   ├── gap-mapper.md
│   ├── skeptic.md
│   ├── critique.md
│   ├── brief.md
│   ├── experiment-designer.md
│   ├── baseline.md
│   ├── analyst.md
│   ├── reviewer.md
│   └── memory-manager.md
├── shared/
│   ├── research-draft.md
│   ├── scorecard.md
│   ├── experiment-plan.md
│   └── review-report.md
├── workspaces/
│   ├── coordinator/
│   ├── idea/
│   ├── literature/
│   ├── gap-mapper/
│   ├── skeptic/
│   ├── critique/
│   ├── brief/
│   ├── experiment-designer/
│   ├── baseline/
│   ├── analyst/
│   ├── reviewer/
│   └── memory-manager/
├── shared/memory/
│   ├── ideas/
│   ├── papers/
│   ├── failures/
│   ├── datasets/
│   ├── decisions/
│   └── open-questions/
└── baselines/
```

## End-to-End Flow

1. Coordinator initializes the draft with the raw idea.
2. Idea agent generates candidate hypotheses.
3. Literature agent reviews related work.
4. Gap Mapper converts literature into an opportunity landscape.
5. Skeptic tries to kill weak directions early.
6. Critique agent scores the survivors.
7. Coordinator updates `shared/scorecard.md` and selects the lead direction.
8. Brief agent turns the selected direction into a research brief.
9. Experiment Designer writes the experiment plan.
10. Human checkpoint: approve / revise / kill.
11. Baseline agent builds and runs the initial scaffold.
12. Analyst interprets outputs.
13. Reviewer judges publication readiness.
14. If producing a paper/proposal draft: revise based on reviewer feedback and repeat review until major concerns are addressed.
15. Produce final Typst draft + compiled PDF when feasible.
16. Memory Manager stores durable lessons.

## Paper Draft Quality Standard

For paper-facing outputs, do not stop at sparse summaries or outline-style prose when the user expects a serious draft.

Paper drafts should by default include:
- strong motivation and gap framing
- a developed problem statement with equations where appropriate
- flowing related-work prose
- detailed method description
- formalized theory/error section where appropriate
- concrete baseline and experiment design
- citations, bibliography, and figures when useful
- at least one reviewer pass before finalization

## Top-Lab Behaviors Built In

- aggressive idea triage
- specialist roles instead of one omni-agent
- failed-idea memory
- reviewer-aware evaluation
- explicit human checkpoints before expensive work
- exploration first, exploitation second
