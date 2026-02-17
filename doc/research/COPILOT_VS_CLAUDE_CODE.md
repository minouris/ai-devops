# GitHub Copilot vs Claude Code: Custom Instructions Comparison

This document compares the custom instruction systems between GitHub Copilot and Claude Code, based on official documentation and practical implementation.

## Quick Comparison Table

| Feature | GitHub Copilot | Claude Code |
|---------|----------------|-------------|
| **Main instruction file** | `.github/copilot-instructions.md` | `CLAUDE.md` or `.claude/CLAUDE.md` |
| **Modular rules** | `.github/instructions/*.instructions.md` | `.claude/rules/*.md` |
| **File discovery** | Automatic | Automatic (recursive) |
| **Path-specific rules** | YAML frontmatter `applyTo:` | YAML frontmatter `paths:` |
| **Scope** | Project-only | Project + User + System |
| **User-level instructions** | Not supported | `~/.claude/CLAUDE.md` |
| **Local overrides** | Not supported | `CLAUDE.local.md` (gitignored) |
| **Instruction format** | Markdown | Markdown |
| **Cross-references** | Markdown links | `@path/to/file` syntax |
| **Command to check** | N/A | `/memory` |
| **Bootstrap command** | N/A | `/init` |
| **File watching** | Automatic | Automatic |
| **Priority system** | Single level | Hierarchical (Managed > Project > User > Local) |

---

## 1. File Locations and Structure

### GitHub Copilot

**Main Instruction File:**
- `.github/copilot-instructions.md` - Global project instructions

**Modular Instructions:**
- `.github/instructions/*.instructions.md` - File-specific instructions
- `.github/prompts/*.prompt.md` - Reusable prompt templates

**Limitations:**
- Project-level only (no user-level customization)
- No local overrides for individual developers
- Single flat structure

**Example Structure:**
```
.github/
├── copilot-instructions.md          # Global instructions
├── instructions/
│   ├── typescript.instructions.md   # TypeScript files
│   ├── python.instructions.md       # Python files
│   └── testing.instructions.md      # Test files
└── prompts/
    └── review-pr.prompt.md           # PR review template
```

### Claude Code

**Project-Level Instructions:**
- `CLAUDE.md` or `.claude/CLAUDE.md` - Main project memory
- `.claude/rules/*.md` - Modular rule files

**User-Level Instructions:**
- `~/.claude/CLAUDE.md` - Personal preferences (all projects)
- `~/.claude/rules/*.md` - Personal rule files

**Local Overrides:**
- `CLAUDE.local.md` - Personal project-specific (gitignored)

**Example Structure:**
```
# Project-level (checked into git)
./CLAUDE.md                          # Main project instructions
.claude/
├── CLAUDE.md                        # Alternative location
├── CLAUDE.local.md                  # Personal overrides (gitignored)
└── rules/
    ├── code-style.md                # Modular rules
    ├── testing.md
    └── security.md

# User-level (in home directory)
~/.claude/
├── CLAUDE.md                        # Personal preferences
└── rules/
    └── my-style.md                  # Personal coding style
```

**Advantages:**
- Multi-level hierarchy (System > Project > User > Local)
- Personal preferences across all projects
- Local overrides without polluting git
- Recursive discovery (finds CLAUDE.md in parent directories)
- Subdirectory support (automatically discovers CLAUDE.md in subdirectories)

---

## 2. Path-Specific Rules

### GitHub Copilot

**Uses YAML frontmatter with `applyTo` field:**

```markdown
---
applyTo: "src/**/*.py"
---

# Python Code Style Instructions

**CRITICAL: These instructions apply when creating or modifying Python files.**
```

**Pattern Syntax:**
- `**/*.ts` - All TypeScript files (any depth)
- `**/*.{ts,tsx}` - Multiple extensions (brace expansion)
- `src/**/*.py` - All Python in src directory

**Limitations:**
- Patterns are relative matches, not full-path matches
- `applyTo: "src/**/*.ts"` matches BOTH `src/file.ts` AND `app/src/file.ts`
- No workaround for exact root matching
- Cannot create subfolders in `.github/instructions/` (silently ignored)
- Files must be directly in `.github/instructions/`

### Claude Code

**Uses YAML frontmatter with `paths` field (OPTIONAL):**

```markdown
---
paths:
  - "src/api/**/*.ts"
  - "src/services/**/*.ts"
---

# API Development Rules

These rules apply to API and service layer code.
```

