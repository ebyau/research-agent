# Research Draft

_This document is the shared context pool for all research pipeline agents._

---

## Raw Idea
Toy smoke test: explore whether small language models can be improved for long-context reasoning using retrieval-augmented intermediate summaries.

---

## Hypotheses
## Hypotheses (generated: 2026-03-27)

1. **Hypothesis statement** — For multi-document or long-context reasoning tasks, a small LM will outperform its no-summary baseline when it retrieves structured intermediate summaries instead of raw chunks at answer time.
   - **Intuition** — Small models often waste capacity re-reading irrelevant tokens and fail to preserve cross-document state. Intermediate summaries can compress salient evidence into a format the model can actually use.
   - **Success criteria** — Higher exact match / F1 than vanilla RAG with the same context budget, especially as input length grows.
   - **Key risks** — Summaries may omit decisive details or introduce abstraction errors that hurt final reasoning.
   - **Novelty note** — Focuses on retrieval over *generated reasoning artifacts* rather than only original source passages.

2. **Hypothesis statement** — Hierarchical summaries aligned to reasoning steps (entity/event → local conclusion → global synthesis) will yield larger gains than single-pass flat summaries.
   - **Intuition** — Long-context reasoning usually fails at composition, not just recall. A staged summary format may better preserve dependencies needed for downstream inference.
   - **Success criteria** — Hierarchical summarization beats flat summarization under equal token limits on compositional QA or multi-hop tasks.
   - **Key risks** — The extra structure may add pipeline complexity without enough information gain for small models.
   - **Novelty note** — Tests summary *organization* as the intervention, not just summary presence.

3. **Hypothesis statement** — Retrieval-augmented intermediate summaries will improve robustness more on noisy contexts than on clean contexts.
   - **Intuition** — If the method works by filtering distraction and preserving only decision-relevant content, it should help most when documents contain redundant or irrelevant text.
   - **Success criteria** — Larger relative gains versus baseline as distractor rate or context length increases.
   - **Key risks** — Noise can contaminate the summaries themselves, causing error propagation.
   - **Novelty note** — Frames the approach as a robustness mechanism against context clutter, not only a memory aid.

4. **Hypothesis statement** — Summaries generated with explicit citation links back to source spans will outperform uncited summaries for faithfulness-sensitive reasoning tasks.
   - **Intuition** — Citations let the model verify or revisit evidence when summaries are ambiguous, reducing hallucinated synthesis.
   - **Success criteria** — Better attribution / faithfulness scores with equal or modestly improved task accuracy.
   - **Key risks** — Citation markup may consume too much budget or be ignored by the small model.
   - **Novelty note** — Combines compressed memory with lightweight traceability rather than treating summarization as a black box.

---

## Literature Review (reviewed: 2026-03-27)

### Hypothesis 1 — retrieving structured intermediate summaries beats raw chunks
- **Related work**
  - **Liu et al., "Lost in the Middle" (TACL 2024)** — shows long-context models miss relevant evidence when it is buried, motivating compressed representations.
  - **"Retrieval Meets Long Context Large Language Models" (OpenReview 2023)** — retrieval often remains competitive with or better than simply enlarging context windows.
  - **"On Context Utilization in Summarization with Large Language Models" (2024)** — having more context does not imply effective use of it.
- **Gap(s) identified** — Prior work mainly compares raw retrieval vs long-context ingestion, or studies summarization as a final output task. There is much less direct evidence on **retrieving generated reasoning artifacts / intermediate summaries** as the retrieval unit, especially for **small** models under fixed token budgets.
- **Opportunity** — Evaluate whether summary-as-memory gives small LMs better answer-time evidence selection than vanilla chunk RAG on multi-doc QA and long-context reasoning.

### Hypothesis 2 — hierarchical summaries outperform flat summaries
- **Related work**
  - **"From Local to Global: A Graph RAG Approach to Query-Focused Summarization" (GraphRAG, 2024/2025)** — uses hierarchical community summaries to answer global questions over large corpora.
  - **"Retrieve, Summarize, Plan" (WWW 2025 companion)** — iterative summarization and planning help multi-hop QA.
  - **Multi-hop QA survey/review literature** — consistently frames compositional reasoning as the bottleneck rather than simple retrieval.
- **Gap(s) identified** — Existing hierarchical methods are usually evaluated at system level (graph indices, iterative planners, larger pipelines), not as a clean ablation of **summary organization** under equal token budgets for small LMs.
- **Opportunity** — Test a minimal hierarchy (entity/event → local conclusion → global synthesis) against flat summaries while controlling retrieval budget, model size, and task difficulty.

