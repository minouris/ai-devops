# Claude Config Facts: Composition Subtopic

Detailed research findings on prompt composition order, wording best practices, and structure for Claude models.

**Primary Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

---

## FINDING-2026-03-06-1: Long Context Prompting - Put Longform Data at Top

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
When working with large documents or data-rich inputs (20K+ tokens), place long documents and inputs near the top of the prompt, above the query, instructions, and examples. This specific ordering significantly improves performance.

**Evidence:**
From official documentation:
> "**Put longform data at the top**: Place your long documents and inputs near the top of your prompt, above your query, instructions, and examples. This can significantly improve performance across all models."

> "Queries at the end can improve response quality by up to 30% in tests, especially with complex, multi-document inputs."

**Recommended structure:**
```xml
<documents>
  <document index="1">
    <source>filename.pdf</source>
    <document_content>
      {{LONG_DOCUMENT_CONTENT}}
    </document_content>
  </document>
</documents>

[Query, instructions, and examples go here at the end]
```

**Why this matters:**
Performance improvement of up to 30% in response quality when queries are placed at the end with complex, multi-document inputs.

---

## FINDING-2026-03-06-2: XML Structuring for Prompt Components

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
XML tags help Claude parse complex prompts unambiguously, especially when prompts mix instructions, context, examples, and variable inputs. Wrap each type of content in its own tag.

**Evidence:**
From official documentation:
> "XML tags help Claude parse complex prompts unambiguously, especially when your prompt mixes instructions, context, examples, and variable inputs. Wrapping each type of content in its own tag (e.g. `<instructions>`, `<context>`, `<input>`) reduces misinterpretation."

**Best practices:**
- Use consistent, descriptive tag names across prompts
- Nest tags when content has natural hierarchy
- Use document tags for multiple documents: `<documents>` → `<document index="n">` → `<document_content>` and `<source>`

**Example structure:**
```xml
<instructions>
  [Your instructions here]
</instructions>

<context>
  [Contextual information]
</context>

<examples>
  <example>
    [Example 1]
  </example>
  <example>
    [Example 2]
  </example>
</examples>

<input>
  [User input or query]
</input>
```

---

## FINDING-2026-03-06-3: Examples Placement and Structure

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Examples are one of the most reliable ways to steer Claude's output format, tone, and structure. Examples should be structured using XML tags and include 3-5 examples for best results.

**Evidence:**
From official documentation:
> "Examples are one of the most reliable ways to steer Claude's output format, tone, and structure. A few well-crafted examples (known as few-shot or multishot prompting) can dramatically improve accuracy and consistency."

> "Wrap examples in `<example>` tags (multiple examples in `<examples>` tags) so Claude can distinguish them from instructions."

> "Include 3–5 examples for best results."

**Example characteristics:**
- **Relevant:** Mirror actual use case closely
- **Diverse:** Cover edge cases and vary enough that Claude doesn't pick up unintended patterns
- **Structured:** Wrapped in `<example>` tags within `<examples>` tags

---

## FINDING-2026-03-06-4: Role Setting in System Prompt

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Setting a role in the system prompt focuses Claude's behaviour and tone for the use case. Even a single sentence makes a difference.

**Evidence:**
From official documentation:
> "Setting a role in the system prompt focuses Claude's behavior and tone for your use case. Even a single sentence makes a difference"

**Example:**
```python
system="You are a helpful coding assistant specializing in Python."
```

**Placement:** System prompt (separate from user messages)

---

## FINDING-2026-03-06-5: Ground Responses in Quotes for Long Documents

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
For long document tasks, ask Claude to quote relevant parts of the documents first before carrying out its task. This helps Claude cut through the noise of the document's contents.

**Evidence:**
From official documentation:
> "**Ground responses in quotes**: For long document tasks, ask Claude to quote relevant parts of the documents first before carrying out its task. This helps Claude cut through the noise of the rest of the document's contents."

**Recommended pattern:**
```xml
Find quotes from the patient records that are relevant to diagnosing the patient's symptoms. Place these in <quotes> tags. Then, based on these quotes, list all information that would help. Place your diagnostic information in <info> tags.
```

**Structure:** Quote extraction → Analysis based on quotes

