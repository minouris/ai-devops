# Identify Rule Violations and Contributing Factors

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
- System prompt excerpts recovered in [gather-context.md](gather-context.md)

**MUST:**
- Quote knowledge base findings and root cause facts verbatim when citing them as contributing factors
- Do not cite findings by ID or reference only — reproduce the relevant passage directly in the report
