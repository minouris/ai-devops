# Claude Config Facts: Prompts Subtopic - DISPROVEN

**DISPROVEN:** 2026-03-04

**Reason:** Prompts (.prompt.md files) are a GitHub Copilot convention, not a Claude Code feature. They were mistakenly included during port from Copilot to Claude Code. This entire subtopic is not relevant to Claude Code configuration.

**Original source of confusion:** Project contains `.prompt.md` files which appeared to be a configuration mechanism, but these are artifacts from GitHub Copilot, not Claude Code.

---

## FINDING-2026-03-04-60: Prompts Overview - NOT Native Feature [DISPROVEN]

**Source:** [Skills docs](https://code.claude.com/docs/en/skills), local codebase examination

**What:**
**CRITICAL: Prompts (.prompt.md files) are NOT a native Claude Code feature.** They are a PROJECT-SPECIFIC convention in this codebase, not an official Anthropic feature.

**Why this finding was made:**
The project contains files like `.claude/prompts/verify-memory-facts.prompt.md` which appeared to be a Claude Code configuration mechanism.

**Actual status:**
- Not documented in official Claude Code documentation
- Not a recognized artifact type by Claude Code
- This project's convention, likely for organizing reusable prompt text
- May be confused with Skills, which ARE native

**Correct approach:**
If you need reusable prompts in Claude Code, use Skills instead (native feature).

---

## FINDING-2026-03-04-61: This Project's Prompt File Convention [DISPROVEN]

**Source:** Local codebase examination

**What:**
This specific project uses `.prompt.md` files as a convention for storing reusable prompt templates.

**File location observed:**
- `.claude/prompts/*.prompt.md`
- Example: `verify-memory-facts.prompt.md`, `record-operation.prompt.md`

**Format observed:**
````markdown
Some prompt text with ${input:key} placeholders for variable substitution.

Example:
Please verify the following facts from ${input:topic}...
````

**Why this exists:**
This appears to be a project-specific organizational pattern, not a Claude Code feature. Possibly ported from another tool or created for this project's needs.

**Confusion source:**
Presence of these files in `.claude/` directory suggested they might be a Claude Code feature, but they are not recognized by Claude Code itself.

---

## FINDING-2026-03-04-62: Prompt Files Not Listed in Official Documentation [DISPROVEN]

**Source:** [Claude Code Documentation](https://code.claude.com/docs)

**What:**
Comprehensive review of Claude Code official documentation shows NO mention of:
- `.prompt.md` files
- Prompt artifacts
- Prompt file format
- `.claude/prompts/` directory

**Documented artifact types:**
- Skills (`.claude/skills/`)
- Subagents (`.claude/agents/`)
- Commands (`.claude/commands/`) - legacy, merged into skills
- Hooks (settings.json)
- Rules (`.claude/rules/`)
- CLAUDE.md
- Plugins (`.claude-plugin/plugin.json`)

**Conclusion:**
Prompts are not a native Claude Code feature. If they exist in this project, they are a custom convention.

---

## FINDING-2026-03-04-63: Skills as Native Alternative to Prompts [DISPROVEN]

**Source:** [Skills Documentation](https://code.claude.com/docs/en/skills)

**What:**
If the goal is reusable prompts in Claude Code, Skills are the native mechanism.

**Skills provide:**
- Reusable prompt workflows
- Argument substitution ($ARGUMENTS)
- User invocation via slash commands
- Claude auto-invocation based on description
- Supporting files and context

**Migration path (if prompts were being used):**
1. Create skill directory: `.claude/skills/my-prompt/`
2. Create SKILL.md with frontmatter
3. Place prompt content in SKILL.md body
4. Use $ARGUMENTS for variable substitution
5. Invoke via `/my-prompt`

**Example conversion:**
````markdown
---
name: my-prompt
description: When to use this prompt workflow
---

# My Prompt Workflow

[Prompt content here with $ARGUMENTS substitution]
````

---

## FINDING-2026-03-04-64: No Prompt Artifact in Claude SDK [DISPROVEN]

**Source:** [Claude Agent SDK Documentation](https://platform.claude.com/docs/en/agent-sdk)

**What:**
Review of Claude Agent SDK documentation confirms no "prompt artifact" type exists.

**SDK artifact types:**
- Skills (same as Claude Code)
- Agents (SDK version of subagents)
- Tools (custom tool definitions)
- MCP integrations

**No prompt files mentioned in SDK either.**

---

## FINDING-2026-03-04-65: Potential Source - Other AI Tools [DISPROVEN]

**Source:** Web search results, AI tooling ecosystem

**What:**
Some AI development tools use `.prompt` or `.prompt.md` files:
- Custom IDE extensions
- AI prompt management tools
- Prompt libraries and collections
- GitHub Copilot conventions (CONFIRMED)

**Hypothesis:**
This project may have adopted a convention from another tool, or created a custom pattern for organizing prompts before Skills existed in Claude Code.

**Recommendation:**
If maintaining this project convention, document it clearly as PROJECT-SPECIFIC, not a Claude Code feature.

---

## FINDING-2026-03-04-66: Verification Against Local Structure Rules [DISPROVEN]

**Source:** Local codebase rules

**What:**
The project contains structure rule files (`.claude/rules/*-structure.md`) but NO `prompt-structure.md`.

**Existing structure rules:**
- `skill-structure.md`
- `agent-structure.md`
- `command-structure.md`
- `hook-structure.md`
- `rule-structure.md`

**Missing:**
- `prompt-structure.md` (does not exist)

**Conclusion:**
Even within this project's own standards, prompts lack a structure definition, suggesting they may be:
- Legacy artifacts
- Incomplete convention
- From different system (now confirmed as Copilot)

---

## FINDING-2026-03-04-67: Recommendation - Treat as Non-Standard [DISPROVEN]

**What:**
Based on comprehensive research, prompts should be treated as:
- NOT a Claude Code native feature
- NOT documented by Anthropic
- If used in this project: PROJECT-SPECIFIC convention only

**For Claude Code configuration documentation:**
- Do NOT include prompts as a native configuration method
- If documenting this project: note as custom convention
- Recommend Skills as the native alternative

**For users asking about prompts:**
- Clarify they are not a Claude Code feature
- Suggest Skills for reusable prompt workflows
- Direct to Skills documentation

---

## FINDING-2026-03-04-6: Prompts from Core Facts File [DISPROVEN]

**Source:** `.memory/claude-config-facts.md` (archived from core facts)

**Original finding:**
This was a brief overview finding in the core facts file about "Prompts - Reusable Prompt Workflows" based on local codebase examination of `.claude/prompts/` directory.

**Why it appeared:**
- Project contains `.prompt.md` files in `.claude/prompts/` directory
- Files like `verify-memory-facts.prompt.md`, `record-operation.prompt.md` were observed
- Appeared to be a configuration mechanism like skills or agents

**Disproof:**
Same as findings 60-67 above - Prompts are a GitHub Copilot convention, not Claude Code. The `.prompt.md` files in this project are Copilot artifacts, not a native Claude Code feature.

**Archived:** 2026-03-04

---

## Notes

All findings DISPROVEN based on user clarification: Prompts are a GitHub Copilot convention, not related to Claude Code configuration.

**Actual source:** GitHub Copilot

**Findings archived:**
- FINDING-2026-03-04-6: Brief overview from core facts file
- FINDING-2026-03-04-60 through 67: Detailed subtopic research

This entire subtopic should be excluded from Claude Code configuration research.
