# Claude Config Facts: Hooks Subtopic

Detailed research findings on Hooks for event-driven automation in Claude Code.

**Source:** [https://code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)

---

## FINDING-2026-03-04-45: Hooks Overview and Purpose

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Hooks are user-defined shell commands, HTTP endpoints, or LLM prompts that execute automatically at specific points in Claude Code's lifecycle.

**Hook types:**
- **Command hooks** (`type: "command"`): Run shell commands
- **HTTP hooks** (`type: "http"`): Send POST requests to URLs
- **Prompt hooks** (`type: "prompt"`): Use LLM for single-turn evaluation
- **Agent hooks** (`type: "agent"`): Spawn subagent with tool access for verification

**Key use cases:**
- Automation (format code, run linters, send notifications)
- Validation (block dangerous commands, enforce rules)
- Context injection (load environment, fetch data)
- Cleanup (teardown resources, log activity)

**Behavior:**
- Hooks receive JSON context via stdin (command) or POST body (HTTP)
- Exit codes and stdout control whether action proceeds or blocks
- Some events can be blocked, others are informational only

---

## FINDING-2026-03-04-46: Hook Configuration Structure

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Hooks configuration has three levels of nesting: event → matcher group → hook handlers.

**Configuration levels:**
1. **Hook event**: Lifecycle point (e.g., `PreToolUse`, `Stop`)
2. **Matcher group**: Filter when it fires (e.g., "only for Bash tool")
3. **Hook handlers**: One or more handlers (shell command, HTTP endpoint, prompt, agent)

**Example structure:**
````json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/validate.sh"
          }
        ]
      }
    ]
  }
}
````

**Location determines scope:**

| Location | Scope | Shareable |
|----------|-------|-----------|
| `~/.claude/settings.json` | All your projects | No |
| `.claude/settings.json` | Single project | Yes (committed) |
| `.claude/settings.local.json` | Single project | No (gitignored) |
| Managed policy settings | Organization-wide | Yes (admin-controlled) |
| Plugin `hooks/hooks.json` | When plugin enabled | Yes (bundled) |
| Skill/agent frontmatter | While component active | Yes (in component file) |

---

## FINDING-2026-03-04-47: Hook Events Complete List

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
16 hook events fire at different points in Claude Code's lifecycle. Some fire once per session, others repeatedly in the agentic loop.

**Hook events:**

| Event | When it fires | Can block? |
|-------|---------------|------------|
| `SessionStart` | Session begins or resumes | No |
| `UserPromptSubmit` | Before Claude processes user prompt | Yes |
| `PreToolUse` | Before tool call executes | Yes |
| `PermissionRequest` | When permission dialog appears | Yes |
| `PostToolUse` | After tool call succeeds | No |
| `PostToolUseFailure` | After tool call fails | No |
| `Notification` | When notification sent | No |
| `SubagentStart` | When subagent is spawned | No |
| `SubagentStop` | When subagent finishes | Yes |
| `Stop` | When Claude finishes responding | Yes |
| `TeammateIdle` | When agent team teammate about to go idle | Yes |
| `TaskCompleted` | When task being marked complete | Yes |
| `ConfigChange` | When config file changes during session | Yes |
| `WorktreeCreate` | When worktree being created | Yes |
| `WorktreeRemove` | When worktree being removed | No |
| `PreCompact` | Before context compaction | No |
| `SessionEnd` | When session terminates | No |

**Lifecycle ordering:**
Session setup → Agentic loop (UserPromptSubmit → PreToolUse → PostToolUse → Stop) → Session end

---

## FINDING-2026-03-04-48: Hook Matcher Patterns

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
The `matcher` field is a regex string that filters when hooks fire. Different events match on different fields.

**Matcher by event:**

| Events | Matches On | Example Matchers |
|--------|------------|------------------|
| `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest` | tool name | `Bash`, `Edit\|Write`, `mcp__.*` |
| `SessionStart` | how session started | `startup`, `resume`, `clear`, `compact` |
| `SessionEnd` | why session ended | `clear`, `logout`, `prompt_input_exit`, `other` |
| `Notification` | notification type | `permission_prompt`, `idle_prompt`, `auth_success` |
| `SubagentStart`, `SubagentStop` | agent type | `Bash`, `Explore`, `Plan`, custom names |
| `PreCompact` | what triggered compaction | `manual`, `auto` |
| `ConfigChange` | configuration source | `user_settings`, `project_settings`, `policy_settings` |
| `UserPromptSubmit`, `Stop`, `TeammateIdle`, `TaskCompleted`, `WorktreeCreate`, `WorktreeRemove` | no matcher support | always fires |

