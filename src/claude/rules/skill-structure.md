---
paths:
  - "**/.claude/skills/**/*"
  - "**/claude/skills/**/*"
---

# Skill Structure Standards

Enforces required structure for skill artifacts based on Claude Code native skills feature and Agent Skills specification.

---

## System Prompt Conflict Resolution

### Counter: Human-Targeted Documentation Style

Your training may encourage writing skills as documentation about what skills do. This is OVERRIDDEN. Write skill content as direct instructions to Claude using AI-targeted language (second person "you", imperative mood).

### Counter: Monolithic File Preference

Your training may prefer single-file simplicity. This is OVERRIDDEN. Keep SKILL.md under 500 lines and use supporting files for detailed reference material to enable progressive disclosure.

### Counter: Uniform Frontmatter Requirements

Your training may expect all files in a directory to have consistent frontmatter. This is OVERRIDDEN. Only SKILL.md requires frontmatter; supporting files are plain markdown or scripts without frontmatter.

---

## Directory Structure Requirements (MANDATORY)

**MUST:**
- Place skill directory in `.claude/skills/<skill-name>/`
- Include `SKILL.md` as the main entry point (required)
- Use lowercase with hyphens for skill directory name (e.g., `my-skill`, not `MySkill` or `my_skill`)
- Keep SKILL.md filename exactly as `SKILL.md` (uppercase)

**MUST NOT:**
- Create skills outside `.claude/skills/` directory (unless in plugin or managed settings)
- Use different casing for SKILL.md filename (not `skill.md` or `Skill.md`)
- Use underscores or spaces in skill directory name

**Rationale:**
Skills are a native Claude Code feature. Directory and filename conventions are required for Claude Code to discover and load skills correctly.

**Minimal valid structure:**
```
.claude/skills/my-skill/
└── SKILL.md
```

**Structure with supporting files:**
```
.claude/skills/my-skill/
├── SKILL.md           # Main instructions (required)
├── references/        # Detailed reference documentation
│   ├── phase-1.md
│   └── phase-2.md
├── examples/          # Example outputs or templates
│   └── sample.md
├── scripts/           # Executable utilities
│   └── helper.py
└── assets/            # Static resources (templates, schemas)
    └── template.json
```

---

## SKILL.md Frontmatter Requirements (MANDATORY)

**MUST:**
- Include valid YAML frontmatter at start of SKILL.md
- Include `description` field (Claude uses this for auto-invocation decisions)
- Use lowercase with hyphens for `name` field value
- Keep `description` to one sentence explaining when to use the skill

**MUST NOT:**
- Omit frontmatter entirely from SKILL.md
- Use multi-sentence descriptions
- Include special characters in `name` field (only lowercase letters, numbers, hyphens)
- Exceed 64 characters for `name` field

**Required and optional frontmatter fields:**

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `name` | No | directory name | Skill name (becomes `/slash-command`) |
| `description` | Recommended | first paragraph | When to use this skill (one sentence) |

**Optional control fields:**

| Field | Type | Default | Use When |
|-------|------|---------|----------|
| `argument-hint` | string | none | Skill accepts arguments (e.g., `[filename]`) |
| `disable-model-invocation` | boolean | `false` | Skill is manual-only (not auto-invoked) |
| `user-invocable` | boolean | `true` | Skill is background knowledge (hide from `/` menu) |
| `allowed-tools` | string | inherits | Skill needs specific tools without permission prompts |
| `model` | string | inherits | Skill requires specific model (`sonnet`, `opus`, `haiku`) |
| `context` | string | none | Set to `fork` to run in subagent context |
| `agent` | string | `general-purpose` | Subagent type when `context: fork` |
| `hooks` | object | none | Hooks scoped to skill lifecycle |

**Minimal example:**
```yaml
---
name: my-skill
description: Brief one-sentence description of when to use this skill.
---
```

**Example with common fields:**
```yaml
---
name: deploy
description: Deploy the application to production environment.
argument-hint: [environment]
disable-model-invocation: true
context: fork
---
```

---

## SKILL.md Content Requirements (MANDATORY)

