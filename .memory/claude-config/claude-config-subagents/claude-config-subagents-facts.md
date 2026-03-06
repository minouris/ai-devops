# Claude Config Facts: Subagents Subtopic

Detailed research findings on Subagents as specialized AI assistants in Claude Code.

**Source:** [https://code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)

---

## FINDING-2026-03-04-25: Subagents File Structure and Locations

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** configuration, file, priority, scope, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Subagents are defined in Markdown files with YAML frontmatter. File location determines scope and priority.

**File format:**
- Markdown with YAML frontmatter + body as system prompt
- Extension: `.agent.md` (by convention, not required)
- Body becomes the subagent's system prompt (not Claude Code's default)

**Scope locations and priority:**

| Location | Path | Scope | Priority |
|----------|------|-------|----------|
| CLI | `--agents` flag (JSON) | Current session only | 1 (highest) |
| Project | `.claude/agents/<name>.agent.md` | This project only | 2 |
| Personal | `~/.claude/agents/<name>.agent.md` | All your projects | 3 |
| Plugin | `<plugin>/agents/<name>.agent.md` | Where plugin enabled | 4 (lowest) |

**Priority resolution:** Higher priority locations override lower when names match.

**Key characteristics:**
- Each subagent runs in own context window
- Cannot spawn other subagents (regardless of configuration)
- Transcripts stored in `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`

---

## FINDING-2026-03-04-26: Subagent Frontmatter Fields Complete Specification

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** configuration, field, frontmatter, specification, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Subagents support comprehensive frontmatter configuration. Only `name` and `description` are required.

**Complete frontmatter fields:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `name` | string | Yes | none | Unique identifier, lowercase with hyphens only |
| `description` | string | Yes | none | When Claude should delegate to this subagent |
| `tools` | array | No | inherits all | Tools the subagent can use. Can include `Agent(agent_type)` to restrict spawning |
| `disallowedTools` | array | No | none | Tools to deny, removed from inherited/specified list |
| `model` | string | No | `inherit` | Model: `sonnet`, `opus`, `haiku`, or `inherit` |
| `permissionMode` | string | No | inherits | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | number | No | none | Maximum agentic turns before stopping |
| `skills` | array | No | none | Skills to preload into subagent context at startup (full content injected) |
| `mcpServers` | array/object | No | none | MCP servers available. Server names or inline definitions |
| `hooks` | object | No | none | Lifecycle hooks scoped to this subagent |
| `memory` | string | No | none | Persistent memory scope: `user`, `project`, or `local` |
| `background` | boolean | No | `false` | Always run as background task |
| `isolation` | string | No | none | Set to `worktree` for git worktree isolation |

**Example with all fields:**
````yaml
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: [Read, Grep, Glob, Bash]
disallowedTools: [Write, Edit]
model: sonnet
permissionMode: default
maxTurns: 50
skills:
  - api-conventions
mcpServers:
  - slack
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./validate.sh"
memory: user
background: false
isolation: worktree
---
````

---

## FINDING-2026-03-04-27: Built-in Subagents

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** built-in, exploration, model, subagent, tool

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Claude Code includes several built-in subagents for common tasks.

**Built-in subagents:**

| Agent | Model | Tools | Purpose | Thoroughness Levels |
|-------|-------|-------|---------|---------------------|
| **Explore** | Haiku | Read-only (denied Write/Edit) | Fast codebase exploration, file discovery, code search | quick, medium, very thorough |
| **Plan** | Inherits | Read-only (denied Write/Edit) | Codebase research during plan mode | N/A |
| **general-purpose** | Inherits | All tools | Complex research, multi-step operations, code modifications | N/A |
| **Bash** | Inherits | (varies) | Running terminal commands in separate context | N/A |
| **statusline-setup** | Sonnet | (varies) | Configuring status line via `/statusline` | N/A |
| **Claude Code Guide** | Haiku | (varies) | Answering questions about Claude Code features | N/A |

**Explore thoroughness:**
When Claude invokes Explore, it specifies thoroughness level:
- **quick:** Targeted lookups
- **medium:** Balanced exploration
- **very thorough:** Comprehensive analysis

---

## FINDING-2026-03-04-28: Subagent Permission Modes

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** mode, permission, security, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Permission modes control how subagents handle permission prompts. Subagents inherit parent's permission context but can override.

