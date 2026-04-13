# Gather Incident Details

Reconstruct the incident from the current conversation context.

**MUST identify:**

1. **What was being attempted** — the task or operation you were performing when the problem occurred
2. **What the user disagreed with** — the specific action, output, or claim the user identified as wrong
3. **Why it was a violation** — how this contradicts rules, instructions, or reasonable expectations
4. **Skill context** — if a skill was active when the problem occurred, identify it by name and path

Record these four elements before proceeding. You will use them in all subsequent flows.

## Next Step: Gather Context

After recording incident details, read [gather-context.md](gather-context.md) to gather lost context and system prompt information. Then invoke the library skills in order:

1. Call `skill(ai-problem-identify-violations)` — pass the incident context
2. Call `skill(ai-problem-classify-causes)` — pass the violations from ai-problem-identify-violations

**IMPORTANT:** Do not skip these library skill invocations. Each step depends on the output of the previous step.
