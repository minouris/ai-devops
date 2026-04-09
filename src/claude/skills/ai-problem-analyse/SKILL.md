---
name: ai-problem-analyse
description: Shared diagnostic library for AI behavioural problem analysis. Provides violation identification, root cause classification, and sub-issue preparation. Called from ai-problem-report and ai-problem-inspect-issue — not user-invocable directly.
allowed-tools: Bash, Read, Grep, Glob
---

# Analyse AI Problem

This is a library skill. It is not invoked directly by users. It is called from within the workflows of `ai-problem-report` and `ai-problem-inspect-issue`.

## Purpose

Provide shared diagnostic flows for:

- Identifying which rules were violated and what loophole allowed the violation
- Classifying which root cause labels apply
- Checking for duplicate sub-issues and composing new sub-issue bodies

## Flows

Execute these flows in order when called by a parent skill:

1. **Identify violations and contributing factors** — see identify-ai-problem-violations skill
2. **Classify root causes** — see classify-ai-problem-causes skill
3. **Check sub-issues and compose bodies** — see check-ai-problem-sub-issues skill

## Reference Data

Root cause definitions (verbatim): [root_cause_definitions.md](references/root_cause_definitions.md)

**Label Taxonomy:** All labels used by this skill are defined in the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md) reference skill. Root cause labels must use the format `cause: <label>` (with a space after the colon).

## Requirements

**MUST:**
- Execute all three flows in order
- Return all outputs to the calling skill for use in its compose and submit flows

**MUST NOT:**
- Take any action on GitHub — all GitHub operations are performed by the calling skill
- Present output directly to the user — output is returned to the calling skill