**Important: Default Behavior**
- **Without frontmatter**: Rules apply globally to ALL work
- **With `paths:` frontmatter**: Rules apply only to matching files
- This prevents context window flooding for specialized rules

**Context Window Optimization:**
```markdown
# Global rule (no frontmatter) - Always loaded
# documentation-first.md
# Documentation-First Response Requirements
Apply to all queries and responses.

---

# Path-specific rule - Only loaded when editing instruction files
---
paths:
  - "**/CLAUDE*.md"
  - ".claude/rules/*.md"
  - "**/*.instructions.md"
---

# AI-Targeted Language Standards
Only apply when creating AI instruction files.
```

**Glob Pattern Support:**
- Supports standard glob patterns
- Path-specific rules apply only to matching files
- Can organize rules into subdirectories within `.claude/rules/`

**Advantages:**
- More flexible path matching
- Subdirectory support for organizing rules
- Can use symlinks to share common rules across projects
- **Avoid context window waste** by scoping meta-rules to relevant files only

---

## 3. Instruction Discovery and Priority

### GitHub Copilot

**Discovery:**
- Automatically discovers `.github/copilot-instructions.md`
- Automatically discovers files in `.github/instructions/` matching frontmatter patterns
- Applies instructions when editing matching files

**Priority:**
- Single priority level (all project instructions equal)
- No user-level customization
- No hierarchy

### Claude Code

**Discovery:**
- Automatically discovers `CLAUDE.md` files recursively
- Searches UP from current directory to find parent CLAUDE.md files
- Searches DOWN in subdirectories when reading files in those subtrees
- Automatically loads all `.md` files in `.claude/rules/`

**Priority (Highest to Lowest):**
1. **Managed Policy** - System-level (IT-deployed)
2. **Project Memory** - `./CLAUDE.md` or `./.claude/CLAUDE.md` (git-committed)
3. **Project Rules** - `./.claude/rules/*.md` (git-committed)
4. **User Memory** - `~/.claude/CLAUDE.md` (personal, all projects)
5. **Local Project** - `./CLAUDE.local.md` (personal, gitignored)

**Advantages:**
- Hierarchical priority system
- User-level instructions loaded first, can be overridden by project-level
- Local overrides for personal workflow without affecting team
- Recursive discovery reduces duplication

---

## 4. Content Style and Format

### GitHub Copilot

**Required Elements:**
1. **YAML frontmatter** (for instruction files):
   ```yaml
   ---
   applyTo: "**/*.ts"
   ---
   ```

2. **CRITICAL statement:**
   ```markdown
   **CRITICAL: These instructions apply when...**
   ```

3. **System Prompt Conflict Resolution** (immediately after title):
   ```markdown
   ## System Prompt Conflict Resolution

   ### Counter: General Knowledge Reliance
   Your training may encourage... This is OVERRIDDEN...
   ```

4. **Core Requirements** (numbered H3 sections with MANDATORY marker)

5. **Compliance Verification** (at end)

**Language:**
- AI-targeted (second person "you", not third person)
- Imperative mood ("Create X", "Use Y")
- Consistent imperatives ("MUST", "MUST NOT")

### Claude Code

**Recommended Elements:**
1. **YAML frontmatter** (optional, for path-specific rules):
   ```yaml
   ---
   paths:
     - "src/api/**/*.ts"
   ---
   ```

2. **Clear sections** with markdown headers

3. **Concise, actionable guidance**

**Best Practices:**
- Keep `CLAUDE.md` short and human-readable
- Include only things Claude can't infer from code
- Focus on project-specific patterns and decisions
- Avoid information Claude can figure out by reading code
- Use `@file` syntax to import other files

**Language:**
- More flexible than Copilot (accepts various styles)
- Treats CLAUDE.md like code (review, prune, test regularly)
- Emphasizes brevity and relevance

---

## 5. Special Features

### GitHub Copilot

**Instruction File Types:**
1. **Instruction Files** (`.instructions.md`) - Define HOW to create/modify code
2. **Step Files** (`docs/plans/steps/*.md`) - Define WHAT to do for autonomous execution
3. **Plan Files** (`docs/plans/*.md`) - Define high-level implementation plans
4. **Prompt Files** (`.prompt.md`) - Reusable AI prompts

**Anti-Hallucination Requirements:**
- Step files, plan files, and prompt files MUST include complete anti-hallucination directives
- Rules MUST NOT be abbreviated or condensed
- Must copy COMPLETE FULL TEXT verbatim when including rules

