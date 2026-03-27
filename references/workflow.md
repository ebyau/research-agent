# Research Agent Workflow

## Recommended Workspace Layout

```text
research-agent/
├── SKILL.md
├── agents/
│   ├── coordinator.md
│   ├── idea.md
│   ├── literature.md
│   ├── critique.md
│   ├── brief.md
│   └── baseline.md
├── shared/
│   └── research-draft.md
├── workspaces/
│   ├── coordinator/
│   ├── idea/
│   ├── literature/
│   ├── critique/
│   ├── brief/
│   └── baseline/
└── references/
    └── workflow.md
```

## End-to-End Flow

1. Coordinator initializes the draft with the raw idea.
2. Idea agent writes concrete hypotheses.
3. Literature agent reviews related work and gaps.
4. Critique agent scores the direction.
5. If score < 7, coordinator loops back.
6. If score ≥ 7, brief agent generates the research brief.
7. Human reviews.
8. Baseline agent scaffolds the initial implementation.

## Scratch Space Policy

Each specialist agent may write temporary notes into its own folder under `workspaces/<agent>/`.
The only shared source of truth is `shared/research-draft.md`.

## Human Control Points

- After critique: continue or iterate?
- After brief: approve or revise?
- Before baseline: final go/no-go.
