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
14. Memory Manager stores durable lessons.

## Top-Lab Behaviors Built In

- aggressive idea triage
- specialist roles instead of one omni-agent
- failed-idea memory
- reviewer-aware evaluation
- explicit human checkpoints before expensive work
- exploration first, exploitation second