**Permission modes:**

| Mode | Behavior |
|------|----------|
| `default` | Standard permission checking with prompts |
| `acceptEdits` | Auto-accept file edits |
| `dontAsk` | Auto-deny permission prompts (explicitly allowed tools still work) |
| `bypassPermissions` | Skip all permission checks (**use with caution**) |
| `plan` | Plan mode (read-only exploration) |

**Important notes:**
- If parent uses `bypassPermissions`, this takes precedence and cannot be overridden
- Subagents inherit permission context from main conversation
- Permission mode only applies to subagent's own operations

---

## FINDING-2026-03-04-29: Subagent Tool Access Control

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** control, security, subagent, tool

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Three methods to control which tools subagents can use and which subagents they can spawn.

**Method 1: Basic tool restriction**
Use `tools` and `disallowedTools` fields:
````yaml
---
name: safe-researcher
tools: [Read, Grep, Glob, Bash]
disallowedTools: [Write, Edit]
---
````

**Method 2: Restrict subagent spawning**
When agent runs as main thread with `claude --agent`, use `Agent(agent_type)` syntax:
````yaml
---
name: coordinator
tools: [Agent(worker, researcher), Read, Bash]
---
````
- **Allowlist:** Only `worker` and `researcher` can be spawned
- **Allow all:** Use `Agent` without parentheses
- **Block all:** Omit `Agent` from tools list

**Important:** This only applies to agents running as main thread. Subagents cannot spawn other subagents regardless of configuration.

**Method 3: Disable specific subagents globally**
In settings.json:
````json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
````

---

## FINDING-2026-03-04-30: Subagent Persistent Memory

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** memory, persistence, scope, storage, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Enable `memory` field to give subagents persistent directory that survives across conversations.

**Memory scopes:**

| Scope | Location | Use When |
|-------|----------|----------|
| `user` | `~/.claude/agent-memory/<name>/` | Subagent should remember across all projects |
| `project` | `.claude/agent-memory/<name>/` | Knowledge is project-specific, shareable via version control |
| `local` | `.claude/agent-memory-local/<name>/` | Knowledge is project-specific, NOT in version control |

**Memory behavior when enabled:**
- System prompt includes instructions for reading/writing to memory directory
- First 200 lines of `MEMORY.md` included in system prompt
- Instructions to curate `MEMORY.md` if exceeds 200 lines
- Read, Write, Edit tools automatically enabled for memory management

**Best practices:**
- Default to `user` scope for general knowledge
- Use `project`/`local` for codebase-specific knowledge
- Ask subagent to consult memory before starting work
- Ask subagent to update memory after completing tasks
- Include memory instructions in subagent markdown for proactive maintenance

---

## FINDING-2026-03-04-31: Subagent Execution Modes

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** background, execution, foreground, mode, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Subagents can run in foreground (blocking) or background (concurrent) with different permission handling.

**Execution modes:**

| Mode | Behavior | Permission Handling | Claude Decides When |
|------|----------|---------------------|---------------------|
| **Foreground** | Blocks main conversation until complete | Prompts passed through to user | Need results before proceeding |
| **Background** | Runs concurrently | Pre-approved permissions only; auto-denies others | Have independent work to do in parallel |

**Background behavior:**
- Claude Code prompts for permissions before launching
- Subagent inherits approved permissions
- If needs more permissions, tool call fails but continues
- Can resume failed background tasks in foreground for interactive prompts
- `AskUserQuestion` tool calls fail in background (no user interaction)

**Control methods:**
- Ask Claude to "run this in the background"
- Press **Ctrl+B** to background a running task
- Set `background: true` in frontmatter to always run as background

**Disable all background tasks:** Set `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` environment variable.

---

## FINDING-2026-03-04-32: Subagent Isolation with Git Worktrees

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** git, isolation, subagent, testing, worktree

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Set `isolation: worktree` to run subagent in temporary git worktree with isolated repository copy.

**Configuration:**
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
- If changes made, returns worktree path and branch name
- Subagent works without affecting main repository

**Use cases:**
- Risky refactorings
- Experimental changes
- Parallel development on different features
- Testing destructive operations

---

