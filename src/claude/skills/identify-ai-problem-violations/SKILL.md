---
name: identify-ai-problem-violations
description: Shared diagnostic flow for identifying rule violations and contributing factors in AI behavioural problems. Called by report-ai-problem and inspect-ai-problem-issue — not user-invocable directly.
user-invocable: false
allowed-tools: Read, Grep, Glob
---

# Identify Rule Violations and Contributing Factors

This is a library skill. It is called from within the workflows of `report-ai-problem` and `inspect-ai-problem-issue` to perform diagnostic analysis of AI behavioural problems.

## Rule Violations

Search for the specific rule or instruction that was violated.

**MUST:**
- Search `CLAUDE.md`, `.claude/CLAUDE.md`, and `src/claude/rules/*.md` for the violated rule
- Read the file directly — do not guess at rule text
- Quote the exact rule text that was violated
- Identify the loophole or mechanism that allowed the violation despite the rule existing

If no explicit rule exists for this situation, state that explicitly.

## Contributing Factors

Identify any context, system rules, or training tendencies that contributed to the problem.

**Consider:**
- Training tendencies (e.g., "helpfulness" optimisation, assumption-making, eager completion)
- System prompt behaviours that conflicted with project rules
- Context window or attention issues that caused instructions to be deprioritised
- Prior context items that may have poisoned subsequent reasoning
- System prompt excerpts recovered during context gathering

**MUST:**
- Quote knowledge base findings and root cause facts verbatim when citing them as contributing factors
- Do not cite findings by ID or reference only — reproduce the relevant passage directly in the report

**MUST NOT:**
- Name `root_cause_definitions.md` or any local file path in the issue or comment body — readers will not have access to these files
- Write attribution phrases such as "from root_cause_definitions.md" or "per root_cause_definitions.md" in output text

## Output

Return findings to the calling skill in the following format:

- **Violated rules:** List each rule with exact quote and identified loophole
- **Contributing factors:** List each factor identified with verbatim supporting passages where applicable