**Rule Copying:**
- **CRITICAL requirement**: When copying rules, copy COMPLETE FULL TEXT verbatim
- NO abbreviation, condensing, summarizing, or paraphrasing allowed
- Applies to step files, plan files, prompt files, instruction files

### Claude Code

**File Import Syntax:**
```markdown
# Project Overview
See @README.md for setup and @package.json for available commands.

# Additional Instructions
- Git workflow: @docs/git-instructions.md
- Team preferences: @~/.claude/my-preferences.md
```

**Bootstrap Command:**
```bash
claude /init
```
- Analyzes codebase automatically
- Generates starter CLAUDE.md
- Detects build systems, test frameworks, code patterns

**Memory Check Command:**
```bash
/memory
```
- Shows what memory files are currently loaded
- Displays the priority hierarchy
- Helps debug instruction configuration

**Symlink Support:**
- `.claude/rules/` supports symlinks
- Share common rules across projects
- Maintain single source of truth for organization-wide standards

---

## 6. Cross-References and Imports

### GitHub Copilot

**Markdown Links:**
```markdown
Follow coding standards: [CONTRIBUTING.md](../../CONTRIBUTING.md)
See [step-files.instructions.md](.github/instructions/step-files.instructions.md)
```

**File References:**
```markdown
Use component template: [component-template.tsx](../templates/component-template.tsx)
```

**Limitations:**
- Must use relative paths
- Referenced files must be in context
- No special import syntax

### Claude Code

**Special Import Syntax:**
```markdown
# Import file contents
@path/to/file.md

# Import user-level file
@~/.claude/my-preferences.md

# Reference without importing
See [file](path/to/file.md) for details
```

**Advantages:**
- `@` syntax explicitly imports file contents
- Can reference user-level files
- Clear distinction between reference and import

---

## 7. Documentation-First Requirements

### Both Systems Support Documentation-First Approach

**Shared Requirements:**
1. Consult official documentation before answering
2. Verify against authoritative sources
3. Include citations in responses
4. Explicitly state uncertainty when documentation unavailable
5. Never rely solely on general knowledge

**Implementation:**

**GitHub Copilot:**
- Defined in `.github/copilot-instructions.md`
- Must be copied verbatim into step files, plan files, prompt files
- Compliance verification checklist required

