# AI Problems Resolution Facts

**Topic:** ai-problems-resolution
**Purpose:** Document findings about AI instruction following problems, patterns, and resolution approaches
**Started:** 2026-03-05

---

## FINDING-2026-03-05-1: Rationales Improve Rule Understanding and Edge Case Application

**Date:** 2026-03-05
**Category:** Instruction Design Pattern
**Status:** External sources confirm effectiveness

### Observation

Including rationales (explanations of why a rule exists) alongside MUST/MUST NOT requirements improves AI instruction following in several ways:

1. **Principle Understanding**: Rationales help AI understand the underlying principles behind rules, not just the literal requirement
2. **Edge Case Application**: Help apply rules correctly in scenarios not explicitly covered by the literal wording
3. **Intent Preservation**: Reduce over-literal interpretation that satisfies the letter but misses the spirit of the requirement
4. **Loophole Prevention**: Help avoid finding technical loopholes by understanding what behaviour is being prevented

### Pattern Example

**Strong instruction pattern:**
```
**MUST:**
- [Requirement statement]

**Rationale:**
[Explanation of why this requirement exists and what problem it prevents]

**Example:**
[Concrete demonstration of correct vs incorrect behaviour]
```

### Supporting Evidence

**Official Anthropic Documentation:**

From Claude API prompting best practices (official docs):
> "Providing context or motivation behind your instructions, such as explaining to Claude why such behavior is important, can help Claude 4.x models better understand your goals and deliver more targeted responses."

**Academic Research:**

From "Enhancing LLM Instruction Following" (arXiv 2025):
> "Instruction understanding is a promising alternative paradigm for few-shot learning. Compared to examples, instructions provide stronger expressiveness and more stringent constraint capabilities."

From prompt engineering research (2025-2026):
> "The structure of the prompt itself was found to have a greater influence on determinism and correctness than the choice of LLM."

**Chain of Thought Research:**

Chain-of-thought reasoning and explanations have been shown to:
- Improve model accuracy on complex reasoning tasks
- Make AI decisions more auditable and aligned with ethical standards
- Help catch misbehaviour through reasoning trace monitoring
- Enable better compliance with regulatory requirements

Key finding from CoT research:
> "The accuracy of model responses improves significantly when CoT prompt engineering requires models to explain steps in logical deduction, arithmetic, and multi-step reasoning."

**Limitations:**

Chain-of-thought faithfulness research notes:
> "It is not clear whether the reasoning encoded in the CoT is a faithful representation of the internal reasoning process of the model, casting doubts about the reliability of CoT as a window onto the model's 'thought process'."

This suggests rationales work through improved instruction clarity and structure rather than directly modelling internal reasoning.

### Implications

**For Rule Design:**
- Include rationales with all MUST/MUST NOT requirements
- Rationales provide "why" context that improves instruction following
- Pattern: requirement → rationale → example creates strongest instruction

**For Verification:**
- Rationales help identify when behaviour satisfies literal requirement but violates intent
- Edge cases become more detectable when underlying principle is explicit

**For Maintenance:**
- Rationales make rules self-documenting
- Future rule modifications preserve intent when rationale is explicit

### Sources

**Official Documentation:**
- [Prompting best practices - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- [Prompting best practices - Claude Docs (Console)](https://console.anthropic.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Prompting best practices - Claude Docs](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**Academic Research:**
- [Enhancing LLM Instruction Following: An Evaluation-Driven](https://arxiv.org/pdf/2601.03359)
- [The Ultimate Guide to Prompt Engineering in 2026 | Lakera](https://www.lakera.ai/blog/prompt-engineering-guide)
- [A comprehensive taxonomy of prompt engineering techniques](https://jamesthez.github.io/files/liu-fcs26.pdf)

**Chain of Thought Research:**
- [Chain-of-Thought Is Not Explainability](https://aigi.ox.ac.uk/wp-content/uploads/2025/07/Cot_Is_Not_Explainability.pdf)
- [How to teach chain of thought reasoning to your LLM](https://invisibletech.ai/blog/how-to-teach-chain-of-thought-reasoning-to-your-llm)
- [What is chain of thought (CoT) prompting? | IBM](https://www.ibm.com/think/topics/chain-of-thoughts)
- [Chain of Thought Monitorability: A New and Fragile Opportunity for AI Safety](https://tomekkorbak.com/cot-monitorability-is-a-fragile-opportunity/cot_monitoring.pdf)

**Industry Best Practices:**
- [Prompt Engineering Techniques and Best Practices (AWS + Claude 3)](https://aws.amazon.com/blogs/machine-learning/prompt-engineering-techniques-and-best-practices-learn-by-doing-with-anthropics-claude-3-on-amazon-bedrock/)
- [Claude Prompt Engineering Best Practices (2026)](https://promptbuilder.cc/blog/claude-prompt-engineering-best-practices-2026)
- [Claude Prompt Engineering: We Tested 25 Popular Practices](https://www.dreamhost.com/blog/claude-prompt-engineering/)

### Related Observations

**Example from Current Project:**

The `fact-verification.md` file includes rationales with its requirements:

```markdown
**Rationale:**
A citation proves only that a source exists, not that the source says what the fact claims. Verification requires comparing the fact statement against the actual information in the source. The fact must accurately represent what the source documents.
```

This rationale helps prevent the failure mode of "treating existence of a citation as verification" by explaining WHY source content must be checked, not just that it must be checked.

---
