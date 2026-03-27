# Hierarchical summary retrieval for small-LM long-context reasoning

## Durable idea
Use hierarchical intermediate summaries as the retrieved unit for small language models answering multi-hop or long-context questions.

## Why it matters
Small models often fail at composition, not just recall. A minimal hierarchy (entity/event notes → local conclusions → global synthesis) may preserve intermediate reasoning state better than flat summaries or raw chunks under the same answer-time token budget.

## Recommended framing
- Primary comparison: raw chunks vs flat summaries vs hierarchical summaries.
- Best stress test: noisy contexts with distractors, redundancy, and hard negatives.
- Key causal claim to protect: gains must come from summary organization, not extra preprocessing, prompt formatting, or generic denoising.

## Promotion gate
Do not treat this as validated until hierarchy beats flat summaries on a real HotpotQA or MuSiQue slice with matched summarizer, retriever, retrieval depth, and token budget.
