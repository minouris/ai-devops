# Claude Config Facts: Skills Subtopic

Detailed research findings on Skills as a Claude Code extension mechanism.

**Source:** [https://code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)

---

## FINDING-2026-03-04-15: Skills Directory Structure and File Organization

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills use a directory-based structure with SKILL.md as the required entry point and optional supporting files.

**Directory structure:**
````
.claude/skills/<skill-name>/
├── SKILL.md           # Main instructions (required)
├── template.md        # Optional template
├── examples/          # Optional examples directory
│   └── sample.md
└── scripts/           # Optional scripts directory
    └── validate.sh
````

**Scope locations and priority:**
- Enterprise: Managed settings path (highest priority)
- Personal: `~/.claude/skills/<skill-name>/SKILL.md`
- Project: `.claude/skills/<skill-name>/SKILL.md`
- Plugin: `<plugin>/skills/<skill-name>/SKILL.md` (namespaced)

**Key behaviors:**
- Only SKILL.md is required
- Supporting files are optional and referenced from SKILL.md
- Skills from `--add-dir` directories loaded automatically
- Live change detection picks up edits without restart
- Higher priority locations override lower priority when names match

---

## FINDING-2026-03-04-16: Skills Frontmatter Fields Specification

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills support comprehensive frontmatter configuration in YAML format. All fields are optional except `description` is recommended.

**Complete frontmatter fields:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `name` | string | No | directory name | Display name, becomes `/slash-command`. Lowercase, numbers, hyphens only. Max 64 chars |
| `description` | string | Recommended | first paragraph | What skill does and when to use it. Claude uses for auto-invocation decisions |
| `argument-hint` | string | No | none | Hint shown in autocomplete. Example: `[issue-number]` |
| `disable-model-invocation` | boolean | No | `false` | Prevent Claude from auto-loading. Use for manual-only workflows |
| `user-invocable` | boolean | No | `true` | Show in `/` menu. Set `false` for background knowledge |
| `allowed-tools` | string | No | inherits | Tools Claude can use without permission when skill active |
| `model` | string | No | inherits | Model to use: `sonnet`, `opus`, `haiku` |
| `context` | string | No | none | Set to `fork` to run in subagent context |
| `agent` | string | No | `general-purpose` | Subagent type when `context: fork`. Options: `Explore`, `Plan`, `general-purpose`, or custom |
| `hooks` | object | No | none | Hooks scoped to skill lifecycle |

**Example with all fields:**
````yaml
---
name: my-skill
description: What this skill does and when to use it
argument-hint: [filename] [format]
disable-model-invocation: true
user-invocable: false
allowed-tools: Read, Grep, Glob
model: sonnet
context: fork
agent: Explore
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./validate.sh"
---
````

---

## FINDING-2026-03-04-17: Skills String Substitutions and Dynamic Content

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills support string substitutions for dynamic values and command preprocessing for dynamic context injection.

**String substitution variables:**
- `$ARGUMENTS` - All arguments passed when invoking skill
- `$ARGUMENTS[N]` or `$N` - Specific argument by 0-based index
- `${CLAUDE_SESSION_ID}` - Current session ID

**Substitution behavior:**
- If `$ARGUMENTS` not present in content and arguments passed, automatically appended as `ARGUMENTS: <value>`
- Substitutions happen before content sent to Claude

**Example:**
````markdown
Fix issue $ARGUMENTS[0] in file $ARGUMENTS[1]
````
Invoked as `/fix-issue 123 auth.ts` becomes: `Fix issue 123 in file auth.ts`

**Dynamic context injection:**
- Syntax: `` !`command` ``
- Commands execute before skill content sent to Claude
- Output replaces the placeholder
- Claude receives only final result (preprocessing, not execution)

**Example:**
````markdown
PR diff: !`gh pr diff`
PR comments: !`gh pr view --comments`
````

---

## FINDING-2026-03-04-18: Skills Invocation Control and Context Loading

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills can be invoked by users or Claude, with frontmatter controlling who can invoke and when skills load into context.

**Invocation control matrix:**

| Frontmatter | You Invoke | Claude Invoke | When Loaded into Context |
|-------------|------------|---------------|--------------------------|
| (default) | Yes | Yes | Description always in context, full skill loads when invoked |
| `disable-model-invocation: true` | Yes | No | Description NOT in context, full skill loads when you invoke |
| `user-invocable: false` | No | Yes | Description always in context, full skill loads when invoked |

**Context loading behavior:**
- **Regular sessions:** Skill descriptions loaded, full content only when invoked
- **Subagents with preloaded skills:** Full skill content injected at startup (via `skills` frontmatter field in subagent)

**Character budget:**
- Skill descriptions loaded up to character budget
- Budget scales at 2% of context window, fallback 16,000 characters
- Check `/context` for excluded skills warning
- Override with `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable

---

## FINDING-2026-03-04-19: Skills Permission and Access Control

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Three methods to control which skills Claude can invoke and what tools skills can use.

**Method 1: Disable all skills**
Add to `/permissions` deny rules:
````
Skill
````

**Method 2: Allow/deny specific skills**
Permission syntax in settings.json:
````json
{
  "permissions": {
    "allow": [
      "Skill(commit)",
      "Skill(review-pr *)"
    ],
    "deny": [
      "Skill(deploy *)"
    ]
  }
}
````

**Syntax:** `Skill(name)` for exact match, `Skill(name *)` for prefix match with arguments

**Method 3: Hide individual skills**
Add to skill frontmatter: `disable-model-invocation: true`
- Removes skill from Claude's context entirely
- Blocks programmatic invocation via Skill tool

**Note:** `user-invocable` field only controls menu visibility, NOT Skill tool access. Use `disable-model-invocation: true` to block programmatic invocation.

---

## FINDING-2026-03-04-20: Skills Bundled with Claude Code

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Claude Code ships with bundled skills available in every session. These are prompt-based (not fixed logic) and can spawn parallel agents.

**Bundled skills:**

**`/simplify [focus]`:**
- Purpose: Reviews changed code for reuse, quality, efficiency
- Workflow: Spawns 3 parallel review agents (code reuse, quality, efficiency), aggregates findings, applies fixes
- Optional argument: Focus text for specific concerns (e.g., `/simplify focus on memory efficiency`)

**`/batch <instruction>`:**
- Purpose: Orchestrates large-scale parallel changes across codebase
- Workflow: Researches codebase, decomposes work into 5-30 units, presents plan, spawns background agent per unit in isolated git worktree, opens PRs
- Requirement: Git repository
- Example: `/batch migrate src/ from Solid to React`

**`/debug [description]`:**
- Purpose: Troubleshoots Claude Code session
- Workflow: Reads session debug log, optionally focuses on described issue
- Usage: `/debug` or `/debug why is the agent slow`

**Developer platform skill:**
- Activates automatically when code imports Anthropic SDK
- No manual invocation needed

---

## FINDING-2026-03-04-21: Skills Types and Patterns

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills fall into two main categories based on how they're invoked and what they contain.

**Reference content skills:**
- Purpose: Add knowledge Claude applies during current work
- Content: Conventions, patterns, style guides, domain knowledge
- Execution: Runs inline in main conversation context
- Example use cases: API conventions, code style guides, project architecture

**Example:**
````markdown
---
name: api-conventions
description: API design patterns for this codebase
---

When writing API endpoints:
- Use RESTful naming conventions
- Return consistent error formats
- Include request validation
````

**Task content skills:**
- Purpose: Step-by-step instructions for specific actions
- Content: Deployment procedures, commit workflows, code generation templates
- Execution: Often invoked directly with `/skill-name`
- Common pattern: Use `disable-model-invocation: true` for manual control

**Example:**
````markdown
---
name: deploy
description: Deploy the application to production
context: fork
disable-model-invocation: true
---

Deploy the application:
1. Run the test suite
2. Build the application
3. Push to the deployment target
````

---

## FINDING-2026-03-04-22: Skills Advanced Features

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills support advanced patterns including subagent execution, extended thinking, and generating visual output.

**Run in subagent (`context: fork`):**
- Skill content becomes prompt for subagent
- Runs in isolated context window
- Specify agent type with `agent` field
- Best for: Tasks with explicit instructions (not just guidelines)

**Example:**
````markdown
---
name: deep-research
description: Research topic thoroughly
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:
1. Find relevant files
2. Analyze code
3. Summarize findings
````

**Extended thinking (thinking mode):**
- Enable by including word "ultrathink" anywhere in skill content
- Activates extended thinking capability

**Generate visual output:**
- Skills can bundle scripts in any language
- Pattern: Generate interactive HTML files
- Use case: Codebase visualizations, reports, debugging tools
- Skills documentation includes complete codebase visualizer example

---

## FINDING-2026-03-04-23: Skills Distribution Methods

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills can be distributed at different scopes depending on audience.

**Distribution methods:**

**Project skills:**
- Path: Commit `.claude/skills/` to version control
- Scope: Team members via source control
- Use for: Project-specific workflows and conventions

**Plugins:**
- Path: Create `skills/` directory in plugin
- Scope: Where plugin is enabled
- Use for: Reusable skills across multiple projects
- Namespacing: `plugin-name:skill-name` prevents conflicts

**Managed settings:**
- Path: Deploy organization-wide through managed settings
- Scope: All users in organization (enterprise)
- Use for: Company-wide standards and workflows

---

## FINDING-2026-03-04-24: Skills Troubleshooting

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Common issues when skills don't trigger as expected or trigger too often.

**Skill not triggering:**
- Check: Description includes keywords users naturally say
- Verify: Skill appears in `What skills are available?`
- Try: Rephrasing request to match description
- Workaround: Invoke directly with `/skill-name` if user-invocable

**Skill triggers too often:**
- Fix: Make description more specific
- Alternative: Add `disable-model-invocation: true` for manual-only

**Claude doesn't see all skills:**
- Cause: Skill descriptions exceed character budget
- Budget: 2% of context window, fallback 16,000 chars
- Check: Run `/context` for excluded skills warning
- Override: Set `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable

---

## FINDING-2026-03-05-25: Skills Supporting Files Loading Behavior

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Supporting files in skill directories (templates, examples, reference docs) are loaded selectively on-demand, not all at once when the skill is invoked.

**Loading behavior:**

**On skill invocation:**
- Only `SKILL.md` (with frontmatter and main content) loads into context
- Supporting files remain unloaded

**During execution:**
- Claude reads descriptions/links in `SKILL.md` about what each supporting file contains
- Claude uses Read tool to load specific files only when needed for current task

**Progressive disclosure pattern:**

From official documentation:
> "Reference supporting files from `SKILL.md` so Claude knows what each file contains and when to load it"

> "Keep `SKILL.md` under 500 lines. Move detailed reference material to separate files."

**Example pattern:**
````markdown
# Workflow Overview
1. Phase 1: [Initial setup](references/phase-1.md)
2. Phase 2: [Processing](references/phase-2.md)
````

Claude sees these links and loads `references/phase-1.md` or `references/phase-2.md` only when executing that specific phase.

**Implications:**
- Supporting files don't consume context until actually needed
- Skills can bundle extensive reference material without bloating every invocation
- Context management responsibility falls to Claude (via Read tool) rather than automatic loading

**Context management considerations:**
- Loading many supporting files simultaneously can flood context window
- Instructions in supporting files may be pushed out if too many loaded at once
- Better to load supporting files sequentially as needed for each phase

---

## Notes

All findings captured from official Claude Code documentation but NOT YET VERIFIED.

Skills follow the Agent Skills open standard (agentskills.io) with Claude Code extensions.
