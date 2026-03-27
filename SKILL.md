# Research Agent Skill

Multi-agent research pipeline — transforms raw ideas into research plans.

## Overview

```
you (coordinator) 
├── idea_agent      → concrete hypotheses from vague ideas
├── literature_agent → gap analysis, paper search
├── critique_agent  → score & challenge the direction
└── brief_agent      → problem statement, RQs, experiments, datasets

pass → baseline_agent → implementation & experiments
```

## Usage

### Start a research pipeline

Provide a raw idea or vague concept:

```
/spawn research-agent.idea idea="I want to do something with LLMs and reasoning"
```

The idea agent reframes it into concrete hypotheses, writes to shared research doc.

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

## Shared Document

All agents write to `skills/research-agent/shared/research-draft.md`.
You maintain this as the source of truth between stages.

## Agent Definitions

| Agent | File | Role |
|-------|------|------|
| idea | `agents/idea.md` | Reframe vague ideas → concrete hypotheses |
| literature | `agents/literature.md` | Gap analysis, paper search |
| critique | `agents/critique.md` | Score & challenge direction |
| brief | `agents/brief.md` | Research brief generator |
| baseline | `agents/baseline.md` | Implementation & experiments |

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