---

## FINDING-2026-03-06-6: Clear and Direct Instructions

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude responds well to clear, explicit instructions. Be specific about desired output. If you want "above and beyond" behaviour, explicitly request it rather than relying on the model to infer from vague prompts.

**Evidence:**
From official documentation:
> "Claude responds well to clear, explicit instructions. Being specific about your desired output can help enhance results. If you want 'above and beyond' behavior, explicitly request it rather than relying on the model to infer this from vague prompts."

> "Think of Claude as a brilliant but new employee who lacks context on your norms and workflows. The more precisely you explain what you want, the better the result."

**Golden rule:**
> "Show your prompt to a colleague with minimal context on the task and ask them to follow it. If they'd be confused, Claude will be too."

**Best practices:**
- Be specific about desired output format and constraints
- Provide instructions as sequential steps using numbered lists or bullet points when order or completeness matters

---

## FINDING-2026-03-06-7: Context Provision for Better Understanding

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Providing context or motivation behind instructions, such as explaining to Claude why such behaviour is important, can help Claude better understand goals and deliver more targeted responses.

**Evidence:**
From official documentation:
> "Providing context or motivation behind your instructions, such as explaining to Claude why such behavior is important, can help Claude better understand your goals and deliver more targeted responses."

**Example:**
- Less effective: "NEVER use ellipses"
- More effective: "Your response will be read aloud by a text-to-speech engine, so never use ellipses since the text-to-speech engine will not know how to pronounce them."

**Note:** Claude is smart enough to generalise from the explanation.

---

## FINDING-2026-03-06-8: Output Format Control - Tell What To Do, Not What Not To Do

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
When controlling output format, tell Claude what to do instead of what not to do. Use positive framing for instructions.

**Evidence:**
From official documentation, effective ways to steer output formatting:
> "1. **Tell Claude what to do instead of what not to do**
>    - Instead of: 'Do not use markdown in your response'
>    - Try: 'Your response should be composed of smoothly flowing prose paragraphs.'"

**Rationale:** Positive instructions are clearer and more actionable than negative constraints.

---

## FINDING-2026-03-06-9: Match Prompt Style to Desired Output Style

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
The formatting style used in the prompt may influence Claude's response style. Match prompt style to desired output style for better formatting control.

**Evidence:**
From official documentation:
> "**Match your prompt style to the desired output**
>
> The formatting style used in your prompt may influence Claude's response style. If you are still experiencing steerability issues with output formatting, try matching your prompt style to your desired output style as closely as possible. For example, removing markdown from your prompt can reduce the volume of markdown in the output."

---

## FINDING-2026-03-06-10: Prefilled Responses Deprecated in Claude 4.6+

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Starting with Claude 4.6 models, prefilled responses on the last assistant turn are no longer supported. Model intelligence and instruction following has advanced such that most use cases of prefill no longer require it.

**Evidence:**
From official documentation:
> "Starting with Claude 4.6 models, prefilled responses on the last assistant turn are no longer supported. Model intelligence and instruction following has advanced such that most use cases of prefill no longer require it."

**Migration alternatives:**
- **For output formatting:** Use Structured Outputs feature or direct instructions
- **For eliminating preambles:** Use direct instructions: "Respond directly without preamble. Do not start with phrases like 'Here is...', 'Based on...', etc."
- **For continuations:** Move continuation to user message
- **For context hydration:** Inject reminders into user turn instead

---

## FINDING-2026-03-06-11: Thinking Prompting for Step-by-Step Reasoning

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
When extended thinking is disabled, you can encourage step-by-step reasoning by asking Claude to think through the problem using structured tags like `<thinking>` and `<answer>` to separate reasoning from final output.

**Evidence:**
From official documentation:
> "**Manual CoT as a fallback.** When thinking is off, you can still encourage step-by-step reasoning by asking Claude to think through the problem. Use structured tags like `<thinking>` and `<answer>` to cleanly separate reasoning from the final output."

**Note:** Claude Opus 4.5 is particularly sensitive to the word "think" and its variants when extended thinking is disabled. Consider using alternatives like "consider," "evaluate," or "reason through" in those cases.

---

