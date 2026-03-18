# Claude Config Facts: CLAUDE.md Subtopic

Detailed research findings on CLAUDE.md files for persistent project instructions in Claude Code.

**Source:** [https://code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory)

---

## FINDING-2026-03-04-81: CLAUDE.md Overview and Purpose

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, configuration, context, overview, persistent

**What:**
CLAUDE.md is the primary configuration file for customizing Claude's behavior. It contains persistent instructions that Claude reads at the start of every session.

**Key characteristics:**
- Plain Markdown format (no frontmatter required, unlike skills/agents)
- Loaded automatically at session start
- High priority context (treated as authoritative)
- Can exist at multiple levels (organization, personal, project, local)
- Target <200 lines for best adherence

**Purpose:**
- Give Claude persistent project context
- Define coding standards and workflows
- Specify project architecture and conventions
- Override default behaviors
- Provide commands and procedures

---

## FINDING-2026-03-04-82: CLAUDE.md Locations and Scope

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, hierarchy, location, priority, scope

**What:**
CLAUDE.md can live at different locations, each with different scope and priority.

**Scope hierarchy (most to least specific):**

| Scope | Location | Purpose | Priority | Shared With |
|-------|----------|---------|----------|-------------|
| **Managed policy** | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`<br>Linux/WSL: `/etc/claude-code/CLAUDE.md`<br>Windows: `C:\Program Files\ClaudeCode\CLAUDE.md` | Organization-wide instructions managed by IT/DevOps | 1 (cannot be excluded) | All users in organization |
| **Project instructions** | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared instructions for the project | 2 | Team members via source control |
| **User instructions** | `~/.claude/CLAUDE.md` | Personal preferences for all projects | 3 | Just you (all projects) |
| **Local instructions** | `./CLAUDE.local.md` | Personal project-specific preferences, not in git | 4 (lowest) | Just you (current project) |

**Priority resolution:** More specific locations take precedence over broader ones.

**File discovery:**
- Files in directory hierarchy above working directory loaded in full at launch
- Files in subdirectories load on demand when Claude reads files in those directories

---

## FINDING-2026-03-04-83: CLAUDE.md File Format and Content

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, content, format, markdown, structure

**What:**
CLAUDE.md is plain Markdown without required structure. Content is natural language instructions.

**Format:**
- Plain Markdown (no YAML frontmatter)
- Any markdown formatting supported (headers, lists, code blocks)
- Written in natural language
- No required sections or structure

**Example content:**
````markdown
# Project Instructions

## Build Commands

Run tests: `npm test`
Build: `npm run build`
Deploy: `npm run deploy`

## Code Style

- Use 2-space indentation
- Maximum line length: 100 characters
- Use const/let, not var

## Architecture

This is a React + TypeScript application:
- Components in `src/components/`
- API calls in `src/api/`
- Tests alongside source files with `.test.ts` extension
````

**No frontmatter needed** - it's purely Markdown content.

---

## FINDING-2026-03-04-84: CLAUDE.md Best Practices

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** best-practice, claudemd, guideline, size, specificity

**What:**
Guidelines for effective CLAUDE.md files based on official documentation.

**Size recommendations:**
- Target under 200 lines
- Longer files consume more context and reduce adherence
- Split into `.claude/rules/` if growing large

**Structure guidelines:**
- Use Markdown headers and bullets for organization
- Claude scans structure like readers do
- Organized sections easier to follow than dense paragraphs

**Specificity:**
- Write concrete, verifiable instructions
- Good: "Use 2-space indentation"
- Bad: "Format code properly"
- Good: "Run `npm test` before committing"
- Bad: "Test your changes"
- Good: "API handlers live in `src/api/handlers/`"
- Bad: "Keep files organized"

**Consistency:**
- Avoid contradictions across CLAUDE.md files
- Review nested files in subdirectories
- Review `.claude/rules/` for conflicts
- Remove outdated or conflicting instructions

---

## FINDING-2026-03-04-85: CLAUDE.md Import Syntax

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, file, import, path, security

**What:**
CLAUDE.md files can import additional files using `@path/to/import` syntax. Imported files expanded and loaded into context.

**Import syntax:**
````markdown
See @README for project overview and @package.json for available npm commands.

# Additional Instructions
- git workflow @docs/git-instructions.md
````

**Path resolution:**
- Both relative and absolute paths allowed
- Relative paths resolve relative to file containing the import (NOT working directory)
- Imported files can recursively import other files
- Maximum depth: five hops

**Use cases:**
- Pull in README for project overview
- Reference package.json for commands
- Link to detailed workflow guides
- Share instructions from home directory

**Home directory imports (for worktrees):**
````markdown
# Individual Preferences
- @~/.claude/my-project-instructions.md
````

**Security:**
- First time external imports encountered, approval dialog shown
- Lists all files to be imported
- If declined, imports stay disabled (dialog doesn't reappear)

---

## FINDING-2026-03-04-86: CLAUDE.md vs Auto Memory

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** auto-memory, claudemd, comparison, memory, system

**What:**
Claude Code has two complementary memory systems that serve different purposes.

**Comparison:**

| Feature | CLAUDE.md | Auto Memory |
|---------|-----------|-------------|
| **Who writes** | You | Claude |
| **What it contains** | Instructions and rules | Learnings and patterns |
| **Scope** | Project, user, or org | Per working tree |
| **Loaded into** | Every session | Every session (first 200 lines) |
| **Use for** | Coding standards, workflows, architecture | Build commands, debugging insights, preferences Claude discovers |
| **Format** | Markdown files | `MEMORY.md` + topic files |
| **Editable** | Yes (you write it) | Yes (Claude writes, you can edit) |

**When to use CLAUDE.md:**
- Want to guide Claude's behavior explicitly
- Team-shared standards and workflows
- Static project information
- Architectural decisions

**When to use Auto Memory:**
- Let Claude learn from your corrections
- Build knowledge over time without manual effort
- Project-specific patterns discovered during work
- Personal debugging insights

**Use both:** CLAUDE.md for explicit instructions, Auto Memory for discovered patterns.

---

## FINDING-2026-03-04-87: CLAUDE.md Discovery and Loading

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, discovery, hierarchy, loading, tree

**What:**
Claude Code walks the directory tree to discover CLAUDE.md files, loading them at different times based on location.

**Discovery process:**
1. Walk up from current working directory
2. Check each directory for CLAUDE.md and CLAUDE.local.md
3. Load files in ancestor directories at launch
4. Discover files in subdirectories (load on demand when reading those files)

**Example:**
````
Working in: foo/bar/
Loads at launch:
- foo/bar/CLAUDE.md
- foo/CLAUDE.md
- ~/.claude/CLAUDE.md
- /etc/claude-code/CLAUDE.md (if exists)

Loads on demand:
- foo/bar/baz/CLAUDE.md (when reading files in baz/)
````

**Resolution order:** Project > Global > Managed

---

## FINDING-2026-03-04-88: CLAUDE.md from Additional Directories

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** additional, claudemd, directory, environment, loading

**What:**
The `--add-dir` flag gives Claude access to additional directories. By default, CLAUDE.md from these directories is NOT loaded.

**Enable loading:**
````bash
CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude --add-dir ../shared-config
````

**What gets loaded when enabled:**
- `CLAUDE.md` from additional directory
- `.claude/CLAUDE.md` from additional directory
- `.claude/rules/*.md` from additional directory

**Use case:** Sharing instructions across related projects via shared configuration directory.

**Default behavior (without env var):** Only files from main working directory loaded, not from additional directories.

---

## FINDING-2026-03-04-89: CLAUDE.md Initialization with /init

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** analysis, claudemd, generation, init, initialization

**What:**
The `/init` command generates a starting CLAUDE.md automatically by analyzing your codebase.

**What `/init` does:**
1. Analyzes codebase structure
2. Discovers build commands, test instructions
3. Identifies project conventions
4. Creates CLAUDE.md with discovered information

**Behavior:**
- If CLAUDE.md exists: Suggests improvements (doesn't overwrite)
- If CLAUDE.md missing: Creates new file
- Provides starting point to refine

**After `/init`:**
- Review generated content
- Add information Claude wouldn't discover
- Refine with specific team conventions
- Add workflow procedures

**Use case:** Quick start for new projects or when adding Claude Code to existing project.

---

## FINDING-2026-03-04-90: CLAUDE.md in Monorepos - Exclusions

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, exclusion, monorepo, policy, setting

**What:**
In large monorepos, ancestor CLAUDE.md files from other teams can be excluded using `claudeMdExcludes` setting.

**Configuration (in `.claude/settings.local.json`):**
````json
{
  "claudeMdExcludes": [
    "**/monorepo/CLAUDE.md",
    "/home/user/monorepo/other-team/.claude/rules/**"
  ]
}
````

