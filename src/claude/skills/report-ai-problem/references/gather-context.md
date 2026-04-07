# Gather Lost and System Prompt Context

## Context Compaction Recovery

If the current conversation shows signs of context compaction (a summary block replacing earlier messages), recover lost context from prior chat logs.

**Compute the workspace slug** by converting every `/` in the absolute workspace path to `-`. The leading `/` also becomes `-`. Example: `/workspaces/ai-devops` → `-workspaces-ai-devops`.

Use this slug for both path lookups below.

**List prior chat logs:**

```
ls -lt ~/.claude/projects/<slug>/*.jsonl
```

**For each log file older than the current session**, extract relevant messages:

```
python3 ${CLAUDE_SKILL_DIR}/scripts/extract_chat_log.py <log_file>
```

Include recovered context that is relevant to the incident — particularly earlier instructions, corrections, or task context lost through compaction.

## System Prompt Context

**List and read** system prompt files from:

```
~/.claude/session-env/projects/<slug>/
```

Read any files that contain rules, instructions, or counter-declarations relevant to the incident. Include relevant excerpts in the Contributing Factors section of the issue.