### Hypothesis 3 — gains should be larger in noisy contexts
- **Related work**
  - **"Lost in the Noise: How Reasoning Models Fail with Contextual Distractors" (2026)** — reports major drops when irrelevant or adversarial context is added.
  - **Recent RAG-reasoning surveys (2025)** — identify filtering, verification, and distractor robustness as open problems.
  - **Long-context evaluation work such as "Lost in the Middle"** — suggests retrieval difficulty grows as relevant evidence becomes harder to isolate.
- **Gap(s) identified** — Many papers document that noise hurts, but fewer test whether **intermediate summaries specifically act as a noise filter** rather than just another compression step.
- **Opportunity** — Create controlled distractor settings (irrelevant documents, repeated passages, hard negatives) and measure whether summary retrieval yields larger relative gains as clutter increases.

### Hypothesis 4 — cited summaries improve faithfulness-sensitive reasoning
- **Related work**
  - **FactCC (EMNLP 2020)** — established factual consistency checking as a core summarization concern.
  - **Faithfulness work in LLM summarization (2023-2025)** — repeatedly shows abstractive summaries can omit or distort source facts.
  - **"Cite-While-You-Generate" (2026)** — demonstrates sentence/span-level evidence attribution can make summaries more verifiable.
- **Gap(s) identified** — Citation is usually studied for final answers or domain-specific summarization, not for **intermediate summaries that are later re-retrieved for reasoning**. It is still unclear whether lightweight citation markup helps small models enough to justify token overhead.
- **Opportunity** — Compare cited vs uncited intermediate summaries on faithfulness-sensitive tasks, scoring both answer accuracy and attribution / support quality.

## Cross-Hypothesis Synthesis
- **Common themes** — Long context is still poorly utilized; retrieval remains necessary; and the underexplored design space is not merely whether to summarize, but **what artifact is stored and retrieved** (flat vs hierarchical, cited vs uncited, clean vs noisy).
- **Strongest gap/opportunity match** — **Hypothesis 2** is the cleanest research wedge: hierarchical structure is intuitively useful and adjacent work exists, but there is still room for a controlled small-model study. **Hypothesis 3** is the strongest practical evaluation lens and pairs well with 1 or 2.
- **Recommended ordering** — Pursue **H1 + H3** first as a simple baseline/result package (summary retrieval under clean vs noisy settings), then **H2** as the main structural ablation, and **H4** last because citation benefits may be real but are more task- and budget-sensitive.

---

## Critique (reviewed: 2026-03-27)

### Hypothesis 1: retrieving structured intermediate summaries beats raw chunks
**Skeptic:** The gain may come from ordinary compression rather than a genuinely better retrieval unit, and summary errors could erase the exact evidence needed for final answers.
**Optimist:** This is the most direct and testable claim in the set, and it targets a real weakness of small models under tight context budgets.
**Scores:** Novelty=7, Feasibility=8, Impact=8, Testability=8, Gap=7
**Weighted: 7.6/10**

### Hypothesis 2: hierarchical summaries outperform flat summaries
**Skeptic:** The hierarchy might add engineering complexity without enough information gain, and improvements could be fragile to task choice or summary template design.
**Optimist:** This is a clean structural ablation with a credible mechanism: compositional reasoning failures often come from poor organization, not just missing facts.
**Scores:** Novelty=8, Feasibility=7, Impact=8, Testability=8, Gap=8
**Weighted: 7.8/10**

### Hypothesis 3: gains should be larger in noisy contexts
**Skeptic:** The result could be almost tautological if summaries merely strip distractors; careful controls are needed to show robustness rather than trivial denoising.
**Optimist:** It provides a strong evaluation lens and makes the contribution more practically relevant because real corpora are noisy.
**Scores:** Novelty=6, Feasibility=8, Impact=8, Testability=8, Gap=7
**Weighted: 7.4/10**

### Hypothesis 4: cited summaries improve faithfulness-sensitive reasoning
**Skeptic:** Small models may ignore citation markup, while the token overhead and annotation choices could outweigh any verification benefit.
**Optimist:** If lightweight citations work, they would make compressed memory more trustworthy and easier to audit.
**Scores:** Novelty=7, Feasibility=6, Impact=7, Testability=6, Gap=6
**Weighted: 6.4/10**

### Overall Assessment
**Average score: 7.3/10**
**Gate result:** PASS

### Recommended iteration
Proceed to brief generation with **Hypothesis 2** as the lead direction, using **Hypothesis 1** as the baseline framing and **Hypothesis 3** as the primary stress-test condition. Keep Hypothesis 4 optional unless faithfulness becomes a central deliverable.