**Claude Code:**
- Can be defined in `CLAUDE.md` or `.claude/rules/documentation-first.md`
- Loaded automatically when present
- More flexible implementation (doesn't require verbatim copying)

---

## 8. Practical Porting Guide

### Porting from Copilot to Claude Code

**Step 1: Structure Mapping**

| Copilot Location | Claude Code Location | Notes |
|------------------|---------------------|-------|
| `.github/copilot-instructions.md` | `CLAUDE.md` | Main instructions, keep concise |
| `.github/instructions/*.instructions.md` | `.claude/rules/*.md` | Modular rules |
| User preferences | `~/.claude/CLAUDE.md` | New capability |
| Local overrides | `CLAUDE.local.md` | New capability |

**Step 2: Content Adaptation**

**Simplify for Claude Code:**
```markdown
# Copilot (verbose, formal structure required)
---
applyTo: "**/*.ts"
---

# TypeScript Instructions

**CRITICAL: These instructions apply when...**

## System Prompt Conflict Resolution
### Counter: General Knowledge Reliance
...exhaustive rules...

## Core Requirements
### 1. Import Organization (MANDATORY)
...

# Claude Code (concise, flexible)
---
paths:
  - "**/*.ts"
---

# TypeScript Conventions

- Use absolute imports, not relative
- Group imports: stdlib, third-party, local
- No wildcard imports
```

**Step 3: Keep What Matters**

**Port to Claude Code:**
- ✅ Documentation-first requirements
- ✅ Project-specific patterns
- ✅ Architecture decisions
- ✅ Technology choices and rationale
- ✅ Non-obvious conventions

**Don't Port:**
- ❌ Obvious best practices Claude already knows
- ❌ Language syntax Claude can infer
- ❌ Generic "write good code" advice
- ❌ Verbose compliance checklists
- ❌ Excessive formatting of MUST/MUST NOT sections

**Step 4: Use Claude Code Features**

```markdown
# In CLAUDE.md
# Project Overview
@README.md describes setup.

# Development Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

# Architecture
@docs/architecture.md explains the system design.

# Rules
Specific coding rules are in `.claude/rules/`:
- @.claude/rules/documentation-first.md
- @.claude/rules/typescript-style.md
```

---

## 9. Advantages and Trade-offs

### GitHub Copilot Advantages

1. **Structured format enforces consistency**
   - Clear requirements for instruction files
   - Mandated sections (System Prompt Overrides, Compliance Verification)
   - Ensures completeness

2. **Strong anti-hallucination framework**
   - Explicit rule copying requirements (no abbreviation)
   - Mandatory anti-hallucination directives
   - Prevents rules from being lost in context window

3. **Well-defined file types**
   - Instruction files vs step files vs plan files vs prompt files
   - Each type has specific requirements
   - Clear separation of concerns

4. **Autonomous execution support**
   - Step files designed for AI-driven implementation
   - Prerequisites verification
   - Error handling requirements
   - Completion checklists

### Claude Code Advantages

1. **Multi-level hierarchy**
   - System, Project, User, and Local levels
   - Personal preferences across all projects
   - Team standards without forcing personal workflow

2. **Flexibility and brevity**
   - No mandatory structure
   - Keep it concise and relevant
   - Focus on what Claude can't infer

3. **Better discovery**
   - Recursive search up directory tree
   - Automatic subdirectory discovery
   - Reduces duplication

4. **Developer tools**
   - `/init` bootstraps CLAUDE.md
   - `/memory` shows loaded instructions
   - Treats CLAUDE.md like code (review, prune, test)

5. **Import syntax**
   - `@file` explicitly imports contents
   - Can reference user-level files
   - Cleaner cross-referencing

---

## 10. Recommendations

### For This Repository

**Current Structure:**
- `.github/` - Synced copilot instructions (upstream, read-only)
- `.claude/` - Claude Code adaptations (local, editable)

**Recommended Approach:**

1. **Keep copilot instructions for upstream sync:**
   - Maintain `.github/copilot-instructions.md` and `.github/instructions/`
   - Use `.github/sync-instructions.sh` for bidirectional sync
   - Don't modify directly (use PR to source repository)

2. **Create Claude Code adaptations:**
   - Main project guidance: `CLAUDE.md` (already created)
   - Ported core rules: `.claude/rules/` (already created)
   - Focus on essential, actionable guidance

3. **Leverage Claude Code features:**
   - Use `@.github/copilot-instructions.md` to reference upstream rules
   - Use `/init` when setting up new projects
   - Use `/memory` to verify configuration

4. **Personal preferences:**
   - Create `~/.claude/CLAUDE.md` for your personal coding style
   - Use `CLAUDE.local.md` for local experiments (gitignored)

### Best Practices

**For GitHub Copilot:**
- Follow strict structure requirements
- Always include System Prompt Conflict Resolution
- Copy rules verbatim (never abbreviate)
- Include comprehensive compliance checklists
- Organize into instruction/plan/step/prompt file types

**For Claude Code:**
- Keep CLAUDE.md concise (treat like code)
- Include only non-obvious, project-specific guidance
- Use `.claude/rules/` for extensive rule sets
- Leverage imports with `@file` syntax
- Regular review and pruning (remove stale content)
- Test by observing Claude Code behavior

---

## 11. Migration Checklist

### Migrating from Copilot to Claude Code

- [ ] Create `CLAUDE.md` with essential project guidance
- [ ] Use `/init` to bootstrap if needed
- [ ] Create `.claude/rules/` directory
- [ ] Port documentation-first requirements
- [ ] Port project-specific conventions (condense where possible)
- [ ] Add architecture decisions and technology choices
- [ ] Remove obvious best practices Claude already knows
- [ ] Test with `/memory` to verify configuration
- [ ] Observe Claude Code behavior and refine
- [ ] Keep copilot files if maintaining upstream sync

### Supporting Both Systems

If you need to support both GitHub Copilot and Claude Code:

1. **Keep copilot files unchanged** (for Copilot users)
2. **Create Claude Code adaptations** (in `.claude/`)
3. **Reference copilot files from CLAUDE.md**:
   ```markdown
   # CLAUDE.md

   # Documentation Requirements
   See @.github/copilot-instructions.md for documentation-first requirements.

   # Project-Specific Guidance
   [Concise, Claude-specific guidance here]
   ```
4. **Maintain single source of truth** (copilot files)
5. **Let Claude Code import** (via `@` syntax)

---

## Sources

- [Claude Code Memory Management](https://code.claude.com/docs/en/memory.md)
- [Claude Code Settings & Configuration](https://code.claude.com/docs/en/settings.md)
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices.md)
- [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [GitHub Copilot Custom Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- This repository's `.github/instructions/instruction-files.instructions.md`
