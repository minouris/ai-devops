# Claude Config Facts: Rules Subtopic

Detailed research findings on Rules for modular project instructions in Claude Code.

**Last Verified:** 2026-03-04
**Verification Method:** Source checking via WebFetch and direct documentation review
**Source:** [https://code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory)

---

## FINDING-2026-03-04-68: Rules Overview and Introduction

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules are modular project instructions stored in `.claude/rules/` directory. Introduced in v2.0.64, they allow organizing instructions into multiple focused files instead of one large CLAUDE.md.

**Key characteristics:**
- Plain Markdown files (`.md` extension)
- All `.md` files in directory automatically loaded into context
- Optional YAML frontmatter for path-scoping
- High priority context (treated as authoritative like CLAUDE.md)
- Supports subdirectories for organization
- Supports symlinks for sharing across projects

**Purpose:**
- Break large CLAUDE.md into focused topic files
- Scope instructions to specific file types or directories
- Share common rules across projects (via symlinks)
- Reduce context noise (path-scoped rules only load when relevant)

---

## FINDING-2026-03-04-69: Rules File Structure and Locations

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules have simple file structure with optional frontmatter. Location determines scope.

**File format:**
````markdown
---
paths:
  - "src/api/**/*.ts"
  - "lib/**/*.js"
---

# Rule Title

Rule instructions in Markdown...
````

**Scope locations:**

| Location | Scope | When Loaded |
|----------|-------|-------------|
| `.claude/rules/*.md` | Project | At launch (if no paths) or when matching files opened |
| `~/.claude/rules/*.md` | All your projects | At launch (if no paths) or when matching files opened |
| Subdirectories | Organized by topic | Discovered recursively |
| Symlinked files/dirs | Shared across projects | Resolved and loaded normally |

**Priority:** Project rules override user rules. Rules without `paths` load with same priority as CLAUDE.md.

---

## FINDING-2026-03-04-70: Path-Specific Rules (Conditional Loading)

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Optional YAML frontmatter with `paths` field allows scoping rules to specific files using glob patterns.

**Frontmatter format:**
````yaml
---
paths:
  - "src/api/**/*.ts"
  - "**/*.test.js"
---
````

**Path-scoping behavior:**
- Rules with `paths` field only load when Claude reads files matching the pattern
- Triggers when Claude reads matching files, not on every tool use
- Reduces context noise for unrelated work
- Saves context space

**Glob patterns supported:**

| Pattern | Matches |
|---------|---------|
| `**/*.ts` | All TypeScript files in any directory |
| `src/**/*` | All files under `src/` directory |
| `*.md` | Markdown files in project root only |
| `src/components/*.tsx` | React components in specific directory |
| `**/*.{ts,tsx}` | Brace expansion for multiple extensions |

**Multiple patterns:**
````yaml
---
paths:
  - "src/**/*.{ts,tsx}"
  - "lib/**/*.ts"
  - "tests/**/*.test.ts"
---
````

**Use cases:**
- API endpoint rules: `src/api/**/*.ts`
- Test conventions: `**/*.test.{js,ts}`
- Frontend rules: `src/components/**/*.{tsx,jsx}`
- Backend rules: `src/server/**/*.ts`

---

## FINDING-2026-03-04-71: Rules Without Paths (Always Loaded)

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules without `paths` frontmatter are unconditional - loaded at session launch with same high priority as CLAUDE.md.

**When to use unconditional rules:**
- General project conventions (code style, git commits)
- Workflow standards (testing, deployment)
- Cross-cutting concerns (security, documentation)
- Behavioral overrides (disable features, enforce practices)

**Example - General code style:**
````markdown
# Code Style Standards

## Formatting
- Use 2-space indentation
- Maximum line length: 100 characters
- Add trailing commas in multi-line structures

## Naming
- Use camelCase for variables and functions
- Use PascalCase for classes and components
- Use UPPER_SNAKE_CASE for constants
````

**No frontmatter needed** - file is plain Markdown. Loaded at launch for all work.

---

## FINDING-2026-03-04-72: Rules Content Structure

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory), local codebase examination