**MUST:**
- Keep SKILL.md under 500 lines total
- Use AI-targeted language (write instructions directly to Claude using "you")
- Reference supporting files with descriptions so Claude knows when to load them
- Include clear workflow or step-by-step instructions
- Specify expected output or outcome

**MUST NOT:**
- Include all detailed reference material in SKILL.md (move to supporting files)
- Write in third person about what "the skill does" or what "Claude should do"
- Reference supporting files without explaining what they contain
- Create monolithic SKILL.md files exceeding 500 lines

**Rationale:**
Progressive disclosure pattern: Claude loads SKILL.md when skill is invoked, then uses Read tool to load specific supporting files only when needed. This prevents context flooding and enables skills to bundle extensive reference material efficiently.

**Example SKILL.md structure:**
```markdown
---
name: example-skill
description: Demonstrates proper skill structure and content.
---

# Example Skill

Execute the workflow in sequential phases.

## Workflow Overview

1. Phase 1: [Initial setup](references/phase-1.md)
2. Phase 2: [Processing](references/phase-2.md)
3. Phase 3: [Validation](references/phase-3.md)

## Important Notes

**MUST:**
- Complete each phase before proceeding to next
- Validate output at each phase boundary

**MUST NOT:**
- Skip validation steps
- Proceed if validation fails

## Output

Produces validated result file matching [template](assets/template.json).
```

---

## Supporting Files Requirements (MANDATORY)

**MUST:**
- Create supporting files as plain markdown (`.md`), scripts (`.py`, `.sh`, `.js`), or data files
- Reference supporting files from SKILL.md with description of contents
- Organize by purpose: `references/` for docs, `scripts/` for executables, `assets/` for static resources, `examples/` for samples
- Use lowercase with hyphens for supporting file names (e.g., `phase-1.md`, not `Phase_1.md`)

**MUST NOT:**
- Add YAML frontmatter to supporting files (frontmatter only required in SKILL.md)
- Reference supporting files without explaining when Claude should load them
- Create deeply nested directory structures (keep reference chains one level deep)
- Bundle content that could be loaded from external sources at execution time

**Rationale:**
Supporting files don't require frontmatter because they are loaded on-demand via Read tool during skill execution, not discovered and indexed like SKILL.md. Only SKILL.md needs metadata for Claude Code's skill discovery system.

**Progressive disclosure pattern:**

From SKILL.md:
```markdown
## Phase 1: Setup

See [setup instructions](references/setup.md) for detailed configuration steps.
```

Claude reads this description, then loads `references/setup.md` when executing Phase 1.

**Supporting file types:**

- **`references/*.md`** - Detailed documentation loaded when needed
- **`examples/*.md`** - Usage examples or sample outputs
- **`scripts/*.*`** - Executable utilities (any language)
- **`assets/*.*`** - Templates, schemas, configuration files

**Example reference file** (`references/phase-1.md`):
```markdown
# Phase 1: Setup

Execute these steps to configure the environment:

1. Verify prerequisites are installed
2. Create configuration directory
3. Initialize configuration file

**Output:** Configuration file at `config/settings.json`
```

---

## String Substitutions and Dynamic Content (MANDATORY)

**MUST use these substitution patterns when skills accept arguments:**

| Pattern | Replaced With | Example |
|---------|---------------|---------|
| `$ARGUMENTS` | All arguments | `/skill arg1 arg2` → `arg1 arg2` |
| `$ARGUMENTS[0]` or `$0` | First argument | `/skill arg1 arg2` → `arg1` |
| `$ARGUMENTS[N]` or `$N` | Nth argument (0-based) | `$ARGUMENTS[1]` → `arg2` |
| `${CLAUDE_SESSION_ID}` | Current session ID | Unique session identifier |

**MUST use dynamic context injection for runtime data:**

- Syntax: `` !`command` ``
- Command executes before skill content sent to Claude
- Output replaces the placeholder
- Use for data that changes each invocation

