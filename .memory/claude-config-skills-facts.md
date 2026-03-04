# Claude Code Skills - Comprehensive Documentation

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

Research findings on Skills - the primary extension mechanism for Claude Code.

---

## Overview

**What are Skills?**
Skills extend Claude Code's capabilities. A skill is a SKILL.md file containing instructions that Claude uses as part of its toolkit. Claude can use skills automatically when relevant, or you can invoke them directly with `/skill-name`.

**Key characteristics:**
- Follow the [Agent Skills open standard](https://agentskills.io) (works across multiple AI tools)
- Claude Code extends the standard with additional features
- Custom commands have been merged into skills (legacy `.claude/commands/*.md` still supported)

---

## File and Folder Structure

### Directory Structure

````text
.claude/skills/<skill-name>/
├── SKILL.md           # Main instructions (required)
├── template.md        # Template for Claude to fill in (optional)
├── examples/
│   └── sample.md      # Example output showing expected format (optional)
└── scripts/
    └── validate.sh    # Script Claude can execute (optional)
````

### Scope Locations

| Location | Path | Applies To | Priority |
|----------|------|------------|----------|
| **Enterprise** | Managed settings path | All users in organization | 1 (highest) |
| **Personal** | `~/.claude/skills/<skill-name>/SKILL.md` | All your projects | 2 |
| **Project** | `.claude/skills/<skill-name>/SKILL.md` | This project only | 3 |
| **Plugin** | `<plugin>/skills/<skill-name>/SKILL.md` | Where plugin is enabled | 4 (lowest, namespaced) |

**Note:** Skills from `--add-dir` directories are loaded automatically and picked up by live change detection.

### Required vs Optional Files

- **Required:** `SKILL.md` only
- **Optional:** Any additional files (templates, examples, scripts, documentation)
- Reference supporting files from `SKILL.md` so Claude knows when to load them

---

## SKILL.md Structure

### Basic Format

````markdown
---
name: skill-name
description: Brief description of what this skill does and when to use it
---

Your skill instructions in Markdown...
````

### Complete Frontmatter Reference

````yaml
---
name: my-skill                          # Display name (optional, defaults to directory name)
description: What this skill does       # Recommended - Claude uses this for auto-invocation
argument-hint: [issue-number]           # Hint for autocomplete (optional)
disable-model-invocation: true          # Prevent Claude auto-loading (optional, default: false)
user-invocable: true                    # Show in `/` menu (optional, default: true)
allowed-tools: Read, Grep, Glob         # Tools Claude can use without permission (optional)
model: sonnet                           # Model to use: sonnet, opus, haiku (optional)
context: fork                           # Run in subagent (optional)
agent: Explore                          # Subagent type when context: fork (optional)
hooks:                                  # Hooks scoped to skill lifecycle (optional)
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
---
````

### Frontmatter Field Details

| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `name` | No | string | Display name for the skill. If omitted, uses directory name. Lowercase letters, numbers, hyphens only (max 64 chars) |
| `description` | Recommended | string | What the skill does and when to use it. Claude uses this to decide when to apply the skill. If omitted, uses first paragraph of content |
| `argument-hint` | No | string | Hint shown during autocomplete. Example: `[issue-number]` or `[filename] [format]` |
| `disable-model-invocation` | No | boolean | Set to `true` to prevent Claude from automatically loading this skill. Use for workflows you trigger manually. Default: `false` |
| `user-invocable` | No | boolean | Set to `false` to hide from `/` menu. Use for background knowledge users shouldn't invoke directly. Default: `true` |
| `allowed-tools` | No | string | Tools Claude can use without permission when skill is active |
| `model` | No | string | Model to use: `sonnet`, `opus`, or `haiku` |
| `context` | No | string | Set to `fork` to run in forked subagent context |
| `agent` | No | string | Which subagent type to use when `context: fork` is set. Options: `Explore`, `Plan`, `general-purpose`, or custom agent name |
| `hooks` | No | object | Hooks scoped to this skill's lifecycle. See [Hooks reference](https://code.claude.com/docs/en/hooks) |

---

## String Substitutions

Skills support dynamic value substitution in the content:

| Variable | Description | Example Usage |
|----------|-------------|---------------|
| `$ARGUMENTS` | All arguments passed to the skill | `Fix issue $ARGUMENTS` |
| `$ARGUMENTS[N]` | Specific argument by 0-based index | `Migrate $ARGUMENTS[0] from $ARGUMENTS[1] to $ARGUMENTS[2]` |
| `$N` | Shorthand for `$ARGUMENTS[N]` | `Migrate $0 from $1 to $2` |
| `${CLAUDE_SESSION_ID}` | Current session ID | `Log to logs/${CLAUDE_SESSION_ID}.log` |

**Behavior:** If `$ARGUMENTS` is not present in content and arguments are passed, they are automatically appended as `ARGUMENTS: <value>`.

---

## Invocation Control

### Who Can Invoke

| Configuration | You Can Invoke | Claude Can Invoke | When Loaded |
|---------------|----------------|-------------------|-------------|
| (default) | Yes | Yes | Description always in context, full skill loads when invoked |
| `disable-model-invocation: true` | Yes | No | Description NOT in context, full skill loads when you invoke |
| `user-invocable: false` | No | Yes | Description always in context, full skill loads when invoked |

### Context Loading

- **Regular sessions:** Skill descriptions loaded into context, full content only when invoked
- **Subagents with preloaded skills:** Full skill content injected at startup (see subagents doc)

---

## Skill Types and Patterns

### Reference Skills

Add knowledge Claude applies during your current work (conventions, patterns, style guides).

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

### Task Skills

Step-by-step instructions for specific actions (deployments, commits, code generation).

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

## Advanced Features

### Dynamic Context Injection

Use `` !`command` `` syntax to run shell commands before skill content is sent to Claude. The output replaces the placeholder.

````markdown
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## Pull request context
- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
- Changed files: !`gh pr diff --name-only`

## Your task
Summarize this pull request...
````

**Important:** This is preprocessing. Commands execute immediately before Claude sees anything. Claude receives only the final result.

### Run in Subagent

Add `context: fork` to run skill in isolation with its own context window.

````markdown
---
name: deep-research
description: Research a topic thoroughly
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:

1. Find relevant files using Glob and Grep
2. Read and analyze the code
3. Summarize findings with specific file references
````

**When to use:** For skills with explicit tasks, not just guidelines. The subagent receives skill content as its prompt.

### Extended Thinking

To enable extended thinking (thinking mode), include the word "ultrathink" anywhere in your skill content.

---

## Bundled Skills

Claude Code includes these bundled skills:

| Skill | Invocation | Purpose |
|-------|------------|---------|
| **simplify** | `/simplify [focus]` | Reviews changed code for reuse, quality, and efficiency. Spawns 3 parallel review agents, aggregates findings, applies fixes |
| **batch** | `/batch <instruction>` | Orchestrates large-scale changes in parallel. Researches codebase, creates plan, spawns background agents in git worktrees, opens PRs |
| **debug** | `/debug [description]` | Troubleshoots session by reading debug log. Optionally describe the issue |

---

## Permission and Access Control

### Restricting Claude's Access to Skills

Three methods:

1. **Disable all skills:** Deny the Skill tool in `/permissions`
   ````text
   # Add to deny rules:
   Skill
   ````

2. **Allow/deny specific skills:** Use permission rules
   ````text
   # Allow only specific skills
   Skill(commit)
   Skill(review-pr *)

   # Deny specific skills
   Skill(deploy *)
   ````

3. **Hide individual skills:** Add `disable-model-invocation: true` to frontmatter

**Note:** `user-invocable` only controls menu visibility, not Skill tool access. Use `disable-model-invocation: true` to block programmatic invocation.

---

## Complete Examples

### Example 1: Simple Reference Skill

````markdown
---
name: code-style
description: Code style guidelines for this project
---

# Code Style Guidelines

## Formatting
- Use 2-space indentation
- Maximum line length: 100 characters
- Add trailing commas in multi-line structures

## Naming
- Use camelCase for variables and functions
- Use PascalCase for classes and components
- Use UPPER_SNAKE_CASE for constants

## Imports
- Group imports: external, internal, relative
- Sort alphabetically within groups
````

### Example 2: Task Skill with Arguments

````markdown
---
name: fix-issue
description: Fix a GitHub issue by number
disable-model-invocation: true
argument-hint: [issue-number]
---

Fix GitHub issue $ARGUMENTS following our coding standards.

1. Read the issue description with `gh issue view $ARGUMENTS`
2. Understand the requirements
3. Implement the fix
4. Write tests
5. Create a commit referencing the issue
````

### Example 3: Skill with Tool Restrictions

````markdown
---
name: safe-reader
description: Read and analyze files without making changes
allowed-tools: Read, Grep, Glob
---

Analyze the codebase to answer the user's question.

You have read-only access:
- Use Read to examine files
- Use Grep to search for patterns
- Use Glob to find files
- DO NOT use Write or Edit tools
````

### Example 4: Skill with Subagent Execution

````markdown
---
name: architecture-review
description: Review project architecture and suggest improvements
context: fork
agent: Explore
model: sonnet
---

Conduct a comprehensive architecture review:

1. **Scan the codebase structure**
   - Identify main directories and their purposes
   - Note organizational patterns

2. **Analyze dependencies**
   - Review package.json / requirements.txt
   - Check for outdated or risky dependencies

3. **Evaluate patterns**
   - Assess consistency of code organization
   - Identify anti-patterns

4. **Provide recommendations**
   - List improvements with specific examples
   - Prioritize by impact
````

### Example 5: Skill with Dynamic Context

````markdown
---
name: test-coverage
description: Analyze test coverage and suggest improvements
allowed-tools: Bash
---

## Current Coverage

Test coverage report:
!`npm run test:coverage -- --silent`

## Analysis

Based on the coverage report above, identify:
1. Files with low coverage (<80%)
2. Uncovered critical paths
3. Suggested test additions
````

### Example 6: Skill with Supporting Files

Directory structure:
````text
.claude/skills/api-generator/
├── SKILL.md
├── template-endpoint.ts
├── template-test.ts
└── examples/
    └── user-endpoint-example.ts
````

SKILL.md content:
````markdown
---
name: api-generator
description: Generate new API endpoints following project conventions
---

Generate a new API endpoint following our project conventions.

## Templates

Refer to these templates:
- Endpoint structure: [template-endpoint.ts](template-endpoint.ts)
- Test structure: [template-test.ts](template-test.ts)

## Example

See [examples/user-endpoint-example.ts](examples/user-endpoint-example.ts) for a complete example.

## Steps

1. Ask user for endpoint name and HTTP method
2. Generate endpoint file using template
3. Generate test file using template
4. Add route to main router
````

---

## Use Cases

### When to Use Skills

- **Repeatable workflows:** Procedures you execute regularly (commits, deployments, reviews)
- **Project conventions:** Standards that apply across your codebase
- **Domain knowledge:** Context Claude needs for specific types of work
- **Task automation:** Multi-step processes that can be templated
- **Code generation:** Patterns you want consistently applied

### When NOT to Use Skills

- **One-time instructions:** Just tell Claude directly in conversation
- **Highly variable tasks:** Where the process differs significantly each time
- **Context that changes frequently:** Better as conversation than persistent skill
- **Simple tool usage:** If it's just "run X command," no skill needed

---

## Troubleshooting

### Skill Not Triggering

If Claude doesn't use your skill when expected:

1. Check description includes keywords users would naturally say
2. Verify skill appears in `What skills are available?`
3. Try rephrasing to match description more closely
4. Invoke directly with `/skill-name` if user-invocable

### Skill Triggers Too Often

If Claude uses your skill when you don't want it:

1. Make description more specific
2. Add `disable-model-invocation: true` for manual-only invocation

### Claude Doesn't See All Skills

- Skill descriptions are loaded into context (up to character budget)
- Budget scales at 2% of context window, fallback 16,000 chars
- Run `/context` to check for excluded skills warning
- Override limit: set `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable

---

## Distribution

Skills can be distributed at different scopes:

- **Project skills:** Commit `.claude/skills/` to version control
- **Plugins:** Create `skills/` directory in your [plugin](https://code.claude.com/docs/en/plugins)
- **Managed:** Deploy organization-wide through [managed settings](https://code.claude.com/docs/en/settings#settings-files)

---

## Related Features

- **Subagents:** Delegate tasks to specialized agents
- **Plugins:** Package and distribute skills with other extensions
- **Hooks:** Automate workflows around tool events
- **Memory:** Manage CLAUDE.md files for persistent context
- **Permissions:** Control tool and skill access

---

## Sources

- [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)
- [Agent Skills Open Standard](https://agentskills.io)
