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
  }
}
```
