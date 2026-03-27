# Failure Note — cited intermediate summaries

- idea: Use explicit citation links inside intermediate summaries so small models can verify evidence during long-context reasoning.
- why it failed: The likely benefit is weak relative to its token and formatting overhead. Small models may ignore citation markup, and any measured gain could disappear once budget is matched fairly.
- evidence or reasoning: In the current draft, this direction already has the weakest critique score and the clearest reviewer objection. It adds annotation complexity without a strong mechanism showing better reasoning rather than better prompting.
- whether to revisit later: Revisit only if faithfulness/auditability becomes a primary deliverable or if a cheap citation format shows clear use in pilot traces.
