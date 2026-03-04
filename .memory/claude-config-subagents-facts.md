# Claude Code Subagents - Comprehensive Documentation

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

Research findings on Subagents - specialized AI assistants for task-specific workflows.

---

## Overview

**What are Subagents?**
Subagents are specialized AI assistants that handle specific types of tasks. Each subagent runs in its own context window with a custom system prompt, specific tool access, and independent permissions.

**Key characteristics:**
- Independent context window (separate from main conversation)
- Custom system prompt (different from Claude Code's default)
- Specific tool access and restrictions
- Independent permissions
- Can run in foreground (blocking) or background (concurrent)
- Cannot spawn other subagents

**Use cases:**
- Preserve context by isolating exploration/implementation
- Enforce constraints by limiting tools
- Reuse configurations across projects
- Specialize behavior with focused system prompts
- Control costs by routing tasks to faster, cheaper models

---

## Built-in Subagents

Claude Code includes several built-in subagents:

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| **Explore** | Haiku | Read-only (denied Write/Edit) | Fast codebase exploration, file discovery, code search |
| **Plan** | Inherits | Read-only (denied Write/Edit) | Codebase research during plan mode |
| **general-purpose** | Inherits | All tools | Complex research, multi-step operations, code modifications |
| **Bash** | Inherits | (varies) | Running terminal commands in separate context |
| **statusline-setup** | Sonnet | (varies) | Configuring status line via `/statusline` |
| **Claude Code Guide** | Haiku | (varies) | Answering questions about Claude Code features |

**Explore thoroughness levels:** When Claude invokes Explore, it specifies thoroughness:
- **quick:** Targeted lookups
- **medium:** Balanced exploration
- **very thorough:** Comprehensive analysis

---

## File and Folder Structure

### File Format

Subagent files are Markdown with YAML frontmatter:

````markdown
---
name: agent-name
description: When to delegate to this subagent
tools: Read, Glob, Grep
model: sonnet
---

System prompt content in Markdown...
````

### Scope Locations

| Location | Path | Scope | Priority |
|----------|------|-------|----------|
| **CLI** | `--agents` flag (JSON) | Current session only | 1 (highest) |
| **Project** | `.claude/agents/<name>.agent.md` | This project only | 2 |
| **Personal** | `~/.claude/agents/<name>.agent.md` | All your projects | 3 |
| **Plugin** | `<plugin>/agents/<name>.agent.md` | Where plugin is enabled | 4 (lowest) |

**Priority resolution:** When multiple subagents share the same name, higher-priority location wins.

---

## Complete Frontmatter Reference

````yaml
---
name: code-reviewer                     # Unique identifier (required)
description: Reviews code for quality   # When to delegate (required)
tools: Read, Glob, Grep                 # Tools available (optional, inherits all if omitted)
disallowedTools: Write, Edit            # Tools to deny (optional)
model: sonnet                           # Model: sonnet, opus, haiku, inherit (optional, default: inherit)
permissionMode: default                 # Permission behavior (optional)
maxTurns: 50                            # Maximum agentic turns (optional)
skills:                                 # Skills to preload (optional)
  - api-conventions
  - error-handling
mcpServers:                             # MCP servers available (optional)
  - slack
  - github
hooks:                                  # Lifecycle hooks (optional)
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
memory: user                            # Persistent memory: user, project, local (optional)
background: false                       # Always run as background task (optional, default: false)
isolation: worktree                     # Run in git worktree (optional)
---
````

### Frontmatter Field Details

| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `name` | Yes | string | Unique identifier using lowercase letters and hyphens only |
| `description` | Yes | string | When Claude should delegate to this subagent. Used for automatic delegation decisions |
| `tools` | No | array | Tools the subagent can use. Inherits all tools if omitted. Can specify `Agent(agent_type)` to restrict which subagents can be spawned |
| `disallowedTools` | No | array | Tools to deny, removed from inherited or specified list |
| `model` | No | string | Model to use: `sonnet`, `opus`, `haiku`, or `inherit` (default) |
| `permissionMode` | No | string | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, or `plan` |
| `maxTurns` | No | number | Maximum number of agentic turns before the subagent stops |
| `skills` | No | array | Skills to load into the subagent's context at startup (full content injected) |
| `mcpServers` | No | array/object | MCP servers available. Can be server names or inline definitions |
| `hooks` | No | object | Lifecycle hooks scoped to this subagent. See [Hooks reference](https://code.claude.com/docs/en/hooks) |
| `memory` | No | string | Persistent memory scope: `user`, `project`, or `local`. Enables cross-session learning |
| `background` | No | boolean | Set to `true` to always run this subagent as a background task. Default: `false` |
| `isolation` | No | string | Set to `worktree` to run in a temporary git worktree with isolated repository copy |

---

## Permission Modes

Control how the subagent handles permission prompts:

| Mode | Behavior |
|------|----------|
| `default` | Standard permission checking with prompts |
| `acceptEdits` | Auto-accept file edits |
| `dontAsk` | Auto-deny permission prompts (explicitly allowed tools still work) |
| `bypassPermissions` | Skip all permission checks (**use with caution**) |
| `plan` | Plan mode (read-only exploration) |

**Important:** If parent uses `bypassPermissions`, this takes precedence and cannot be overridden.

---

## Tool Access Control

### Basic Tool Restriction

````yaml
---
name: safe-researcher
description: Research agent with restricted capabilities
tools: Read, Grep, Glob, Bash
disallowedTools: Write, Edit
---
````

### Restricting Subagent Spawning

When an agent runs as the main thread with `claude --agent`, restrict which subagents it can spawn:

````yaml
---
name: coordinator
description: Coordinates work across specialized agents
tools: Agent(worker, researcher), Read, Bash
---
````

**Allowlist behavior:** Only `worker` and `researcher` subagents can be spawned. Others fail.

**Allow all:** Use `Agent` without parentheses to allow spawning any subagent.

**Block all:** Omit `Agent` from tools list to prevent spawning any subagents.

**Note:** This only applies to agents running as main thread. Subagents cannot spawn other subagents regardless of configuration.

---

## Persistent Memory

Enable the `memory` field to give subagents a persistent directory that survives across conversations:

````yaml
---
name: code-reviewer
description: Reviews code for quality and best practices
memory: user
---

You are a code reviewer. As you review code, update your agent memory with
patterns, conventions, and recurring issues you discover.
````

### Memory Scopes

| Scope | Location | Use When |
|-------|----------|----------|
| `user` | `~/.claude/agent-memory/<name-of-agent>/` | Subagent should remember learnings across all projects |
| `project` | `.claude/agent-memory/<name-of-agent>/` | Knowledge is project-specific and shareable via version control |
| `local` | `.claude/agent-memory-local/<name-of-agent>/` | Knowledge is project-specific but should not be in version control |

### Memory Behavior

When memory is enabled:
- System prompt includes instructions for reading/writing to memory directory
- First 200 lines of `MEMORY.md` included in system prompt
- Read, Write, and Edit tools automatically enabled for memory management
- Subagent can curate `MEMORY.md` if it exceeds 200 lines

### Memory Tips

- **Default to `user` scope** for general knowledge
- **Use `project`/`local`** for codebase-specific knowledge
- **Ask subagent to consult memory** before starting work
- **Ask subagent to update memory** after completing tasks
- **Include memory instructions** in subagent's markdown file for proactive maintenance

---

## Hooks in Subagents

### Frontmatter Hooks (Subagent-Scoped)

Define hooks that run only while this subagent is active:

````yaml
---
name: code-reviewer
description: Review code changes with automatic linting
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-command.sh $TOOL_INPUT"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
---
````

**Supported events:** `PreToolUse`, `PostToolUse`, `Stop` (converted to `SubagentStop` at runtime)

### Project-Level Hooks (settings.json)

Configure hooks that respond to subagent lifecycle events:

````json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "db-agent",
        "hooks": [
          { "type": "command", "command": "./scripts/setup-db-connection.sh" }
        ]
      }
    ],
    "SubagentStop": [
      {
        "hooks": [
          { "type": "command", "command": "./scripts/cleanup-db-connection.sh" }
        ]
      }
    ]
  }
}
````

