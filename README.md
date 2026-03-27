# Research Agent Skill

Multi-agent research pipeline for OpenClaw — transforms raw ideas into research plans.

## Architecture

```
coordinator (you)
├── idea_agent       → concrete hypotheses
├── literature_agent → gap analysis + paper search
├── critique_agent   → score + quality gate (≥7/10 to pass)
└── brief_agent      → research brief

                      ↓ (human approval)

baseline_agent        → implementation + experiments
```

## Quick Start

1. Give the coordinator a raw idea
2. Spawn idea agent to reframe into hypotheses
3. Spawn literature agent to find gaps
4. Spawn critique agent to score (iterate if < 7/10)
5. Spawn brief agent if quality gate passes
6. Approve brief → spawn baseline agent

See `SKILL.md` for full usage instructions.

## Installing

Copy or symlink this directory into your OpenClaw skills folder:
```
~/.openclaw/skills/research-agent/
```

Or use the ClawHub CLI:
```
clawhub install research-agent
```

## Structure

```
research-agent/
├── SKILL.md                  # Main skill file
├── agents/
│   ├── idea.md              # Idea reframing agent
│   ├── literature.md        # Literature review agent
│   ├── critique.md          # Critique & quality gate agent
│   ├── brief.md             # Research brief generator
│   └── baseline.md         # Baseline implementation agent
└── shared/
    └── research-draft.md    # Shared research document
```

## Pipeline Overview

| Stage | Agent | Output | Gate |
|-------|-------|--------|------|
| 1 | idea_agent | Hypotheses | — |
| 2 | literature_agent | Gap analysis | — |
| 3 | critique_agent | Scores (1-10) | ≥ 7/10 |
| 4 | brief_agent | Research brief | Coordinator approval |
| 5 | baseline_agent | Implementation | — |

## Publishing

Published on ClawHub. To update:
```
clawhub publish research-agent
```