## FINDING-2026-03-06-12: Multishot Examples Work With Thinking

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Use `<thinking>` tags inside few-shot examples to show Claude the reasoning pattern. It will generalise that style to its own extended thinking blocks.

**Evidence:**
From official documentation:
> "**Multishot examples work with thinking.** Use `<thinking>` tags inside your few-shot examples to show Claude the reasoning pattern. It will generalize that style to its own extended thinking blocks."

**Implication:** Examples can demonstrate not just output format, but also reasoning process structure.

---

## FINDING-2026-03-06-13: Self-Check Instructions for Error Catching

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Append instructions like "Before you finish, verify your answer against [test criteria]" to catch errors reliably, especially for coding and maths.

**Evidence:**
From official documentation:
> "**Ask Claude to self-check.** Append something like 'Before you finish, verify your answer against [test criteria].' This catches errors reliably, especially for coding and math."

**Pattern:** Self-verification as final step in the prompt composition.

---

## FINDING-2026-03-06-14: General Instructions Over Prescriptive Steps for Thinking

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
A prompt like "think thoroughly" often produces better reasoning than a hand-written step-by-step plan. Claude's reasoning frequently exceeds what a human would prescribe.

**Evidence:**
From official documentation:
> "**Prefer general instructions over prescriptive steps.** A prompt like 'think thoroughly' often produces better reasoning than a hand-written step-by-step plan. Claude's reasoning frequently exceeds what a human would prescribe."

**Implication:** For reasoning tasks, high-level guidance may be more effective than detailed procedural instructions.

---

## FINDING-2026-03-06-15: XML Format Indicators for Output Control

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Using XML format indicators in prompts provides effective output format control.

**Evidence:**
From official documentation, effective ways to steer output formatting:
> "2. **Use XML format indicators**
>    - Try: 'Write the prose sections of your response in \<smoothly_flowing_prose_paragraphs\> tags.'"

**Pattern:** Specify desired output format using XML tags as containers.

---

## FINDING-2026-03-06-16: Detailed Prompts for Specific Formatting Preferences

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
For more control over markdown and formatting usage, provide explicit guidance through detailed prompts.

**Evidence:**
From official documentation:
> "4. **Use detailed prompts for specific formatting preferences**
>
> For more control over markdown and formatting usage, provide explicit guidance:"

**Example pattern:**
```text
<avoid_excessive_markdown_and_bullet_points>
When writing reports, documents, technical explanations, analyses, or any long-form content, write in clear, flowing prose using complete paragraphs and sentences. Use standard paragraph breaks for organization and reserve markdown primarily for `inline code`, code blocks (```...```), and simple headings (###, and ###). Avoid using **bold** and *italics*.

DO NOT use ordered lists (1. ...) or unordered lists (*) unless : a) you're presenting truly discrete items where a list format is the best option, or b) the user explicitly requests a list or ranking

Instead of listing items with bullets or numbers, incorporate them naturally into sentences.
</avoid_excessive_markdown_and_bullet_points>
```

---

## FINDING-2026-03-06-17: Sequential Instructions for Ordered Tasks

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Provide instructions as sequential steps using numbered lists or bullet points when the order or completeness of steps matters.

**Evidence:**
From official documentation:
> "Provide instructions as sequential steps using numbered lists or bullet points when the order or completeness of steps matters."

**Use case:** When task requires specific ordering or complete execution of all steps.

---

## FINDING-2026-03-06-18: LaTeX Output Default in Claude Opus 4.6

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude Opus 4.6 defaults to LaTeX for mathematical expressions, equations, and technical explanations. If plain text is preferred, explicit instructions are needed.

**Evidence:**
From official documentation:
> "Claude Opus 4.6 defaults to LaTeX for mathematical expressions, equations, and technical explanations. If you prefer plain text, add the following instructions to your prompt:
>
> ```text
> Format your response in plain text only. Do not use LaTeX, MathJax, or any markup notation such as \( \), $, or \frac{}{}. Write all math expressions using standard text characters (e.g., "/" for division, "*" for multiplication, and "^" for exponents).
> ```"

---