**MUST NOT:**
- Include `$ARGUMENTS` placeholder if not using it (Claude appends automatically)
- Use dynamic injection for static content (load from files instead)
- Execute commands with side effects in dynamic injection (read-only operations only)

**Example with arguments:**
```markdown
---
name: fix-issue
description: Fix the specified issue in the specified file.
argument-hint: [issue-number] [filename]
---

Fix issue $ARGUMENTS[0] in file $ARGUMENTS[1].

Current git branch: !`git branch --show-current`
Issue details: !`gh issue view $ARGUMENTS[0]`
```

Invoked as `/fix-issue 123 auth.ts` becomes:
```
Fix issue 123 in file auth.ts.

Current git branch: feature-auth
Issue details: [output from gh issue view 123]
```

---

## Invocation Control (MANDATORY)

**MUST set `disable-model-invocation: true` when:**
- Skill should only be invoked manually via `/skill-name`
- Skill performs destructive operations requiring explicit user confirmation
- Skill is part of orchestration workflow (not standalone)

**MUST set `user-invocable: false` when:**
- Skill provides background knowledge (conventions, patterns, style guides)
- Skill should only be invoked by Claude programmatically
- Skill should not appear in `/` menu

**MUST NOT:**
- Rely on `user-invocable: false` to block programmatic invocation (use `disable-model-invocation: true` for that)
- Set both `disable-model-invocation: true` and `user-invocable: false` (contradictory: skill becomes unreachable)

**Invocation control matrix:**

| Frontmatter | User Invokes `/skill` | Claude Auto-Invokes | Description in Context |
|-------------|----------------------|---------------------|----------------------|
| (default) | ✓ | ✓ | Yes (always) |
| `disable-model-invocation: true` | ✓ | ✗ | No |
| `user-invocable: false` | ✗ | ✓ | Yes (always) |

**Example - Manual-only deployment skill:**
```yaml
---
name: deploy
description: Deploy the application to production environment.
disable-model-invocation: true
---
```

**Example - Background knowledge skill:**
```yaml
---
name: api-conventions
description: API design patterns and conventions for this codebase.
user-invocable: false
---
```

---

## Subagent Execution (MANDATORY)

**MUST set `context: fork` when:**
- Skill contains explicit step-by-step instructions (not just guidelines)
- Skill requires isolated context window
- Skill performs deep research or complex multi-step tasks

**MUST specify `agent` field when `context: fork` is set:**
- `Explore` - For codebase research and exploration tasks
- `Plan` - For planning and design tasks
- `general-purpose` - Default for other tasks
- Custom agent name - For project-specific agent types

**MUST NOT:**
- Use `context: fork` for reference content skills (conventions, patterns, guides)
- Omit `agent` field when `context: fork` is set

**Example:**
```yaml
---
name: deep-research
description: Research the specified topic thoroughly across the codebase.
argument-hint: [topic]
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:

1. Find all relevant files using Glob and Grep
2. Read and analyze each file
3. Identify patterns and relationships
4. Summarize findings with citations

**Output:** Comprehensive research report with file citations.
```

---

## Compliance Verification

**Before completing any skill artifact:**

Ask yourself:
- [ ] Is skill directory in `.claude/skills/<skill-name>/` with lowercase hyphenated name?
- [ ] Is main file named exactly `SKILL.md` (uppercase)?
- [ ] Does `SKILL.md` have valid YAML frontmatter with `description` field?
- [ ] Is `description` one sentence explaining when to use the skill?
- [ ] Is SKILL.md under 500 lines (detailed content moved to supporting files)?
- [ ] Are supporting files plain markdown/scripts without frontmatter?
- [ ] Are supporting files referenced from SKILL.md with descriptions?
- [ ] Is skill content written in AI-targeted language (second person "you", imperative mood)?
- [ ] Are invocation control fields (`disable-model-invocation`, `user-invocable`) set correctly?
- [ ] If `context: fork` is used, is `agent` field specified?
- [ ] Do string substitutions use correct syntax (`$ARGUMENTS`, `$N`, `` !`command` ``)?

**If ANY answer is "No":**
- Fix the issue before declaring the skill complete
- These are mandatory standards
