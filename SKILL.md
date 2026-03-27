---
name: research-agent
description: Multi-agent research pipeline that transforms raw ideas, vague project thoughts, and early-stage concepts into concrete research directions, literature reviews, problem statements, experiment plans, dataset candidates, and baseline implementations. Use when creating or running a research workflow with coordinated subagents for idea reframing, literature review, critique, brief generation, and baseline setup.
---

# Research Agent Skill

## Overview

```text
coordinator
├── batch-ideation agent
├── scorecard-manager agent
├── ideation agent
├── literature agent
├── gap-mapper agent
├── skeptic agent
├── critique agent
├── brief agent
├── experiment-designer agent
├── baseline agent
├── analyst agent
├── reviewer agent
├── kill-test agent
└── memory-manager agent
```

Read `references/workflow.md` for the full execution flow and `references/top-lab-patterns.md` for the research-lab design patterns used here.

## Usage

### Start a research pipeline

Provide a raw idea or vague concept to the coordinator:

```text
coordinator → idea → literature → critique → brief → baseline
```

The coordinator initializes the draft, routes work, and decides whether to iterate or move forward.

### Literature review loop (stages 1-3)

``` 
/spawn research-agent.literature
/spawn research-agent.critique
```

Iterate until critique score ≥ 7/10.

### Generate research brief

``` 
/spawn research-agent.brief
```

Review brief. If approved → proceed to baseline.

### Implement baseline

```
/spawn research-agent.baseline
```

## Shared Documents

Primary shared files:
- `shared/research-draft.md` — main source of truth
- `shared/scorecard.md` — candidate ranking and triage
- `shared/experiment-plan.md` — experiment specification
- `shared/review-report.md` — analyst + reviewer judgments

## Agent Definitions

| Agent | File | Role |
|-------|------|------|
| coordinator | `agents/coordinator.md` | Routes the pipeline, manages iteration, and keeps the draft coherent |
| batch-ideation | `agents/batch-ideation.md` | Generate 5-10 candidate directions before deep work |
| scorecard-manager | `agents/scorecard-manager.md` | Auto-fill the scorecard and rank candidates |
| idea | `agents/idea.md` | Reframe vague ideas → concrete hypotheses |
| literature | `agents/literature.md` | Review related work and extract gaps |
| gap-mapper | `agents/gap-mapper.md` | Convert literature into an opportunity landscape |
| skeptic | `agents/skeptic.md` | Kill weak directions early and document failure modes |
| critique | `agents/critique.md` | Score and challenge candidate directions |
| brief | `agents/brief.md` | Generate the research brief |
| experiment-designer | `agents/experiment-designer.md` | Specify the rigorous experiment plan |
| baseline | `agents/baseline.md` | Build baseline implementation and evaluation harness |
| analyst | `agents/analyst.md` | Interpret results and recommend next steps |
| reviewer | `agents/reviewer.md` | Judge publishability and reviewer objections |
| kill-test | `agents/kill-test.md` | Design the cheapest falsification test before heavy work |
| memory-manager | `agents/memory-manager.md` | Capture durable research memory across cycles |

## Quality Gates

Each stage has a score threshold. If critique scores below 7/10, iterate
through idea → literature → critique until the direction strengthens.

## Requirements

- Web search capability (brave search or similar)
- File write access to shared research draft
- Spawn permission for subagents

## Memory Best Practices

For this pipeline to work reliably:

1. **Keep workspace files small** — total < 8KB. Agent prompts inject every message.
2. **Write before compaction** — use `memory/YYYY-MM-DD.md` for daily logs; `MEMORY.md` for durable facts. Rules in chat don't survive compaction.
3. **Enable memory flush** — set `compaction.memoryFlush.enabled = true` so the agent saves context before it gets trimmed.
4. **Use memory_search** — semantic recall over file-based memory, not mental notes.
5. **Subagents for heavy work** — keeps main session context lean.

### Config Recommendations

```json
{
  "agents": {
    "defaults": {
      "contextPruning": { "mode": "cache-ttl", "ttl": "5m" },
      "compaction": {
        "reserveTokensFloor": 20000,
        "memoryFlush": { "enabled": true, "softThresholdTokens": 4000 }
      }
    }
  },
  "memory": {
    "backend": "qmd",
    "qmd": {
      "includeDefaultMemory": true,
      "update": { "interval": "5m", "debounceMs": 15000 },
      "limits": { "maxResults": 6, "maxSnippetChars": 700 }
    }
  }
}
```

### QMD Setup (Optional — for hybrid BM25 + vector search)

QMD is a local sidecar that replaces the default SQLite memory backend with better retrieval.

**Prerequisites:**
- QMD CLI: `bun install -g https://github.com/tobi/qmd` or `npm install -g @tobilu/qmd`
- Or use the npm global install already available

**Initial setup:**
```bash
# Create collection for your workspace
export XDG_CONFIG_HOME="$HOME/.openclaw/agents/main/qmd/xdg-config"
export XDG_CACHE_HOME="$HOME/.openclaw/agents/main/qmd/xdg-cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME"

# Add workspace to QMD
qmd collection add ~/.openclaw/workspace --name "workspace"

# Generate embeddings (one-time, downloads ~300MB model)
qmd embed --collection workspace

# Verify
qmd status
qmd query "your search term" --json
```

**What QMD provides:**
- BM25 keyword search + vector similarity combined
- MMR (Maximal Marginal Relevance) reranking for diverse results
- Local GGUF embeddings via node-llama-cpp (no external API)
- Falls back to built-in SQLite if QMD is unavailable

**When QMD is unavailable:** OpenClaw auto-falls back to builtin SQLite manager — memory tools keep working.

### Full Memory Layer Stack

| Layer | Component | Purpose |
|-------|-----------|---------|
| 1 | `memory/YYYY-MM-DD.md` | Daily raw logs |
| 2 | `MEMORY.md` | Curated long-term facts |
| 3 | `memory_search` / QMD | Semantic retrieval over all memory |
| 4 | `compaction.memoryFlush` | Pre-compaction save (survives context trim) |
| 5 | Graph memory (future) | Entity relationships |
| 6 | Auto-fact extraction (future) | Structured facts from conversations |