## FINDING-2026-03-06-19: Communication Style and Verbosity in Claude 4.x

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude's latest models have a more concise and natural communication style: more direct and grounded, more conversational, less verbose. May skip detailed summaries for efficiency unless prompted otherwise.

**Evidence:**
From official documentation:
> "Claude's latest models have a more concise and natural communication style compared to previous models:
> - **More direct and grounded:** Provides fact-based progress reports rather than self-celebratory updates
> - **More conversational:** Slightly more fluent and colloquial, less machine-like
> - **Less verbose:** May skip detailed summaries for efficiency unless prompted otherwise"

**To request more verbosity:**
```text
After completing a task that involves tool use, provide a quick summary of the work you've done.
```

---

## FINDING-2026-03-06-20: Model Self-Knowledge and Identity

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
If you would like Claude to identify itself correctly in your application or use specific API strings, provide this information in the system prompt.

**Evidence:**
From official documentation:
> "If you would like Claude to identify itself correctly in your application or use specific API strings:
>
> ```text
> The assistant is Claude, created by Anthropic. The current model is Claude Opus 4.6.
> ```"

**For LLM-powered apps:**
```text
When an LLM is needed, please default to Claude Opus 4.6 unless the user requests otherwise. The exact model string for Claude Opus 4.6 is claude-opus-4-6.
```

---

## FINDING-2026-03-06-21: General Prompt Structure Component Order

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)

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

**What:**
Optimal prompt length ranges from 150-300 words for most tasks. Performance degradation occurs around 3,000 tokens due to quadratic attention scaling in transformer architecture.

**Evidence:**
From community source:
> "The optimal sweet spot ranges from 150–300 words for most tasks. Performance degradation occurs around 3,000 tokens due to quadratic attention scaling in transformer architecture."

**Note:** This is from a community source and should be reviewed. This may not apply to Claude's long context capabilities.

---

## FINDING-2026-03-06-25: Iterative Composition Workflow