## FINDING-2026-03-04-33: Subagent Resumption and Transcripts

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** resumption, session, storage, subagent, transcript

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Each subagent invocation creates new instance. To continue existing work, ask Claude to resume the subagent.

**Resume behavior:**
- Subagent retains full conversation history
- Picks up exactly where it stopped
- Claude receives agent ID when subagent completes
- Can resume after restarting Claude Code (within same session)

**Example:**
````text
Use code-reviewer to review auth module
[Agent completes]

Continue that review and analyze authorization logic
[Claude resumes with full context from previous conversation]
````

**Transcript storage:**
- Location: `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`
- Persists independently of main conversation
- Survives main conversation compaction
- Cleaned up based on `cleanupPeriodDays` setting (default: 30 days)

**Finding agent IDs:**
- Ask Claude for the agent ID
- Check transcript files in `~/.claude/projects/{project}/{sessionId}/subagents/`

---

## FINDING-2026-03-04-34: Subagent Auto-Compaction

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** auto-compaction, context, subagent, transcript

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Subagents support auto-compaction using same logic as main conversation.

**Compaction behavior:**
- Default trigger: ~95% capacity
- Override: Set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` environment variable (e.g., `50` for 50%)
- Compaction events logged in transcript with token counts

**Logging format:**
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

**Key points:**
- Same auto-compaction logic as main conversation
- Transcripts persist independently
- Main conversation compaction doesn't affect subagent transcripts

---

## FINDING-2026-03-04-35: Subagent Management with /agents Command

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** command, interface, management, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
The `/agents` command provides interactive interface for managing subagents without editing files.

**Capabilities:**
- **View:** All available subagents (built-in, user, project, plugin)
- **Create:** New subagents with guided setup or Claude generation
- **Edit:** Existing subagent configuration and tool access
- **Delete:** Custom subagents
- **See active:** Which subagents are active when duplicates exist

**CLI listing:** Run `claude agents` to list all configured subagents without starting interactive session.

**Agent generation:**
- Can generate subagents with Claude's help
- Provide description of what subagent should do
- Claude generates system prompt and configuration
- Can edit before saving

---

## FINDING-2026-03-04-36: CLI-Defined Subagents (JSON Format)

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents), [CLI reference](https://code.claude.com/docs/en/cli-reference#agents-flag-format)

**Keywords:** cli, configuration, json, subagent, temporary

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Pass subagents as JSON via `--agents` flag for session-only use (not saved to disk).

**Format:**
````bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer. Focus on quality, security, best practices.",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
````

**JSON fields:**
- Same as file frontmatter
- Use `prompt` for system prompt (equivalent to markdown body in file)
- Supports: `description`, `prompt`, `tools`, `disallowedTools`, `model`, `permissionMode`, `mcpServers`, `hooks`, `maxTurns`, `skills`, `memory`

**Use cases:**
- Quick testing
- Automation scripts
- Temporary configurations
- CI/CD pipelines

---

## FINDING-2026-03-04-37: Subagent Hooks

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** event, hook, lifecycle, scope, subagent

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/sub-agents]

**What:**
Two ways to configure hooks for subagents: in frontmatter (subagent-scoped) and in settings.json (project-level lifecycle events).

**Method 1: Frontmatter hooks (subagent-scoped)**
Define hooks that run only while this subagent is active:
````yaml
---
name: code-reviewer
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-command.sh"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
---
````

**Supported events:** `PreToolUse`, `PostToolUse`, `Stop` (converted to `SubagentStop` at runtime)

**Method 2: Project-level hooks (settings.json)**
Configure hooks that respond to subagent lifecycle:
````json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "db-agent",
        "hooks": [
          {"type": "command", "command": "./setup-db.sh"}
        ]
      }
    ],
    "SubagentStop": [
      {
        "hooks": [
          {"type": "command", "command": "./cleanup-db.sh"}
        ]
      }
    ]
  }
}
````

**Events:** `SubagentStart` (when begins), `SubagentStop` (when completes)

---

## Notes

All 13 findings verified on 2026-03-05 against official Claude Code documentation (https://code.claude.com/docs/en/sub-agents). All findings accepted without modifications.

Subagents are specialized AI assistants with independent context windows, custom system prompts, and specific tool access.
