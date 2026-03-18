# Claude Config Facts: Composition - Community Sources

Community prompt engineering patterns and research from external sources.

**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Note:** All findings from community sources require user review before acceptance.

---

## FINDING-2026-03-06-21: General Prompt Structure Component Order

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** component, order, prompt, structure

**What:**
Well-structured prompts should organise elements hierarchically in this order: System Message → Instruction → Context → Examples → Output Constraints.

**Evidence:**
From community source:
> "1. **System Message** (First): 'Sets the model's behavior, tone, or role. Especially useful in API calls, multi-turn chats, or when configuring custom GPTs.'
>
> 2. **Instruction** (Second): 'Directly tells the model what to do. Should be clear, specific, and goal-oriented.'
>
> 3. **Context** (Third): 'Supplies any background information the model needs. Often a document, conversation history, or structured input.'
>
> 4. **Examples** (Fourth): 'Demonstrates how to perform the task. Few-shot or one-shot examples can guide tone and formatting.'
>
> 5. **Output Constraints** (Fifth): 'Limits or guides the response format—length, structure, or type.'"

**Rationale:** Context and background information should precede the actual task instruction, allowing models to understand scope before receiving directives.

**Note:** This is from a community source and should be reviewed. This ordering differs from Claude-specific guidance which places long documents at the top.

---

## FINDING-2026-03-06-22: Critical Information at Beginning or End (Lost-in-the-Middle Effect)

