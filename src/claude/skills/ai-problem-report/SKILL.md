---
name: ai-problem-report
description: Report AI behavioural problems as GitHub issues with root cause analysis and label classification
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

# Report AI Problem

Report incidents where you have acted incorrectly or against the user's intent. Create or update GitHub issues on the `minouris/ai-devops` repository with structured root cause analysis, rule violation identification, and applicable cause labels.

## Label Taxonomy

All labels used by this skill are defined in the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md) reference skill. Root cause labels must use the format `cause: <label>` (with a space after the colon).

## Trigger

You MUST offer to invoke this skill when the user declares that you have:
- Done something incorrect or unintended
- Violated a rule or instruction
- Acted without authorisation
- Made false claims or fabricated information
- Lost context or forgotten requirements
- Proceeded without waiting for approval

Ask the user: "Would you like me to report this as an AI problem issue?"

If the user declines, stop.

## Workflow

Execute the following flows in order:

1. **Gather incident details** — see [gather-incident.md](references/gather-incident.md)
2. **Gather lost context and system prompt** — see [gather-context.md](references/gather-context.md)
3. **Identify rule violations and contributing factors** — see ai-problem-identify-violations skill
4. **Classify root causes** — see ai-problem-classify-causes skill
5. **Compose the issue** — see [compose-issue.md](references/compose-issue.md)
6. **Present report and confirm** — see [present-report.md](references/present-report.md)
7. **Submit the issue** — see [submit-issue.md](references/submit-issue.md)

## Requirements

**MUST:**
- Complete all flows before submitting
- Present the full analysis report to the user in chat before any GitHub action
- Obtain explicit user confirmation before submitting

**MUST NOT:**
- Skip any flow
- Submit without user confirmation
- Include personal data, secrets, or non-AI file identifiers in the issue