**What:**
Rules files are plain Markdown. No required structure except what makes instructions clear.

**Native requirements (from Anthropic):**
- Must be Markdown (`.md` extension)
- Optional YAML frontmatter (only `paths` field documented)
- Content is natural language instructions

**Common patterns observed (not required):**
- H1 heading for rule title
- H2 sections for topics
- Bullet lists for standards
- Code blocks for examples
- Emphasis (**bold**) for MUST/MUST NOT

**Example:**
````markdown
---
paths:
  - "src/api/**/*.ts"
---

# API Development Rules

## Request Validation

All API endpoints must:
- Validate all input parameters
- Return consistent error formats
- Include request/response logging

## Example

```typescript
async function handleRequest(req: Request) {
  // Validate input
  if (!req.body.id) {
    return { error: "Missing required field: id" };
  }
  // Process request...
}
```
````

---

## FINDING-2026-03-04-73: Rules Organization Patterns

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Multiple ways to organize rules for different project scales and team structures.

**Flat structure (simple projects):**
````text
.claude/rules/
├── code-style.md
├── testing.md
├── security.md
└── api-design.md
````

**Hierarchical structure (complex projects):**
````text
.claude/rules/
├── general/
│   ├── code-style.md
│   └── git-commits.md
├── frontend/
│   ├── react-patterns.md
│   └── styling.md
└── backend/
    ├── api-design.md
    └── database.md
````

**With symlinks (shared rules):**
````text
.claude/rules/
├── company-standards/ → ~/shared-rules/company/
├── security.md → ~/shared-rules/security.md
└── project-specific.md
````

**Discovery:** All `.md` files discovered recursively, regardless of directory structure.

---

## FINDING-2026-03-04-74: Sharing Rules Across Projects with Symlinks

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
The `.claude/rules/` directory supports symlinks for sharing rules across multiple projects. Symlinks resolved and loaded normally.

**Creating shared rules:**
````bash
# Create shared rules directory
mkdir -p ~/shared-claude-rules

# Create shared rules
echo "# Company Code Style..." > ~/shared-claude-rules/code-style.md
echo "# Security Standards..." > ~/shared-claude-rules/security.md

# Link entire directory into project
ln -s ~/shared-claude-rules .claude/rules/shared

# Or link individual files
ln -s ~/shared-claude-rules/security.md .claude/rules/security.md
````

**Behavior:**
- Symlinks resolved at session start
- Circular symlinks detected and handled gracefully
- Both directory and file symlinks supported
- Changes to shared rules affect all projects using them

**Use cases:**
- Company-wide standards (security, compliance)
- Team conventions (code style, git practices)
- Personal preferences (workflows, tooling)
- Multi-repository consistency (monorepo packages)

---

## FINDING-2026-03-04-75: User-Level Rules (Personal Preferences)

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Personal rules in `~/.claude/rules/` apply to every project on your machine. Loaded before project rules (lower priority).

**Location:** `~/.claude/rules/*.md`

**Use cases:**
- Personal coding preferences (indentation, naming)
- Preferred workflows (testing, debugging)
- Tooling shortcuts (scripts, aliases)
- General practices (documentation, commit style)

**Example structure:**
````text
~/.claude/rules/
├── preferences.md       # Personal coding preferences
├── workflows.md         # Preferred workflows
└── shortcuts.md         # Tooling shortcuts
````

**Priority:** User-level rules loaded first, then project-level rules. Project rules can override user rules.

**Recommendation:** Keep user-level rules focused on personal preferences that don't conflict with team standards.

---

## FINDING-2026-03-04-76: Excluding Specific Rules (Monorepos)

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
In large monorepos, ancestor CLAUDE.md and rules files from other teams can be excluded using `claudeMdExcludes` setting.

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
- Patterns matched against absolute file paths
- Uses glob syntax
- Can configure at any settings layer (user, project, local, managed)
- Arrays merge across layers

