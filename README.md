# Research Agent

A multi-agent research workflow for OpenClaw that turns raw ideas into ranked research directions, experiment plans, baseline scaffolds, review feedback, and durable lab memory.

## What it does

This skill is built for research exploration rather than one-shot idea polishing.
It is now file-orchestrated through shared artifacts, a run manifest, and explicit workflow gates.

It supports:
- batch ideation before committing too early
- automatic scorecard ranking
- literature review and gap mapping
- skeptic / kill-test filtering
- research brief generation
- experiment planning
- baseline scaffolding
- analyst and reviewer feedback loops
- durable memory for ideas, failures, datasets, and decisions
- citation-aware academic writing for related work and final writeups

## Current architecture

```text
coordinator
├── batch-ideation
├── scorecard-manager
├── idea
├── literature
├── gap-mapper
├── skeptic
├── critique
├── brief
├── kill-test
├── experiment-designer
├── baseline
├── analyst
├── reviewer
├── paper-writer
├── paper-editor
└── memory-manager
```

## Recommended flow

```text
raw idea
  ↓
batch ideation
  ↓
shallow literature / gap review
  ↓
skeptic filter
  ↓
auto-filled scorecard
  ↓
select top 1-2 directions
  ↓
brief
  ↓
kill test
  ↓
experiment plan
  ↓
baseline
  ↓
analysis
  ↓
reviewer pass
  ↓
paper-writer
  ↓
paper-editor
  ↓
memory capture
```

## Quick start

### 1. Initialize a cycle

```bash
scripts/run_research_cycle.sh "your raw research idea here"
```

This initializes:
- `shared/research-draft.md`
- `shared/scorecard.md`
- `shared/experiment-plan.md`
- `shared/review-report.md`
- `shared/run-manifest.json`

### 2. Run the agents in order

Suggested order:
1. `batch-ideation`
2. `literature` (shallow)
3. `gap-mapper`
4. `skeptic`
5. `scorecard-manager`
6. deepen top candidates with `idea` / `critique`
7. `brief`
8. `kill-test`
9. `experiment-designer`
10. `baseline`
11. `analyst`
12. `reviewer`
13. `memory-manager`

### 3. Respect the gates

- **Score < 6.5** → kill
- **6.5–7.2** → revise
- **> 7.2** → proceed
- no brief unless a direction is marked **Proceed**
- no baseline unless reviewer verdict is at least **promising**

## Repository structure

```text
research-agent/
├── SKILL.md
├── README.md
├── agents/
│   ├── batch-ideation.md
│   ├── scorecard-manager.md
│   ├── coordinator.md
│   ├── idea.md
│   ├── literature.md
│   ├── gap-mapper.md
│   ├── skeptic.md
│   ├── critique.md
│   ├── brief.md
│   ├── kill-test.md
│   ├── experiment-designer.md
│   ├── baseline.md
│   ├── analyst.md
│   ├── reviewer.md
│   └── memory-manager.md
├── shared/
│   ├── research-draft.md
│   ├── scorecard.md
│   ├── experiment-plan.md
│   ├── review-report.md
│   ├── registries/
│   │   ├── ideas.md
│   │   └── datasets.md
│   └── memory/
├── workspaces/
├── references/
├── scripts/
└── baselines/
```

## Notes

- `shared/research-draft.md` is the main source of truth.
- `workspaces/` is scratch space for specialist agents.
- `shared/memory/` stores durable lab knowledge.
- `references/` documents workflow and top-lab patterns used in the design.
- `baselines/` contains runnable or mock baseline scaffolds.
- `shared/final-writeup.typ` is the final human-readable writeup artifact.

## Project Card Template

Use this in a project README or project root summary:

```md
# Project Card

- **Title:**
- **Status:** ideation / review / brief / experiment / baseline / analysis
- **Lead Direction:**
- **Core Hypothesis:**
- **Primary Datasets:**
- **Main Metric:**
- **Current Gate:**
- **Main Blocker:**
- **Next Step:**
```

## Status

This is now a usable research workflow scaffold with:
- tested end-to-end smoke flow
- tested batch ideation
- tested auto-scorecard
- tested kill-test and review loops

It is not a fully autonomous scientist yet, but it is a serious multi-agent research system rather than a linear prompt chain.