**Behavior:**
- Patterns matched against absolute file paths using glob syntax
- Can configure at any settings layer (user, project, local, managed)
- Arrays merge across layers

**Important:** Managed policy CLAUDE.md cannot be excluded (ensures organization-wide instructions always apply).

**Use case:** Working in monorepo subdirectory where parent CLAUDE.md isn't relevant to your work.

---

## FINDING-2026-03-04-91: CLAUDE.md vs Rules vs Skills

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory), [Skills docs](https://code.claude.com/docs/en/skills)
**Verified:** [MOSTLY VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory - CLAUDE.md and rules columns confirmed; skills column consistent with cross-reference statements but would need skills docs for full verification]
**Keywords:** claudemd, comparison, rule, skill, structure

**What:**
Three ways to provide instructions to Claude, each with different characteristics.

**Comparison:**

| Feature | CLAUDE.md | Rules | Skills |
|---------|-----------|-------|--------|
| **Format** | Single Markdown file | Multiple Markdown files | Directory with SKILL.md + files |
| **Invocation** | Always loaded | Always/conditional loaded | Invoked by user/Claude |
| **Frontmatter** | None | Optional (`paths`) | Required (`name`, `description`) |
| **Scoping** | File/directory hierarchy | Path patterns (`paths` field) | Invocation-based |
| **Context** | Always in context | Always/conditional in context | Description in context, full content on invocation |
| **Best for** | General project info | Topic-specific rules | Actionable workflows |
| **Size limit** | Target <200 lines | Target <200 lines per file | Target <500 lines per SKILL.md |

**When to use each:**

**CLAUDE.md:**
- Small projects
- Getting started
- General project information
- Single-file simplicity

**Rules:**
- Large projects (split content)
- Multiple concerns/teams
- Want path-scoped instructions
- Sharing across projects (symlinks)

**Skills:**
- Repeatable workflows
- Commands to invoke
- Complex multi-step procedures
- Task automation

**Progressive disclosure:** CLAUDE.md → Rules → Skills moves from "always loaded" to "loaded on demand".

---

## FINDING-2026-03-04-92: CLAUDE.md and Context Compaction

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, compaction, persistence, reload, survival

**What:**
CLAUDE.md fully survives compaction - it's re-read from disk and re-injected after compaction.

**Compaction behavior:**
1. `/compact` or auto-compaction triggered
2. Conversation history compressed
3. CLAUDE.md re-read from disk (fresh copy)
4. CLAUDE.md re-injected into session
5. Instructions persist unchanged

**Implications:**
- Instructions in CLAUDE.md always survive compaction
- Conversational instructions (not in CLAUDE.md) are lost
- Edit CLAUDE.md during session → changes apply after compaction

**If instruction disappeared after `/compact`:**
- It was given in conversation, not in CLAUDE.md
- Add it to CLAUDE.md to make it persist

---

## FINDING-2026-03-04-93: CLAUDE.md Troubleshooting

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/memory]
**Keywords:** claudemd, debug, issue, solution, troubleshooting

