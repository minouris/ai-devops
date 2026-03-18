# Verification: FINDING-29 and FINDING-30

**Date:** 2026-03-05
**Findings:** FINDING-2026-03-05-29 and FINDING-2026-03-05-30
**Sources:** https://code.claude.com/docs/en/skills and https://agentskills.io/specification (already fetched)

---

## FINDING-2026-03-05-29: Skills Reference Files Frontmatter Requirements

**Claim:** Supporting files (reference files, templates, examples, scripts) in skill directories do not require frontmatter.

### Verification Process

**Evidence from Agent Skills Specification:**

✅ **Explicit statement about SKILL.md:**
From fetched spec:
> "The `SKILL.md` file must contain YAML frontmatter followed by Markdown content."

Required fields in frontmatter:
```yaml
---
name: skill-name
description: A description of what this skill does and when to use it.
---
```

✅ **Description of supporting files:**
From fetched spec under "Optional directories" section:
- `references/`: "Contains additional documentation that agents can read when needed"
  - Lists examples: "REFERENCE.md - Detailed technical reference", "FORMS.md - Form templates", "Domain-specific files (finance.md, legal.md, etc.)"
  - **No mention of frontmatter for these files**

- `scripts/`: "Contains executable code that agents can run"
  - **Scripts are code files, not markdown with frontmatter**

- `assets/`: "Contains static resources"
  - **Static resources don't have frontmatter**

✅ **Minimal structure:**
From fetched spec:
```
skill-name/
└── SKILL.md          # Required
```
Shows only SKILL.md is required, and only SKILL.md is shown with frontmatter requirement.

**Evidence from Claude Code Skills Documentation:**

✅ **Supporting files description:**
From fetched docs:
> "Other files are optional and let you build more powerful skills: templates for Claude to fill in, example outputs showing the expected format, scripts Claude can execute, or detailed reference documentation."

No mention of frontmatter requirements for these files.

✅ **Example structure:**
```
my-skill/
├── SKILL.md           # Main instructions (required)
├── template.md        # Template for Claude to fill in
├── examples/
│   └── sample.md      # Example output showing expected format
└── scripts/
    └── validate.sh    # Script Claude can execute
```

Only SKILL.md is noted as "required". Supporting files are described by their content purpose, not metadata requirements.

### Verification Result

**Status:** ✅ ACCEPTED

**Reasoning:**
- Both specifications explicitly require frontmatter only for SKILL.md
- Supporting files are described as content files (documentation, templates, scripts)
- No examples show frontmatter in supporting files
- No requirements or mentions of frontmatter for supporting files anywhere in either spec

**Verification tag:** [VERIFIED on 2026-03-05 by https://agentskills.io/specification]

---

## FINDING-2026-03-05-30: Skills Reference Files and Character Budget

**Claim:** Supporting files do not count toward the skill character budget. Only skill descriptions consume the budget.

### Verification Process

**Evidence from Claude Code Skills Documentation:**

✅ **Character budget description:**
From fetched docs in "Claude doesn't see all my skills" troubleshooting section:
> "Skill descriptions are loaded into context so Claude knows what's available. If you have many skills, they may exceed the character budget. The budget scales dynamically at 2% of the context window, with a fallback of 16,000 characters."

Key phrase: "**Skill descriptions** are loaded into context"

✅ **What loads when:**
From fetched docs:
> "In a regular session, skill descriptions are loaded into context so Claude knows what's available, but **full skill content only loads when invoked**."

This confirms:
- Descriptions load at startup (counted in budget)
- Full skill content loads on invocation (NOT counted in startup budget)

✅ **Context loading note:**
From fetched docs:
> "Subagents with preloaded skills work differently: the full skill content is injected at startup."

This is the exception, not the default behavior. In regular sessions, only descriptions count.

**Evidence supporting on-demand loading:**

✅ **Progressive disclosure:**
From fetched docs:
> "Reference supporting files from `SKILL.md` so Claude knows what each file contains and when to load it"

> "Keep `SKILL.md` under 500 lines. Move detailed reference material to separate files."

This guidance makes sense only if supporting files don't consume budget until loaded.

✅ **Invocation control table:**
From fetched docs, the context loading column states:
- Default: "Description always in context, full skill loads when invoked"
- disable-model-invocation: true: "Description not in context, full skill loads when you invoke"
- user-invocable: false: "Description always in context, full skill loads when invoked"

Pattern: **Description** in context vs. **full skill** loads on invocation. Supporting files are part of "full skill", not "description".

**What the budget applies to:**

From the docs, the budget metric is measured in **characters**:
- "character budget"
- "16,000 characters"
- "SLASH_COMMAND_TOOL_CHAR_BUDGET environment variable"

The description field is limited to "Max 1024 characters" per the Agent Skills spec.

**Loading sequence confirmed:**

1. **Session startup:** Descriptions loaded (budget applies)
2. **Skill invocation:** SKILL.md body loads
3. **During execution:** Supporting files loaded via Read tool on-demand

From earlier findings:
- FINDING-25 states: "On skill invocation: Only `SKILL.md` (with frontmatter and main content) loads into context"
- "Supporting files remain unloaded"
- "During execution: Claude uses Read tool to load specific files only when needed"

### Verification Result

**Status:** ✅ ACCEPTED

**Reasoning:**
- Documentation explicitly states "skill descriptions are loaded into context" for budget purposes
- "Full skill content only loads when invoked" - separate from budget calculation
- Supporting files load on-demand via Read tool, not at startup
- Character budget warning appears when descriptions exceed limit, not when supporting files exist
- Progressive disclosure pattern (move content to separate files) only makes sense if those files don't count toward budget

**However - Important nuance:**

The finding states: "not counted in **startup budget**"

This is the correct interpretation. The character budget is specifically the startup budget that determines which skill descriptions Claude sees. Once a skill is invoked:
- SKILL.md body loads (uses context, but not the "character budget" metric)
- Supporting files load on-demand (use context when loaded, but not the "character budget" metric)

The "character budget" is specifically the pre-invocation budget for skill descriptions.

**Verification tag:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

---

## Summary

**FINDING-29:** ✅ ACCEPTED - Reference files do not require frontmatter
**FINDING-30:** ✅ ACCEPTED - Reference files do not count toward character budget

Both findings verified against official documentation with strong supporting evidence.