**Matcher syntax:**
- Omit matcher, use `"*"`, or `""` to match all occurrences
- Regex patterns: `Edit|Write` matches either, `Notebook.*` matches any starting with Notebook
- MCP tools: `mcp__memory__.*` matches all tools from memory server

---

## FINDING-2026-03-04-49: Hook Handler Types and Fields

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Four hook handler types with shared and type-specific fields.

**Common fields (all types):**

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `type` | Yes | none | `"command"`, `"http"`, `"prompt"`, or `"agent"` |
| `timeout` | No | varies | Seconds before canceling (600 command, 30 prompt, 60 agent) |
| `statusMessage` | No | none | Custom spinner message while hook runs |
| `once` | No | `false` | Run only once per session then remove (skills only, not agents) |

**Command hook fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `command` | Yes | Shell command to execute |
| `async` | No | Run in background without blocking |

**HTTP hook fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `url` | Yes | URL to send POST request to |
| `headers` | No | HTTP headers (key-value pairs) |
| `allowedEnvVars` | No | Environment variables allowed in header interpolation |

**Prompt/agent hook fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `prompt` | Yes | Prompt text, use `$ARGUMENTS` for hook input JSON |
| `model` | No | Model to use (defaults to fast model) |

---

## FINDING-2026-03-04-50: Hook Input and Output (Command Hooks)

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Command hooks receive JSON via stdin and communicate results through exit codes, stdout, and stderr.

**Common input fields (all events):**

| Field | Description |
|-------|-------------|
| `session_id` | Current session identifier |
| `transcript_path` | Path to conversation JSON |
| `cwd` | Current working directory |
| `permission_mode` | Current permission mode (`default`, `plan`, etc.) |
| `hook_event_name` | Name of event that fired |

**Exit code meanings:**

| Exit Code | Meaning | Behavior |
|-----------|---------|----------|
| 0 | Success | Parse stdout for JSON, continue execution |
| 2 | Blocking error | Feed stderr to Claude as error, block action (varies by event) |
| Other | Non-blocking error | Show stderr in verbose mode, continue execution |

**Exit code 2 behavior by event:**

| Event | Can Block? | What Happens on Exit 2 |
|-------|------------|------------------------|
| `PreToolUse` | Yes | Blocks tool call |
| `PermissionRequest` | Yes | Denies permission |
| `UserPromptSubmit` | Yes | Blocks prompt processing, erases prompt |
| `Stop` | Yes | Prevents Claude from stopping, continues conversation |
| `SubagentStop` | Yes | Prevents subagent from stopping |
| `TeammateIdle` | Yes | Prevents teammate from going idle |
| `TaskCompleted` | Yes | Prevents task from being marked complete |
| `ConfigChange` | Yes | Blocks config change (except policy_settings) |
| `PostToolUse`, `PostToolUseFailure` | No | Shows stderr to Claude (tool already ran) |
| `Notification`, `SubagentStart`, `SessionStart`, `SessionEnd`, `PreCompact` | No | Shows stderr to user only |
| `WorktreeCreate` | Yes | Any non-zero exit fails creation |
| `WorktreeRemove` | No | Failures logged in debug mode only |

---

## FINDING-2026-03-04-51: Hook JSON Output and Decision Control

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Exit code 0 allows JSON output for structured control. JSON provides finer-grained control than exit codes alone.

**Universal JSON fields (all events):**

| Field | Default | Description |
|-------|---------|-------------|
| `continue` | `true` | If `false`, Claude stops entirely after hook runs |
| `stopReason` | none | Message shown when `continue` is `false` |
| `suppressOutput` | `false` | If `true`, hides stdout from verbose mode |
| `systemMessage` | none | Warning message shown to user |

**Decision control patterns by event:**

