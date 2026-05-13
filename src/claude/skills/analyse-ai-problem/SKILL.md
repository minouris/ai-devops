---
name: analyse-ai-problem
description: Shared diagnostic library for AI behavioural problem analysis. Provides violation identification, root cause classification, and sub-issue preparation. Called from report-ai-problem and inspect-ai-problem-issue — not user-invocable directly.
allowed-tools: Bash, Read, Grep, Glob
---

# Analyse AI Problem

This is a library skill. It is not invoked directly by users. It is called from within the workflows of `report-ai-problem` and `inspect-ai-problem-issue`.

## Purpose

Provide shared diagnostic flows for:

- Identifying which rules were violated and what loophole allowed the violation
- Classifying which root cause labels apply
- Checking for duplicate sub-issues and composing new sub-issue bodies

## Flows

Execute these flows in order when called by a parent skill:

1. **Identify violations and contributing factors** — see [identify-violations.md](references/identify-violations.md)
2. **Classify root causes** — see [classify-causes.md](references/classify-causes.md)
3. **Check sub-issues and compose bodies** — see [check-sub-issues.md](references/check-sub-issues.md)

## Reference Data

Root cause definitions (verbatim): [root_cause_definitions.md](references/root_cause_definitions.md)

## Requirements

**MUST:**
- Execute all three flows in order
- Return all outputs to the calling skill for use in its compose and submit flows

**MUST NOT:**
- Take any action on GitHub — all GitHub operations are performed by the calling skill
- Present output directly to the user — output is returned to the calling skill