**What:**
Common issues with CLAUDE.md and how to debug them.

**Claude isn't following CLAUDE.md:**

CLAUDE.md is context, not enforcement. No guarantee of strict compliance, especially for vague instructions.

**Debug steps:**
1. Run `/memory` to verify CLAUDE.md files are being loaded
2. Check file is in location that gets loaded for your session
3. Make instructions more specific (concrete > vague)
4. Look for conflicting instructions across CLAUDE.md files
5. Check file size (>200 lines reduces adherence)

**CLAUDE.md is too large:**

Files over 200 lines consume more context and may reduce adherence.

**Solutions:**
- Move detailed content to separate files referenced with `@path` imports
- Split instructions across `.claude/rules/` files
- Use skills for task-specific instructions (progressive disclosure)

**Instructions lost after `/compact`:**

CLAUDE.md fully survives compaction. If lost, it was in conversation only.

**Solution:** Add to CLAUDE.md to persist across sessions.

---

## Notes

**Verification status:** All 13 findings verified 2026-03-06
- 12 findings: VERIFIED (exact matches with official documentation)
- 1 finding (91): MOSTLY VERIFIED (CLAUDE.md and rules columns confirmed; skills column needs skills docs for full verification)

CLAUDE.md is the foundational configuration mechanism in Claude Code, serving as persistent project instructions that load automatically at session start.

Key principle: CLAUDE.md is context (high priority, authoritative), not enforced configuration. Specificity and clarity improve adherence.