### Strongest concern to address before brief
The brief should explicitly control for **summary quality/faithfulness as a confounder**, so any gains can be attributed to retrieval over structured intermediate summaries rather than accidental denoising or information loss.

---

## Research Brief (generated: 2026-03-27)

### Selected Hypothesis
**Hypothesis statement** — Hierarchical summaries aligned to reasoning steps (entity/event → local conclusion → global synthesis) will yield larger gains than single-pass flat summaries.

### Problem Statement
Small language models remain attractive for cost, latency, and deployability, but they struggle on long-context and multi-document reasoning tasks. The main failure mode is often not simple retrieval of a single fact, but composition: tracking entities across documents, preserving intermediate conclusions, and combining scattered evidence into a final answer. As context length grows, small models spend more of their limited budget re-reading raw text and less on actual inference.

A promising alternative is to retrieve intermediate summaries rather than only raw chunks. But not all summaries are equally useful. Flat summaries may compress content without preserving the structure needed for reasoning, while hierarchical summaries could explicitly organize evidence from local facts to document-level conclusions to a global synthesis. If that structure helps small models reason more reliably under fixed token budgets, it would offer a practical path to stronger long-context performance without requiring larger models.

This matters for research assistants, enterprise search, and any system that must answer questions over noisy document collections under cost constraints. The key open question is whether hierarchy provides a genuine reasoning benefit beyond ordinary compression, and whether that benefit survives realistic distractors and summary-faithfulness concerns.

### Research Questions
1. Does retrieving hierarchical intermediate summaries improve multi-hop and long-context reasoning accuracy for small LMs compared with flat summary retrieval and standard raw-chunk RAG under the same token budget?
2. Are any gains from hierarchical summaries larger on compositional or noisy settings where relevant evidence is distributed across documents and mixed with distractors?
3. To what extent are observed gains mediated by summary quality and faithfulness rather than by the hierarchical organization itself?

### Literature Review Summary
Recent long-context work shows that larger windows do not automatically solve reasoning over long inputs. Studies such as *Lost in the Middle* find that models often miss relevant evidence when it is buried or poorly placed, while retrieval-oriented work shows that selective access to evidence often remains competitive with brute-force long-context ingestion. Together, these results suggest that access patterns and representation choice matter as much as raw window size.

A second theme is that compositional reasoning is the harder problem. In multi-hop QA and related settings, systems often fail not because evidence is absent, but because they cannot preserve intermediate state across hops. Hierarchical and graph-based retrieval pipelines address this by organizing information into progressively more abstract units, but most prior evaluations test full systems with several moving parts rather than isolating summary structure as a controlled variable.

Summarization literature adds an important caution: compression can help, but abstractive summaries may omit decisive details or introduce distortions. This means any apparent improvement from summary retrieval could reflect denoising, template effects, or information loss rather than a true reasoning benefit from hierarchy. Faithfulness evaluation is therefore not optional; it is part of the causal test.

The clearest gap is a controlled small-model study that compares raw chunks, flat summaries, and minimal hierarchical summaries under matched token budgets, then measures performance across clean and noisy contexts. That design would let the project test whether hierarchy is genuinely useful as a retrieval unit for reasoning, rather than just intuitively appealing.

### Proposed Experiments
1. **Experiment name** — Raw Chunk RAG Baseline  
   **Method** — Evaluate a small LM on multi-hop QA using standard chunk retrieval over source documents with a fixed context budget.  
   **Hypothesis tested** — Establishes the baseline for RQ1.  
   **Success metrics** — Exact Match, F1, retrieval recall of gold evidence, inference latency.  
   **Baseline to beat** — Standard dense or BM25+dense chunk retrieval.

2. **Experiment name** — Flat Intermediate Summary Retrieval  
   **Method** — Generate one-pass summaries for retrieved document regions, index those summaries, and answer using retrieved summaries instead of raw chunks under the same token limit.  
   **Hypothesis tested** — Tests whether summary retrieval in general helps relative to raw chunks (RQ1).  
   **Success metrics** — EM/F1 improvement over raw-chunk RAG, token efficiency, evidence coverage.  
   **Baseline to beat** — Experiment 1.

3. **Experiment name** — Hierarchical Summary Retrieval  
   **Method** — Build a three-level summary pipeline (entity/event notes → local conclusions → global synthesis), retrieve across levels, and provide the selected artifacts to the small LM at answer time.  
   **Hypothesis tested** — Main test of hierarchical vs flat summaries for RQ1.  
   **Success metrics** — EM/F1, multi-hop consistency, accuracy on questions requiring cross-document composition.  
   **Baseline to beat** — Experiment 2 flat summaries and Experiment 1 raw chunks.

