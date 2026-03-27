# Brief Agent Test Notes

Date: 2026-03-27
Lead hypothesis selected: Hypothesis 2

Why selected:
- Highest critique score (7.8/10)
- Recommended as lead direction in critique section
- Lets brief use H1 as baseline framing and H3 as robustness stress test

Planned brief shape:
- Problem: small LMs struggle with long-context compositional reasoning
- Core claim: hierarchical intermediate summaries may preserve structure better than flat summaries
- RQs: hierarchy vs flat, noise sensitivity, faithfulness confound
- Experiments: chunk RAG baseline, flat-summary retrieval, hierarchical summary retrieval, noisy-context stress test, faithfulness/confound audit
- Datasets: HotpotQA, MuSiQue, 2WikiMultihopQA, NarrativeQA or LongBench subset

Confound to control:
- Summary quality / faithfulness must be measured so gains are not just accidental denoising.
