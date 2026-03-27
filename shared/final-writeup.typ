= Small Language Models for Long-Context Reasoning with Retrieval and Summaries

== Abstract
This document records an early-stage research direction on helping small language models handle long-context reasoning by combining retrieval, hierarchical summaries, and adaptive evidence selection. The current artifact is a smoke-test writeup generated from a minimal draft rather than a completed research cycle. As a result, the claims here should be read as scoped hypotheses and planning notes, not validated findings.

== Problem Statement
Small language models are attractive for cost, latency, and deployability, but they often struggle when relevant evidence is dispersed across long contexts. Naive prompting over large inputs is inefficient and brittle, while aggressive compression can remove rare but decision-critical details. The core problem is how to let a small model reason over large evidence spaces without requiring it to repeatedly process the full context.

== Motivation
If small models can reason effectively over long documents through structured retrieval and summary control, they could support cheaper research assistants, document analysis systems, and resource-constrained deployments. This is especially valuable when larger models are too expensive or unavailable, but users still need multi-step reasoning grounded in broad evidence.

== Research Questions
- Can a small language model maintain reasoning quality by operating over a selectively refreshed hierarchy of summaries instead of the raw full context?
- Does query-adaptive retrieval improve answer quality relative to fixed retrieval bundles?
- Do structured memory representations, such as argument graphs, help preserve support and contradiction relations better than flat summaries?
- Can failure-aware compression objectives reduce the loss of rare but decisive details?
- When does budgeted retrieval escalation offer a better cost-quality tradeoff than static reasoning pipelines?

== Related Work Summary
The draft suggests a broad area spanning long-context reasoning, retrieval-augmented generation, summarization, and structured memory for language models. However, no concrete literature review was provided in the smoke-test inputs. For now, the relevant prior work can only be summarized at a high level: existing systems typically rely on retrieval, compression, or larger context windows, while this project emphasizes explicit control over what is summarized, refreshed, and revisited for small models. A proper writeup will need citations and a sharper differentiation from retrieval planning, memory-augmented reasoning, and compression-aware training work.

== Proposed Methodology
A practical starting point is to compare several design variants built around the same small-model backbone:
- *Hierarchical Summary Controller:* maintain rolling summaries at multiple granularities and refresh them selectively.
- *Query-Adaptive Retrieval Planner:* predict which evidence types are needed before retrieval.
- *Memory-as-Argument Graph:* store facts and relations as structured support or conflict links.
- *Failure-Aware Compression Training:* train for preservation of rare but task-critical details.
- *Budgeted Reasoning with Retrieval Escalation:* begin with coarse summaries and retrieve finer evidence only under uncertainty.

The intended evaluation logic is to test whether these methods improve reasoning quality, robustness to long inputs, and cost efficiency relative to simpler retrieval and summarization baselines.

== Data Sources / Datasets
No datasets were specified in the experiment-plan input. A realistic next version should include at least:
- long-document question answering datasets,
- multi-document reasoning benchmarks,
- synthetic tasks designed to test retention of rare but crucial evidence,
- and possibly domain-specific corpora where summary drift is easy to measure.

At this stage, dataset selection remains unresolved.

== Experimental Setup
The current experiment plan is effectively empty, so the setup below is only a placeholder. A reasonable first pass would fix one or two small language models, a shared retrieval stack, and a common token or latency budget across methods. Each method would then be evaluated under matched budget constraints to isolate whether adaptive summaries or structured memory improve reasoning beyond standard retrieval-plus-generation.

This should be treated as proposed setup only. No experiment configuration, run logs, or results were included in the source materials.

== Baselines and Metrics
Likely baselines include:
- direct small-model prompting on truncated context,
- standard retrieval-augmented generation with a fixed top-k bundle,
- and simple summarize-then-answer pipelines.

Likely metrics include:
- task accuracy or exact-match style answer quality,
- faithfulness to source evidence,
- recall of rare but decisive facts,
- token cost and latency,
- and robustness under increasing context length.

These are inferred planning choices, not finalized protocol decisions.

== Risks / Limitations
- This document is based on a smoke test with sparse intermediate artifacts.
- No literature review, dataset shortlist, baselines table, or reviewer critique was actually populated.
- Novelty claims are provisional and may collapse after a real survey.
- Summary drift may erase key evidence, especially in hierarchical compression schemes.
- Retrieval planners may fail by excluding the very evidence needed for downstream reasoning.
- Structured memory may add overhead that cancels any reasoning gains.
- Compression-focused training may overfit synthetic failure modes and transfer poorly.
- Small-model uncertainty estimates may be too miscalibrated for reliable retrieval escalation.

== Expected Contributions
If the direction holds up, the project could contribute:
- a clearer design space for long-context reasoning with small models,
- empirical evidence on when adaptive summaries help or hurt,
- evaluation protocols focused on preservation of rare critical details,
- and a cost-aware comparison between fixed retrieval, structured memory, and escalation-based reasoning.

== Next Steps
- Perform a real literature review and replace the placeholder related-work section with citations.
- Select concrete datasets and define success criteria.
- Choose one primary method variant for initial implementation instead of pursuing all five equally.
- Write a minimally complete experiment plan with baselines, metrics, and failure criteria.
- Run a first implementation-level smoke experiment to check feasibility before making broader claims.
- Carry reviewer scrutiny forward explicitly rather than treating this draft as evidence of validated results.
