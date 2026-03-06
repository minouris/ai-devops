# Claude Config Facts: Commands Subtopic

Detailed research findings on Commands (custom slash commands) in Claude Code.

**Source:** [https://code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) (commands merged into skills)

---

## FINDING-2026-03-04-38: Commands Merged into Skills System

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills), Web search results

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Custom commands have been merged into the skills system. Files in `.claude/commands/` still work as a legacy format, but skills are now recommended.

**Key unification:**
- A file at `.claude/commands/review.md` and a skill at `.claude/skills/review/SKILL.md` both create `/review`
- Both work the same way for invocation
- If skill and command share same name, skill takes precedence
- Existing `.claude/commands/` files keep working (backward compatible)

**Skills add these features over commands:**
- Directory for supporting files (not just single file)
- Frontmatter to control who invokes (you vs Claude)
- Ability for Claude to load automatically when relevant
- More configuration options (model, tools, hooks, etc.)

**Recommendation:** Use skills for new development. Commands continue working for backward compatibility.

---

## FINDING-2026-03-04-39: Commands File Structure (Legacy Format)

**Source:** Web search results, [Extend Claude with skills](https://code.claude.com/docs/en/skills)

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Commands are simple Markdown files in `.claude/commands/` directory. File name becomes the slash command.

**File format:**
- Location: `.claude/commands/<name>.md` or `~/.claude/commands/<name>.md`
- File name (without .md) defines command name
- File content sent as prompt to Claude
- Written in natural language (plain Markdown)

**Example structure:**
````text
.claude/commands/
├── review.md        # Creates /review command
├── deploy.md        # Creates /deploy command
└── test.md          # Creates /test command
````

**Scope:**
- Global: `~/.claude/commands/<name>.md` (all projects)
- Project: `.claude/commands/<name>.md` (this project only)

**Simple format:**
````markdown
# Content of review.md

Review the code for:
- Code quality issues
- Security vulnerabilities
- Performance problems

Provide specific recommendations for improvements.
````

---

## FINDING-2026-03-04-40: Commands Support $ARGUMENTS Placeholder

**Source:** Web search results

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Commands support `$ARGUMENTS` string substitution to insert arguments passed when invoking the command.

**Usage:**
````markdown
# Content of fix-issue.md

Fix GitHub issue $ARGUMENTS by:
1. Reading the issue description
2. Implementing the fix
3. Creating appropriate tests
4. Committing with issue reference
````

**Behavior:**
- When you run `/fix-issue 123`, `$ARGUMENTS` is replaced with `123`
- Arguments placed where `$ARGUMENTS` appears in the file
- If `$ARGUMENTS` not present, arguments appended automatically as `ARGUMENTS: <value>`

**Note:** Commands have same `$ARGUMENTS` support as skills, but not the advanced substitutions like `$ARGUMENTS[N]` or `$N` (those are skill-only features).

---

## FINDING-2026-03-04-41: Commands Support Frontmatter (Same as Skills)

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Files in `.claude/commands/` support the same frontmatter as skills, despite being in the commands directory.

**Supported frontmatter fields:**
````yaml
---
name: deploy
description: Deploy application to production
disable-model-invocation: true
user-invocable: true
allowed-tools: Bash, Read
model: sonnet
---

Command content here...
````

**Key fields:**
- `name`: Command name (optional, defaults to filename)
- `description`: When to use this command
- `disable-model-invocation`: Prevent Claude from auto-invoking
- `user-invocable`: Show in `/` menu
- `allowed-tools`: Tools Claude can use without permission
- `model`: Model to use when command active

**Note:** Skills are recommended since they support additional features (context, agent, hooks, supporting files directory).

---

## FINDING-2026-03-04-42: Commands Priority and Precedence

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
When skills and commands share the same name, skills take precedence. Commands work alongside skills in the same priority system.

**Priority order (highest to lowest):**
1. Skills (enterprise > personal > project)
2. Commands (global > project)
3. Plugin skills (namespaced, cannot conflict)

**Name conflict resolution:**
- If skill exists at `.claude/skills/review/SKILL.md`
- And command exists at `.claude/commands/review.md`
- The skill takes precedence when `/review` is invoked

**Recommendation:** Convert commands to skills for better control and features, or keep both separate names.

---

## FINDING-2026-03-04-43: Built-in Commands (Not Custom Commands)

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Built-in commands are different from custom commands. Built-in commands execute fixed logic directly, not prompts.

**Key distinction:**
- **Custom commands**: Prompt-based, stored in `.claude/commands/`
- **Built-in commands**: Fixed logic, part of Claude Code itself
- Built-in commands NOT accessible via Skill tool

**Built-in command examples:**
- `/help`: Get help with Claude Code
- `/compact`: Manually trigger conversation compaction
- `/init`: Initialize project with CLAUDE.md
- `/agents`: Manage subagents interactively
- `/permissions`: Configure permissions
- `/context`: View context window usage
- `/statusline`: Configure status line
- `/hooks`: Manage hooks interactively
- `/memory`: View and edit memory files
- `/clear`: Clear conversation
- `/resume`: Resume previous session
- `/rewind`: Rewind conversation to previous state

**Documentation:** See [interactive mode](https://code.claude.com/docs/en/interactive-mode#built-in-commands) for complete list.

---

## FINDING-2026-03-04-44: Migrating Commands to Skills

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/skills]

**What:**
Commands can be migrated to skills to gain additional features. No migration required (commands continue working), but skills offer more capabilities.

**Migration process:**
1. Create skill directory: `.claude/skills/<name>/`
2. Create SKILL.md file
3. Move command content to SKILL.md body
4. Add frontmatter (optional but recommended)
5. Delete old command file (or keep both with different names)

**Before (command):**
````text
.claude/commands/review.md
````

**After (skill):**
````text
.claude/skills/review/
└── SKILL.md
````

**What you gain:**
- Supporting files directory (templates, scripts, examples)
- Advanced frontmatter options (context, agent, hooks)
- Better organization for complex workflows
- Full feature set

**What stays the same:**
- Invocation: Still use `/review`
- Arguments: Still use `$ARGUMENTS`
- Basic behavior: Same prompt-to-Claude mechanism

---

## Notes

All 7 findings verified on 2026-03-05 against official Claude Code documentation (https://code.claude.com/docs/en/skills). All findings accepted without modifications.

**Sources:**
- [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)
- [Slash commands in SDK - Claude API Docs](https://platform.claude.com/docs/en/agent-sdk/slash-commands)
- Community guides and examples from 2026

Commands are a legacy format maintained for backward compatibility. Skills are the recommended approach for new development.