**Exclusion scope:**
- Can exclude specific CLAUDE.md files
- Can exclude entire rules directories
- Can exclude individual rule files
- Cannot exclude managed policy CLAUDE.md (organization-wide)

**Use case:** Working in monorepo where other teams' rules aren't relevant to your work.

---

## FINDING-2026-03-04-77: Rules vs CLAUDE.md

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules and CLAUDE.md serve the same purpose but with different organizational approaches.

**Comparison:**

| Feature | CLAUDE.md | Rules |
|---------|-----------|-------|
| **Structure** | Single file | Multiple files |
| **Organization** | Sections in one file | Separate files by topic |
| **Priority** | High (authoritative) | High (same as CLAUDE.md) |
| **Path scoping** | No | Yes (via `paths` frontmatter) |
| **Team editing** | All in one file | Distributed across files |
| **Context usage** | All content loaded | Conditional loading possible |

**When to use CLAUDE.md:**
- Small projects with few instructions
- Getting started (use `/init`)
- Prefer single-file simplicity

**When to use rules:**
- Large projects (target <200 lines per CLAUDE.md)
- Multiple teams/concerns
- Want path-scoped instructions
- Need to share rules across projects

**Can use both:** CLAUDE.md for overview/general instructions, rules for specific concerns.

---

## FINDING-2026-03-04-78: Rules Loading Behavior

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules load at different times depending on whether they have path scoping.

**Loading timing:**

| Rule Type | When Loaded | Context Window Impact |
|-----------|-------------|----------------------|
| No `paths` field | At session launch | Always in context |
| With `paths` field | When Claude reads matching files | Only in context when relevant |

**Path-scoped rule triggers:**
- Triggered when Claude reads files matching pattern
- Not on every tool use, only when reading matching files
- Allows selective loading based on what you're working on

**Use for context efficiency:**
````markdown
---
paths:
  - "tests/**/*.test.ts"
---

# Test Writing Standards

Detailed testing conventions that only load when working with test files...
````

**Result:** Testing rules don't occupy context when working on non-test code.

---

## FINDING-2026-03-04-79: Rules Best Practices

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Guidelines for effective rules usage based on official documentation.

**File size:**
- Target under 200 lines per file
- Use path scoping to reduce context noise
- Break large rules into topic-specific files

**Organization:**
- One rule file per concern (security, testing, API design)
- Use subdirectories for related rules
- Name files descriptively (not generic names)

**Content clarity:**
- Use specific, concrete instructions ("Use 2-space indentation" not "Format code properly")
- Include examples for ambiguous cases
- Structure with headers and bullets

**Consistency:**
- Review rules across files for conflicts
- Project rules should align (not contradict)
- User rules shouldn't conflict with team standards

**Maintenance:**
- Remove outdated rules promptly
- Update rules when practices change
- Use symlinks for shared/repeated rules

---

## FINDING-2026-03-04-80: Rules in Additional Directories

**Source:** [How Claude remembers your project - Claude Code Docs](https://code.claude.com/docs/en/memory)
**Verified:** [VERIFIED on 2026-03-04 by https://code.claude.com/docs/en/memory]

**What:**
Rules from `--add-dir` directories are loaded when `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` environment variable is set.

**Behavior:**
````bash
# Without environment variable: only rules in main directory loaded
claude --add-dir ../shared-config

# With environment variable: rules from additional directories also loaded
CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude --add-dir ../shared-config
````

**What gets loaded:**
- CLAUDE.md from additional directory
- `.claude/CLAUDE.md` from additional directory
- `.claude/rules/*.md` from additional directory

**Use case:** Sharing rules across multiple related projects via additional directory.

---

## Notes

All findings verified against official Claude Code documentation (code.claude.com) as of 2026-03-04.

Rules were introduced in v2.0.64 as a way to organize project instructions into modular files.

Key distinction: Rules are a native Claude Code feature from Anthropic, unlike this project's prompt conventions.