| Events | Decision Pattern | Key Fields |
|--------|------------------|------------|
| `UserPromptSubmit`, `PostToolUse`, `PostToolUseFailure`, `Stop`, `SubagentStop`, `ConfigChange` | Top-level `decision` | `decision: "block"`, `reason` |
| `TeammateIdle`, `TaskCompleted` | Exit code only | Exit 2 blocks, stderr is feedback |
| `PreToolUse` | `hookSpecificOutput` | `permissionDecision` (allow/deny/ask), `permissionDecisionReason` |
| `PermissionRequest` | `hookSpecificOutput` | `decision.behavior` (allow/deny) |
| `WorktreeCreate` | stdout path | Print absolute path to created worktree |
| `WorktreeRemove`, `Notification`, `SessionEnd`, `PreCompact` | None | Side effects only (logging, cleanup) |

**Example - Top-level decision:**
````json
{
  "decision": "block",
  "reason": "Test suite must pass before proceeding"
}
````

**Example - PreToolUse hookSpecificOutput:**
````json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Database writes not allowed"
  }
}
````

---

## FINDING-2026-03-04-52: HTTP Hooks Behavior

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
HTTP hooks send hook input as POST request body and use response codes/body for decisions.

**Configuration:**
````json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "http",
            "url": "http://localhost:8080/hooks/pre-tool-use",
            "timeout": 30,
            "headers": {
              "Authorization": "Bearer $MY_TOKEN"
            },
            "allowedEnvVars": ["MY_TOKEN"]
          }
        ]
      }
    ]
  }
}
````

**HTTP response handling:**

| Response | Behavior |
|----------|----------|
| 2xx with empty body | Success (equivalent to exit 0 with no output) |
| 2xx with plain text | Success, text added as context |
| 2xx with JSON body | Success, parsed using same schema as command hooks |
| Non-2xx status | Non-blocking error, execution continues |
| Connection failure/timeout | Non-blocking error, execution continues |

**Key differences from command hooks:**
- Cannot signal blocking error through status code alone
- To block: Return 2xx with JSON containing decision fields
- Non-2xx responses are non-blocking (command hooks use exit 2 to block)

---

## FINDING-2026-03-04-53: Prompt-Based Hooks

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Prompt hooks (`type: "prompt"`) use LLM for single-turn evaluation instead of running shell commands.

**How they work:**
1. Send hook input and prompt to Claude model (Haiku by default)
2. LLM responds with structured JSON decision
3. Claude Code processes decision automatically

**Configuration:**
````json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evaluate if Claude should stop: $ARGUMENTS. Check if all tasks complete.",
            "timeout": 30,
            "model": "haiku"
          }
        ]
      }
    ]
  }
}
````

**Response schema (LLM must return):**
````json
{
  "ok": true,  // or false
  "reason": "Explanation when ok is false"
}
````

**Events supporting prompt hooks:**
- `PermissionRequest`, `PostToolUse`, `PostToolUseFailure`, `PreToolUse`
- `Stop`, `SubagentStop`, `TaskCompleted`, `UserPromptSubmit`

**Events supporting only command hooks:**
- `ConfigChange`, `Notification`, `PreCompact`, `SessionEnd`
- `SessionStart`, `SubagentStart`, `TeammateIdle`, `WorktreeCreate`, `WorktreeRemove`

---

## FINDING-2026-03-04-54: Agent-Based Hooks

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Agent hooks (`type: "agent"`) spawn subagent with tool access for multi-turn verification, unlike prompt hooks which are single-turn.

**How they work:**
1. Claude Code spawns subagent with prompt and hook input JSON
2. Subagent can use tools (Read, Grep, Glob) to investigate
3. After up to 50 turns, subagent returns `{ "ok": true/false }` decision
4. Claude Code processes decision same as prompt hook

**Configuration:**
````json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "agent",
            "prompt": "Verify all unit tests pass before allowing Claude to finish. Run tests and check results. Return {\"ok\": true} if all pass, {\"ok\": false, \"reason\": \"...\"} if any fail.",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
````

**When to use:**
- Verification requires inspecting actual files or test output
- Need to read code, search patterns, run commands
- Condition cannot be evaluated from hook input JSON alone

**Response schema:** Same as prompt hooks (`{ "ok": true/false, "reason": "..." }`)

**Events supporting agent hooks:** Same as prompt hooks

---

## FINDING-2026-03-04-55: PreToolUse Hook - Most Powerful Event

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
PreToolUse is the most capable hook event, supporting rich decision control including permission decisions, tool input modification, and context injection.

**hookSpecificOutput fields:**