**Source:** [Prompt Engineering Best Practices 2026 - Thomas Wiegold](https://thomas-wiegold.com/blog/prompt-engineering-best-practices-2026/) citing Liu et al. (2024) (Community source - marked for user review)
**Keywords:** accuracy, information, lost-in-middle, placement, prompt

**What:**
Accuracy is highest when relevant information appears at the beginning or end of the context. There is over 30% accuracy drop for information buried in the middle.

**Evidence:**
From community source citing research:
> "Per Liu et al. (2024) research, 'accuracy is highest when relevant information appears at the beginning or end of the context, with over 30% accuracy drop for information buried in the middle.' The guidance is direct: place essential instructions at the start and conclusion, never in the middle section."

**Implication:** Critical information should never be placed in the middle of a long prompt.

**Note:** This is from a community source citing academic research and should be reviewed.

---

## FINDING-2026-03-06-23: Static-to-Variable Sequencing for Prompt Caching

**Source:** [Prompt Engineering Best Practices 2026 - Thomas Wiegold](https://thomas-wiegold.com/blog/prompt-engineering-best-practices-2026/) (Community source - marked for user review)
**Keywords:** cache, dynamic, prompt, sequencing, static

**What:**
For production systems using prompt caching, order content from least to most dynamic: System instructions and few-shot examples first, tool definitions next, user messages and query-specific data last.

**Evidence:**
From community source:
> "For production systems using prompt caching, the recommended structure orders content from least to most dynamic:
> - System instructions and few-shot examples first
> - Tool definitions next
> - User messages and query-specific data last
>
> This arrangement maximizes cache efficiency, potentially reducing costs by up to 90%."

**Rationale:** Maximises cache efficiency by placing static content that can be cached at the beginning.

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-24: Optimal Prompt Length Range

**Source:** [Prompt Engineering Best Practices 2026 - Thomas Wiegold](https://thomas-wiegold.com/blog/prompt-engineering-best-practices-2026/) (Community source - marked for user review)
**Keywords:** length, optimal, performance, prompt, token

**What:**
Optimal prompt length ranges from 150-300 words for most tasks. Performance degradation occurs around 3,000 tokens due to quadratic attention scaling in transformer architecture.

**Evidence:**
From community source:
> "The optimal sweet spot ranges from 150–300 words for most tasks. Performance degradation occurs around 3,000 tokens due to quadratic attention scaling in transformer architecture."

**Note:** This is from a community source and should be reviewed. This may not apply to Claude's long context capabilities.

---

## FINDING-2026-03-06-25: Iterative Composition Workflow

**Source:** [Prompt Engineering Best Practices 2026 - Thomas Wiegold](https://thomas-wiegold.com/blog/prompt-engineering-best-practices-2026/) (Community source - marked for user review)
**Keywords:** composition, iterative, prompt, testing, workflow

**What:**
Build prompts iteratively: start minimal, identify specific output failures, add only necessary corrections, and repeat.

**Evidence:**
From community source:
> "Build iteratively: start minimal, identify specific output failures, add only necessary corrections, and repeat."

**Workflow:** Minimal prompt → Test → Identify failures → Add corrections → Repeat

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-26: Clarity Through Hierarchy and Visual Separation

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** clarity, hierarchy, prompt, separation, visual

**What:**
Treat complex prompts like UX design. Group related instructions. Use section headers, examples, and whitespace for visual separation between sections.

**Evidence:**
From community source:
> "Treat complex prompts 'like UX design. Group related instructions. Use section headers, examples, and whitespace.' This prevents confusion and ensures models follow layered instructions."

> "Visual separation between sections helps distinguish prompt components, particularly important when combining multiple prompt types."

**Rationale:** Clear patterns make inputs "easy to remix but hard to break," suggesting organisational consistency directly impacts both performance and robustness.

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-36: Chain-of-Thought Pattern for Reasoning Tasks

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** chain-of-thought, pattern, prompt, reasoning

**What:**
Chain-of-thought prompts are recommended for tasks requiring logic, analysis, or step-by-step reasoning (maths, troubleshooting, decision-making). Encourages models to articulate reasoning process step-by-step before final answer.

**Evidence:**
From community source:
> "Chain-of-thought prompts are recommended for tasks that require logic, analysis, or step-by-step reasoning—like math, troubleshooting, or decision-making. Chain-of-Thought prompting encourages language models to articulate their reasoning process step-by-step before arriving at a final answer, significantly improving accuracy on complex reasoning tasks."

**Use case:** Maths, logic, troubleshooting, decision-making tasks

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-37: Self-Consistency Pattern for Arithmetic and Common Sense

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** arithmetic, consistency, pattern, prompt, reasoning

**What:**
Self-consistency generates multiple reasoning paths and selects the most consistent answer, particularly effective for tasks involving arithmetic or common sense.

**Evidence:**
From community source:
> "Self-consistency generates multiple reasoning paths and then selects the most consistent answer from them, particularly effective for tasks that involve arithmetic or common sense."

**Pattern:** Generate multiple paths → Select most consistent answer

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-38: Blended Pattern Composition for Complex Tasks

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** blend, complex, composition, pattern, prompt

**What:**
Blend multiple prompt styles (few-shot examples, role-based instructions, formatting constraints, chain-of-thought reasoning) into a single cohesive input for complex tasks where no single pattern is sufficient.

**Evidence:**
From community source:
> "A key technique involves blending multiple prompt styles—such as few-shot examples, role-based instructions, formatting constraints, or chain-of-thought reasoning—into a single, cohesive input, especially useful for complex tasks where no single pattern is sufficient to guide the model."

**Components to blend:**
- Few-shot examples
- Role-based instructions
- Formatting constraints
- Chain-of-thought reasoning

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-39: Completion-Style Prompts for Creative Tasks

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** completion, creative, generation, prompt, style

**What:**
Completion-style prompts work well when exploring creative text generation or testing how a model continues a story or description.

**Evidence:**
From community source:
> "Completion-style prompts work well when exploring creative text generation or testing how a model continues a story or description."

**Use case:** Creative text generation, story continuation, descriptive writing

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-40: Role-Based Prompts for Voice and Behaviour Alignment

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** behavior, prompt, role, voice

**What:**
Role-based prompts align the model's voice and behaviour with a specific context (legal adviser, data analyst, customer support agent).

**Evidence:**
From community source:
> "Role-based prompts align the model's voice and behavior with a specific context, like a legal advisor, data analyst, or customer support agent."

**Examples:** Legal adviser, data analyst, customer support agent

**Note:** This is from a community source and should be reviewed. See also FINDING-2026-03-06-4 for Claude-specific role setting guidance.

---

## FINDING-2026-03-06-41: Context-Rich Prompts for Document Analysis

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)
**Keywords:** analysis, context, document, prompt, rich

**What:**
Context-rich prompts are effective when input includes long documents, transcripts, or structured information the model needs to analyse or work with.

**Evidence:**
From community source:
> "Context-rich prompts are effective when input includes long documents, transcripts, or structured information the model needs to analyze or work with."

**Use case:** Long document analysis, transcript processing, structured data analysis

**Note:** This is from a community source and should be reviewed. See also FINDING-2026-03-06-1 for Claude-specific long context guidance.

---

---

## Notes

**Status:** Split from composition-facts.md (community findings only)
**Total findings:** 12 findings from community sources
**Requires:** User review and approval before verification

**Sources:**
- Lakera prompt engineering guide (2026)
- Thomas Wiegold prompt engineering best practices (2026)