4. **Experiment name** — Noisy Context Stress Test  
   **Method** — Repeat Experiments 1-3 after injecting distractor documents, redundant passages, and hard negatives at controlled rates.  
   **Hypothesis tested** — Tests RQ2 on robustness under cluttered contexts.  
   **Success metrics** — Relative performance drop as noise increases, robustness slope, retrieval precision.  
   **Baseline to beat** — Flat summaries and raw-chunk RAG at each noise level.

5. **Experiment name** — Faithfulness and Information-Loss Audit  
   **Method** — Sample summary artifacts from flat and hierarchical pipelines, score them for factual support against source spans, and relate those scores to downstream QA outcomes.  
   **Hypothesis tested** — Tests RQ3 by checking whether hierarchy helps beyond summary quality confounds.  
   **Success metrics** — Attribution/support score, omission rate, correlation between summary faithfulness and answer correctness.  
   **Baseline to beat** — Flat-summary faithfulness at equal token budgets.

### Dataset Options
- **HotpotQA** — https://hotpotqa.github.io/  
  **Size / scale** — ~113k Wikipedia-based multi-hop questions.  
  **Relevant features** — Explicit multi-hop reasoning, supporting facts annotations, standard QA metrics.  
  **Known limitations** — Wikipedia domain only; some questions are solvable with shallow shortcuts.

- **MuSiQue** — https://github.com/StonyBrookNLP/musique  
  **Size / scale** — ~25k compositional multi-hop questions.  
  **Relevant features** — Designed to reduce shortcutting and increase compositional difficulty.  
  **Known limitations** — Smaller ecosystem than HotpotQA; may require more preprocessing for retrieval experiments.

- **2WikiMultihopQA** — https://github.com/Alab-NII/2wikimultihop  
  **Size / scale** — ~190k question-answer pairs.  
  **Relevant features** — Diverse reasoning relations across linked Wikipedia articles; useful for scale tests.  
  **Known limitations** — Quality and difficulty vary across subsets; some instances are relatively formulaic.

- **LongBench (selected QA/reasoning subsets)** — https://github.com/THUDM/LongBench  
  **Size / scale** — Benchmark suite spanning multiple long-context tasks.  
  **Relevant features** — Lets the project test whether gains generalize beyond classic multi-hop QA.  
  **Known limitations** — Heterogeneous tasks complicate direct comparison; some subsets fit evaluation better than others.

### Timeline (indicative)
1. Data prep + baseline: 2 weeks
2. Summary pipeline implementation and main experiments: 3 weeks
3. Noise stress tests + faithfulness audit: 2 weeks
4. Analysis + writeup: 1-2 weeks

### Open questions
- What is the minimal hierarchical template that preserves reasoning structure without spending too much token budget on formatting overhead?
- Should summaries be generated once offline, iteratively refined, or regenerated per query for harder examples?
- Which faithfulness check is practical enough to run at scale while still catching omission and abstraction errors that matter for final reasoning?

---

## Baseline Results
**Status (2026-03-27)** — Mock baseline scaffold implemented and smoke-tested under `baselines/summary-retrieval-small-lm/`.

**Run mode** — Synthetic smoke test (6 examples) to validate the packaged workflow without external dataset/model downloads.

**Headline outcome**
- Raw chunk baseline: EM **0.373**, F1 **0.445**
- Flat summary retrieval: EM **0.477**, F1 **0.549**
- Hierarchical summary retrieval: EM **0.566**, F1 **0.637**
- Noisy-context stress test preserved the same ordering, with hierarchical summaries remaining best by F1 (**0.621** vs **0.526** flat vs **0.413** raw)

**Interpretation** — The smoke test behavior matches the brief's intended direction: summary retrieval beats raw chunks, and hierarchical summaries outperform flat summaries under matched mock conditions. Faithfulness remains an open issue: estimated omission rate is slightly worse for hierarchical summaries (**0.375**) than flat summaries (**0.365**), so a real implementation should explicitly audit summary support.

**Artifacts** — `artifacts/results.json`, `artifacts/model_state.json`, and `artifacts/synthetic_dataset.json` inside the baseline project.

---

## Notes & Iteration Log
Coordinator: smoke test initialized on 2026-03-27.
Idea agent: hypotheses appended on 2026-03-27 for smoke-test validation.