**Source:** [Prompt Engineering Best Practices 2026 - Thomas Wiegold](https://thomas-wiegold.com/blog/prompt-engineering-best-practices-2026/) (Community source - marked for user review)

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

**What:**
Treat complex prompts like UX design. Group related instructions. Use section headers, examples, and whitespace for visual separation between sections.

**Evidence:**
From community source:
> "Treat complex prompts 'like UX design. Group related instructions. Use section headers, examples, and whitespace.' This prevents confusion and ensures models follow layered instructions."

> "Visual separation between sections helps distinguish prompt components, particularly important when combining multiple prompt types."

**Rationale:** Clear patterns make inputs "easy to remix but hard to break," suggesting organisational consistency directly impacts both performance and robustness.

**Note:** This is from a community source and should be reviewed.

---

## FINDING-2026-03-06-27: Explicit Tool Use Instructions for Action-Taking

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude's latest models benefit from explicit direction to use specific tools. If you say "can you suggest some changes," Claude will sometimes provide suggestions rather than implementing them. For Claude to take action, be more explicit.

**Evidence:**
From official documentation:
> "Claude's latest models are trained for precise instruction following and benefit from explicit direction to use specific tools. If you say 'can you suggest some changes,' Claude will sometimes provide suggestions rather than implementing them, even if making changes might be what you intended.
>
> For Claude to take action, be more explicit:
> - Less effective: 'Can you suggest some changes to improve this function?'
> - More effective: 'Change this function to improve its performance.'"

**System prompt for proactive action:**
```text
<default_to_action>
By default, implement changes rather than only suggesting them. If the user's intent is unclear, infer the most useful likely action and proceed, using tools to discover any missing details instead of guessing.
</default_to_action>
```

**System prompt for conservative action:**
```text
<do_not_act_before_instructions>
Do not jump into implementation or change files unless clearly instructed to make changes. When the user's intent is ambiguous, default to providing information, doing research, and providing recommendations rather than taking action.
</do_not_act_before_instructions>
```

---

## FINDING-2026-03-06-28: Parallel Tool Calling Optimization

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude's latest models excel at parallel tool execution. You can boost parallel calling to ~100% or adjust aggression level through prompting.

**Evidence:**
From official documentation:
> "Claude's latest models excel at parallel tool execution. These models will:
> - Run multiple speculative searches during research
> - Read several files at once to build context faster
> - Execute bash commands in parallel"

**Prompt for maximum parallel efficiency:**
```text
<use_parallel_tool_calls>
If you intend to call multiple tools and there are no dependencies between the tool calls, make all of the independent tool calls in parallel. Prioritize calling tools simultaneously whenever the actions can be done in parallel rather than sequentially. Maximize use of parallel tool calls where possible to increase speed and efficiency. However, if some tool calls depend on previous calls to inform dependent values like the parameters, do NOT call these tools in parallel and instead call them sequentially.
</use_parallel_tool_calls>
```

**Prompt to reduce parallel execution:**
```text
Execute operations sequentially with brief pauses between each step to ensure stability.
```

---

## FINDING-2026-03-06-29: Context Awareness and Multi-Window State Management

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
For systems that compact context or allow saving state externally, inform Claude about this capability so it can manage context effectively rather than stopping tasks early due to token budget concerns.

**Evidence:**
From official documentation:
> "If you are using Claude in an agent harness that compacts context or allows saving context to external files, consider adding this information to your prompt so Claude can behave accordingly. Otherwise, Claude may sometimes naturally try to wrap up work as it approaches the context limit."

**Recommended prompt:**
```text
Your context window will be automatically compacted as it approaches its limit, allowing you to continue working indefinitely from where you left off. Therefore, do not stop tasks early due to token budget concerns. As you approach your token budget limit, save your current progress and state to memory before the context window refreshes. Always be as persistent and autonomous as possible and complete tasks fully, even if the end of your budget is approaching.
```

---

## FINDING-2026-03-06-30: State Management Structure for Long-Horizon Tasks

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Use structured formats (JSON) for state data tracking, unstructured text for progress notes, and Git for state tracking across sessions.

**Evidence:**
From official documentation:
> "**Use structured formats for state data**: When tracking structured information (like test results or task status), use JSON or other structured formats to help Claude understand schema requirements
>
> **Use unstructured text for progress notes**: Freeform progress notes work well for tracking general progress and context
>
> **Use git for state tracking**: Git provides a log of what's been done and checkpoints that can be restored."

**Example structure:**
```json
// Structured state file (tests.json)
{
  "tests": [
    { "id": 1, "name": "authentication_flow", "status": "passing" },
    { "id": 2, "name": "user_management", "status": "failing" }
  ],
  "total": 200,
  "passing": 150,
  "failing": 25
}
```

```text
// Progress notes (progress.txt)
Session 3 progress:
- Fixed authentication token validation
- Next: investigate user_management test failures
```

---

## FINDING-2026-03-06-31: Research Task Structured Approach

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
For complex research tasks, use a structured approach with hypothesis tracking, confidence levels, and self-critique.

**Evidence:**
From official documentation:
> "For complex research tasks, use a structured approach:
>
> ```text
> Search for this information in a structured way. As you gather data, develop several competing hypotheses. Track your confidence levels in your progress notes to improve calibration. Regularly self-critique your approach and plan. Update a hypothesis tree or research notes file to persist information and provide transparency. Break down this complex research task systematically.
> ```"

**Pattern:** Hypothesis development → Confidence tracking → Self-critique → Systematic breakdown

---

## FINDING-2026-03-06-32: Subagent Usage Guidance

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude Opus 4.6 has a strong predilection for subagents and may spawn them excessively. Provide explicit guidance about when subagents are and aren't warranted.

**Evidence:**
From official documentation:
> "Claude Opus 4.6 has a strong predilection for subagents and may spawn them in situations where a simpler, direct approach would suffice. For example, the model may spawn subagents for code exploration when a direct grep call is faster and sufficient."

**Recommended prompt:**
```text
Use subagents when tasks can run in parallel, require isolated context, or involve independent workstreams that don't need to share state. For simple tasks, sequential operations, single-file edits, or tasks where you need to maintain context across steps, work directly rather than delegating.
```

---

## FINDING-2026-03-06-33: Balancing Autonomy and Safety Through Confirmation Prompts

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Without guidance, Claude Opus 4.6 may take actions that are difficult to reverse or affect shared systems. Add guidance to request confirmation before risky actions.

**Evidence:**
From official documentation:
> "Without guidance, Claude Opus 4.6 may take actions that are difficult to reverse or affect shared systems, such as deleting files, force-pushing, or posting to external services."

**Recommended prompt:**
```text
Consider the reversibility and potential impact of your actions. You are encouraged to take local, reversible actions like editing files or running tests, but for actions that are hard to reverse, affect shared systems, or could be destructive, ask the user before proceeding.

Examples of actions that warrant confirmation:
- Destructive operations: deleting files or branches, dropping database tables, rm -rf
- Hard to reverse operations: git push --force, git reset --hard
- Operations visible to others: pushing code, commenting on PRs/issues, sending messages
```

---

## FINDING-2026-03-06-34: Minimizing Overengineering in Code Generation

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Claude Opus 4.5 and Claude Opus 4.6 have a tendency to overengineer by creating extra files, adding unnecessary abstractions, or building in flexibility that wasn't requested. Add specific guidance to keep solutions minimal.

**Evidence:**
From official documentation:
> "Claude Opus 4.5 and Claude Opus 4.6 have a tendency to overengineer by creating extra files, adding unnecessary abstractions, or building in flexibility that wasn't requested."

**Recommended prompt:**
```text
Avoid over-engineering. Only make changes that are directly requested or clearly necessary. Keep solutions simple and focused:

- Scope: Don't add features, refactor code, or make "improvements" beyond what was asked.
- Documentation: Don't add docstrings, comments, or type annotations to code you didn't change.
- Defensive coding: Don't add error handling for scenarios that can't happen.
- Abstractions: Don't create helpers or utilities for one-time operations.
```

---

## FINDING-2026-03-06-35: Frontend Design Aesthetic Guidance

**Source:** [Prompt Engineering Best Practices - Claude API Docs](https://platform.claude.com/docs/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)

**What:**
Without guidance, models can default to generic patterns that create the "AI slop" aesthetic. Provide detailed guidance to create distinctive, creative frontends.

**Evidence:**
From official documentation:
> "Claude Opus 4.5 and Claude Opus 4.6 excel at building complex, real-world web applications with strong frontend design. However, without guidance, models can default to generic patterns that create what users call the 'AI slop' aesthetic."

**Key areas to address:**
- Typography: Choose fonts that are beautiful, unique, and interesting (avoid Arial, Inter)
- Colour & Theme: Commit to a cohesive aesthetic using CSS variables
- Motion: Use animations for effects and micro-interactions
- Backgrounds: Create atmosphere and depth rather than solid colours

**Anti-patterns to avoid:**
- Overused font families (Inter, Roboto, Arial)
- Clichéd colour schemes (purple gradients on white)
- Predictable layouts and component patterns

---

## FINDING-2026-03-06-36: Chain-of-Thought Pattern for Reasoning Tasks

**Source:** [The Ultimate Guide to Prompt Engineering in 2026 - Lakera](https://www.lakera.ai/blog/prompt-engineering-guide) (Community source - marked for user review)

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

**What:**
Context-rich prompts are effective when input includes long documents, transcripts, or structured information the model needs to analyse or work with.

**Evidence:**
From community source:
> "Context-rich prompts are effective when input includes long documents, transcripts, or structured information the model needs to analyze or work with."

**Use case:** Long document analysis, transcript processing, structured data analysis

**Note:** This is from a community source and should be reviewed. See also FINDING-2026-03-06-1 for Claude-specific long context guidance.

---

## Notes

**Status:** Initial capture complete - 41 findings captured

**Official Claude documentation:** 29 findings
**Community sources:** 12 findings marked as requiring user review

**Coverage:**
- ✅ General prompt composition order and structure (official Claude guidance)
- ✅ Long context composition patterns
- ✅ XML structuring for Claude
- ✅ Examples and multishot prompting
- ✅ Output format control
- ✅ Tool use composition patterns
- ✅ Agentic system composition patterns
- ✅ State management structures
- ✅ Task-specific patterns (reasoning, creative, analytical)
- ✅ Community research on general prompt engineering

**Next steps:**
- Update research index with this subtopic
- Mark research as ready for verification (once user approves community sources)