---

## CLI-Defined Subagents (JSON Format)

Pass subagents as JSON via `--agents` flag for session-only use:

````bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer. Focus on code quality, security, and best practices.",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
````

**JSON fields:** Same as file frontmatter, but use `prompt` for system prompt (equivalent to markdown body).

See [CLI reference](https://code.claude.com/docs/en/cli-reference#agents-flag-format) for complete JSON format.

---

## Subagent Execution Modes

### Foreground vs Background

| Mode | Behavior | Permission Handling | Use When |
|------|----------|---------------------|----------|
| **Foreground** | Blocks main conversation | Prompts passed through to user | Need results before proceeding |
| **Background** | Runs concurrently | Pre-approved permissions only; auto-denies others | Have independent work to do in parallel |

**Background behavior:**
- Claude Code prompts for permissions before launching
- Subagent inherits approved permissions
- If subagent needs more permissions, tool call fails but continues
- Can resume failed background tasks in foreground with interactive prompts

**Control:**
- Ask Claude to "run this in the background"
- Press **Ctrl+B** to background a running task
- Set `background: true` in frontmatter to always run as background

**Disable all background tasks:** Set `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` environment variable.

### Isolation with Git Worktrees

Set `isolation: worktree` to run subagent in temporary git worktree:

````yaml
---
name: experimental-refactor
description: Try risky refactorings in isolation
isolation: worktree
---
````

**Behavior:**
- Creates temporary git worktree with new branch based on HEAD
- Gives subagent isolated copy of repository
- Automatically cleaned up if no changes made
- If changes made, returns worktree path and branch

---

## Resuming Subagents

Each subagent invocation creates a new instance with fresh context. To continue existing work:

````text
Use the code-reviewer subagent to review the authentication module
[Agent completes]

Continue that code review and now analyze the authorization logic
[Claude resumes the subagent with full context from previous conversation]
````

**Resume behavior:**
- Subagent retains full conversation history
- Picks up exactly where it stopped
- Can resume after restarting Claude Code (within same session)

**Transcript storage:**
- Location: `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`
- Persists independently of main conversation
- Survives main conversation compaction
- Cleaned up based on `cleanupPeriodDays` setting (default: 30 days)

---

## Auto-Compaction

Subagents support auto-compaction using same logic as main conversation:

- **Default trigger:** ~95% capacity
- **Override:** Set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` (e.g., `50` for 50%)
- **Logging:** Compaction events logged in transcript with token counts

````json
{
  "type": "system",
  "subtype": "compact_boundary",
  "compactMetadata": {
    "trigger": "auto",
    "preTokens": 167189
  }
}
````

---

## Management with /agents Command

The `/agents` command provides interactive interface for:

- **View all available subagents** (built-in, user, project, plugin)
- **Create new subagents** with guided setup or Claude generation
- **Edit existing subagents** (configuration and tool access)
- **Delete custom subagents**
- **See active subagents** when duplicates exist

**CLI listing:** Run `claude agents` to list all configured subagents without starting interactive session.

---

## Complete Examples

### Example 1: Read-Only Code Reviewer

````markdown
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
tools: Read, Grep, Glob, Bash
model: inherit
---

You are a senior code reviewer ensuring high standards of code quality and security.

When invoked:
1. Run git diff to see recent changes
2. Focus on modified files
3. Begin review immediately

Review checklist:
- Code is clear and readable
- Functions and variables are well-named
- No duplicated code
- Proper error handling
- No exposed secrets or API keys
- Input validation implemented
- Good test coverage
- Performance considerations addressed

Provide feedback organized by priority:
- Critical issues (must fix)
- Warnings (should fix)
- Suggestions (consider improving)

Include specific examples of how to fix issues.
````

### Example 2: Debugger with Edit Capability

````markdown
---
name: debugger
description: Debugging specialist for errors, test failures, and unexpected behavior. Use proactively when encountering any issues.
tools: Read, Edit, Bash, Grep, Glob
---

You are an expert debugger specializing in root cause analysis.

When invoked:
1. Capture error message and stack trace
2. Identify reproduction steps
3. Isolate the failure location
4. Implement minimal fix
5. Verify solution works

Debugging process:
- Analyze error messages and logs
- Check recent code changes
- Form and test hypotheses
- Add strategic debug logging
- Inspect variable states

For each issue, provide:
- Root cause explanation
- Evidence supporting the diagnosis
- Specific code fix
- Testing approach
- Prevention recommendations

Focus on fixing the underlying issue, not the symptoms.
````

### Example 3: Domain-Specific (Data Science)

````markdown
---
name: data-scientist
description: Data analysis expert for SQL queries, BigQuery operations, and data insights. Use proactively for data analysis tasks and queries.
tools: Bash, Read, Write
model: sonnet
---

You are a data scientist specializing in SQL and BigQuery analysis.

When invoked:
1. Understand the data analysis requirement
2. Write efficient SQL queries
3. Use BigQuery command line tools (bq) when appropriate
4. Analyze and summarize results
5. Present findings clearly

Key practices:
- Write optimized SQL queries with proper filters
- Use appropriate aggregations and joins
- Include comments explaining complex logic
- Format results for readability
- Provide data-driven recommendations

For each analysis:
- Explain the query approach
- Document any assumptions
- Highlight key findings
- Suggest next steps based on data

Always ensure queries are efficient and cost-effective.
````

### Example 4: Database Reader with Hook Validation

````markdown
---
name: db-reader
description: Execute read-only database queries. Use when analyzing data or generating reports.
tools: Bash
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-readonly-query.sh"
---

You are a database analyst with read-only access. Execute SELECT queries to answer questions about the data.

When asked to analyze data:
1. Identify which tables contain the relevant data
2. Write efficient SELECT queries with appropriate filters
3. Present results clearly with context

You cannot modify data. If asked to INSERT, UPDATE, DELETE, or modify schema, explain that you only have read access.
````

**Validation script** (./scripts/validate-readonly-query.sh):

````bash
#!/bin/bash
# Blocks SQL write operations, allows SELECT queries

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Block write operations (case-insensitive)
if echo "$COMMAND" | grep -iE '\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|REPLACE|MERGE)\b' > /dev/null; then
  echo "Blocked: Write operations not allowed. Use SELECT queries only." >&2
  exit 2
fi

exit 0
````

Make executable: `chmod +x ./scripts/validate-readonly-query.sh`

### Example 5: Subagent with Persistent Memory

````markdown
---
name: architecture-advisor
description: Provides architectural guidance based on accumulated project knowledge
memory: project
tools: Read, Grep, Glob
model: sonnet
---

You are an architecture advisor with persistent memory of this project's decisions, patterns, and evolution.

Before providing guidance:
1. Consult your memory for relevant architectural decisions
2. Review existing patterns in the codebase
3. Consider historical context from previous advice

When providing architectural advice:
1. Reference past decisions and their rationale
2. Ensure consistency with existing patterns
3. Note any tradeoffs explicitly
4. Update your memory with new decisions

After each session:
- Record new architectural decisions
- Document patterns discovered
- Note lessons learned
- Update your understanding of the codebase evolution
````

### Example 6: Background Research Agent

````markdown
---
name: background-researcher
description: Research topics thoroughly in the background while you continue working
background: true
tools: Read, Grep, Glob, Bash
model: haiku
---

You are a research agent that runs in the background to gather information.

When given a research task:
1. Identify all relevant files and documentation
2. Extract key information systematically
3. Organize findings by category
4. Summarize with actionable insights

Provide:
- Summary of key findings
- Specific file references with line numbers
- Recommendations based on research
- Areas requiring further investigation

Work efficiently to minimize cost since you run in background.
````

---

## Use Cases and Patterns

### When to Use Subagents

| Situation | Why Subagent | Recommendation |
|-----------|--------------|----------------|
| **High-volume operations** | Isolate verbose output | Use Explore or custom read-only agent |
| **Parallel research** | Independent investigations | Spawn multiple foreground agents |
| **Enforce constraints** | Limit tools strictly | Use `tools` and `disallowedTools` |
| **Cost control** | Use cheaper models | Set `model: haiku` |
| **Persistent learning** | Build knowledge over time | Enable `memory` |
| **Risky operations** | Isolate from main repo | Use `isolation: worktree` |

### When to Use Main Conversation

- Frequent back-and-forth or iterative refinement needed
- Multiple phases share significant context
- Quick, targeted changes
- Latency matters (subagents start fresh)

### When to Use Skills Instead

- Want reusable prompts that run in main context
- Don't need isolation
- Want Claude to auto-invoke based on relevance

---

## Disabling Specific Subagents

Add to `deny` array in settings.json:

````json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
````

Or use CLI flag:

````bash
claude --disallowedTools "Agent(Explore)"
````

---

## Sources

- [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Hooks reference](https://code.claude.com/docs/en/hooks)
- [CLI reference](https://code.claude.com/docs/en/cli-reference)