| Field | Description |
|-------|-------------|
| `hookEventName` | Must be `"PreToolUse"` |
| `permissionDecision` | `"allow"`, `"deny"`, or `"ask"` |
| `permissionDecisionReason` | Explanation shown when denying |
| `updatedInput` | Modified tool input (replaces original) |
| `additionalContext` | Context injected for Claude to see |

**Example - Deny with reason:**
````json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Database writes are not allowed"
  }
}
````

**Example - Modify input:**
````json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "updatedInput": {
      "command": "npm run lint:fix"
    }
  }
}
````

**Example - Inject context:**
````json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "additionalContext": "Note: This command will affect production database"
  }
}
````

**Tool input schemas:** Different for each tool (Bash, Write, Edit, Read, Glob, Grep, etc.)

---

## FINDING-2026-03-04-56: SessionStart Hook for Environment Setup

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
SessionStart is special event for loading context and setting up environment at session start. Has access to `CLAUDE_ENV_FILE` for persisting environment variables.

**Matcher values:**
- `startup`: New session
- `resume`: Resumed session (`--resume`, `--continue`, `/resume`)
- `clear`: After `/clear`
- `compact`: After compaction

**CLAUDE_ENV_FILE usage:**
````bash
#!/bin/bash
# SessionStart hook

if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=production' >> "$CLAUDE_ENV_FILE"
  echo 'export DEBUG_LOG=true' >> "$CLAUDE_ENV_FILE"
  echo 'export PATH="$PATH:./node_modules/.bin"' >> "$CLAUDE_ENV_FILE"
fi

exit 0
````

**Behaviors:**
- Any text to stdout added as context for Claude
- `additionalContext` JSON field also supported
- Variables in `CLAUDE_ENV_FILE` available in all subsequent Bash commands
- Only SessionStart hooks have access to `CLAUDE_ENV_FILE`

---

## FINDING-2026-03-04-57: Hooks in Skills and Agents

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Hooks can be defined in skill/agent frontmatter, scoped to that component's lifecycle.

**Skill hook example:**
````yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh"
---
````

**Subagent hook example:**
````yaml
---
name: code-reviewer
description: Review code with validation
hooks:
  PreToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/lint.sh"
  Stop:
    - hooks:
        - type: "command"
          command: "echo 'Review complete'"
---
````

**Supported events in frontmatter:**
- All hook events supported
- For subagents: `Stop` hooks auto-converted to `SubagentStop`

**Lifecycle:**
- Hooks only run while component active
- Cleaned up when component finishes
- Use same configuration format as settings-based hooks

---

## FINDING-2026-03-04-58: Hook Management and Disabling

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Multiple methods to manage, disable, or remove hooks without editing settings files.

**The `/hooks` menu:**
- Interactive interface for viewing, adding, deleting hooks
- Each hook labeled with source: `[User]`, `[Project]`, `[Local]`, `[Plugin]`
- Plugin hooks are read-only
- Can toggle `disableAllHooks` setting

**Disable all hooks:**
````json
{
  "disableAllHooks": true
}
````

**Respects settings hierarchy:**
- User/project/local `disableAllHooks` cannot disable managed hooks
- Only managed policy `disableAllHooks` can disable managed hooks

**Hook configuration snapshot:**
- Hooks captured at startup, used throughout session
- External modifications require review in `/hooks` menu before applying
- Prevents malicious mid-session hook modifications

**Enterprise control:**
- `allowManagedHooksOnly`: Block user, project, plugin hooks (admin setting)
- Enforces only organization-approved hooks

---

## FINDING-2026-03-04-59: Hook Path References and Environment Variables

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks)

**What:**
Use environment variables to reference hook scripts relative to project/plugin root, regardless of working directory.

**Environment variables:**
- `$CLAUDE_PROJECT_DIR`: Project root directory
- `${CLAUDE_PLUGIN_ROOT}`: Plugin's root directory (for plugin-bundled scripts)
- `$CLAUDE_CODE_REMOTE`: Set to `"true"` in remote web environments, not set in CLI

**Project script example:**
````json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/check-style.sh"
          }
        ]
      }
    ]
  }
}
````

**Plugin script example (in plugin `hooks/hooks.json`):**
````json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format.sh"
          }
        ]
      }
    ]
  }
}
````

---

## Notes

All findings captured from official Claude Code documentation but NOT YET VERIFIED.

Hooks are the primary automation mechanism in Claude Code, supporting four handler types and 16 lifecycle events.
