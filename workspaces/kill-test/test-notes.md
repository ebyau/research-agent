# Kill Test Notes

Date: 2026-03-27

Inputs reviewed:
- agents/kill-test.md
- shared/research-draft.md
- shared/scorecard.md
- workspaces/brief/test-notes.md
- workspaces/gap-mapper/test-notes.md
- workspaces/memory-manager/test-notes.md

Lead direction inferred:
- Hierarchical intermediate summaries improve small-LM long-context multi-hop reasoning over flat summaries and raw-chunk retrieval under matched token budgets.

Kill-test design:
- Use a very small real-data slice (about 30-50 examples) from HotpotQA or MuSiQue.
- Keep summarizer, retriever, model, and token budget fixed.
- Compare flat-summary retrieval vs hierarchical-summary retrieval first; raw chunks are optional for the cheapest gate.
- Track answer EM/F1 plus evidence-support / faithfulness spot checks.

Kill criteria:
- No meaningful gain from hierarchy over flat summaries (for example <= 2-3 F1 points and no robustness win), or gains vanish after controlling for token budget / summary quality.
- Hierarchical summaries show noticeably worse faithfulness or evidence support.

Proceed criteria:
- Clear improvement over flat summaries on the small slice while staying within budget and not degrading faithfulness.

Expected cost:
- Hours, not days; a single cheap pilot on one dataset slice.