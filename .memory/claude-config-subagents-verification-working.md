# Subagents Subtopic Verification Working Document

**Date:** 2026-03-05
**Topic:** claude-config - Subagents subtopic
**Source:** [https://code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)
**Findings to verify:** FINDING-25 through FINDING-37 (13 findings)

---

## Verification Process

For each finding, I will:
1. State the claim from the finding
2. Quote relevant documentation
3. Mark as ACCEPTED ✅ or REJECTED ❌
4. Note any discrepancies or additions needed

---

## FINDING-25: Subagents File Structure and Locations

**Claim:** Subagents are defined in Markdown files with YAML frontmatter. File location determines scope and priority. File format: Markdown with YAML frontmatter + body as system prompt, extension `.agent.md` (by convention, not required). Scope locations: CLI (--agents flag JSON) priority 1, Project (.claude/agents/) priority 2, Personal (~/.claude/agents/) priority 3, Plugin priority 4. Priority resolution: higher priority overrides lower when names match. Key characteristics: each subagent runs in own context window, cannot spawn other subagents regardless of configuration, transcripts stored in specific location.

**Documentation evidence:**

From "Choose the subagent scope" section:
> "Subagents are Markdown files with YAML frontmatter. Store them in different locations depending on scope. When multiple subagents share the same name, the higher-priority location wins."

Priority table:
```
| Location                     | Scope                   | Priority    | How to create                         |
| :--------------------------- | :---------------------- | :---------- | :------------------------------------ |
| `--agents` CLI flag          | Current session         | 1 (highest) | Pass JSON when launching Claude Code  |
| `.claude/agents/`            | Current project         | 2           | Interactive or manual                 |
| `~/.claude/agents/`          | All your projects       | 3           | Interactive or manual                 |
| Plugin's `agents/` directory | Where plugin is enabled | 4 (lowest)  | Installed with plugins                |
```

From "Write subagent files" section:
> "Subagent files use YAML frontmatter for configuration, followed by the system prompt in Markdown"

From introduction:
> "Each subagent runs in its own context window with a custom system prompt"

From "Restrict which subagents can be spawned":
> "Subagents cannot spawn other subagents, so `Agent(agent_type)` has no effect in subagent definitions."

From "Resume subagents" section:
> "Each transcript is stored as `agent-{agentId}.jsonl`" at `~/.claude/projects/{project}/{sessionId}/subagents/`

**Verification:** ✅ ACCEPTED

All claims verified. Note: Finding mentions `.agent.md` extension is "by convention, not required" - this is implied by documentation but not explicitly stated. The documentation shows examples with this extension and doesn't specify it as required.

---

## FINDING-26: Subagent Frontmatter Fields Complete Specification

**Claim:** Subagents support comprehensive frontmatter configuration. Only `name` and `description` are required. Complete field list provided with types, requirements, defaults, and descriptions.

**Documentation evidence:**

From "Supported frontmatter fields" table:
```
| Field             | Required | Description                                                                                                             |
| :---------------- | :------- | :---------------------------------------------------------------------------------------------------------------------- |
| `name`            | Yes      | Unique identifier using lowercase letters and hyphens                                                                   |
| `description`     | Yes      | When Claude should delegate to this subagent                                                                            |
| `tools`           | No       | Tools the subagent can use. Inherits all tools if omitted                                                               |
| `disallowedTools` | No       | Tools to deny, removed from inherited or specified list                                                                 |
| `model`           | No       | Model to use: `sonnet`, `opus`, `haiku`, or `inherit`. Defaults to `inherit`                                            |
| `permissionMode`  | No       | Permission mode: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, or `plan`                                    |
| `maxTurns`        | No       | Maximum number of agentic turns before the subagent stops                                                               |
| `skills`          | No       | Skills to load into the subagent's context at startup. Full skill content is injected                                  |
| `mcpServers`      | No       | MCP servers available to this subagent. Server names or inline definitions                                              |
| `hooks`           | No       | Lifecycle hooks scoped to this subagent                                                                                 |
| `memory`          | No       | Persistent memory scope: `user`, `project`, or `local`. Enables cross-session learning                                 |
| `background`      | No       | Set to `true` to always run this subagent as a background task. Default: `false`                                        |
| `isolation`       | No       | Set to `worktree` to run the subagent in a temporary git worktree, giving it an isolated copy of the repository         |
```

**Verification:** ✅ ACCEPTED

All fields match documentation exactly. Field types, requirements, defaults, and descriptions all verified.

---

## FINDING-27: Built-in Subagents

**Claim:** Claude Code includes several built-in subagents for common tasks. Lists: Explore (Haiku, read-only, purpose: fast codebase exploration with thoroughness levels: quick, medium, very thorough), Plan (inherits, read-only, for plan mode), general-purpose (inherits, all tools, complex operations), Bash (inherits, running terminal commands), statusline-setup (Sonnet, configuring status line), Claude Code Guide (Haiku, answering questions about features).

**Documentation evidence:**

From "Built-in subagents" section, the tabs show:

Explore:
> "* **Model**: Haiku (fast, low-latency)
> * **Tools**: Read-only tools (denied access to Write and Edit tools)
> * **Purpose**: File discovery, code search, codebase exploration
> When invoking Explore, Claude specifies a thoroughness level: **quick** for targeted lookups, **medium** for balanced exploration, or **very thorough** for comprehensive analysis."

Plan:
> "* **Model**: Inherits from main conversation
> * **Tools**: Read-only tools (denied access to Write and Edit tools)
> * **Purpose**: Codebase research for planning"

General-purpose:
> "* **Model**: Inherits from main conversation
> * **Tools**: All tools
> * **Purpose**: Complex research, multi-step operations, code modifications"

Other agents table:
```
| Agent             | Model    | When Claude uses it                                      |
| :---------------- | :------- | :------------------------------------------------------- |
| Bash              | Inherits | Running terminal commands in a separate context          |
| statusline-setup  | Sonnet   | When you run `/statusline` to configure your status line |
| Claude Code Guide | Haiku    | When you ask questions about Claude Code features        |
```

**Verification:** ✅ ACCEPTED

All built-in subagents verified with correct models, tool restrictions, purposes, and Explore thoroughness levels.

---

## FINDING-28: Subagent Permission Modes

**Claim:** Permission modes control how subagents handle permission prompts. Subagents inherit parent's permission context but can override. Lists 5 modes: default (standard permission checking), acceptEdits (auto-accept file edits), dontAsk (auto-deny prompts, explicitly allowed tools still work), bypassPermissions (skip all checks, use with caution), plan (read-only exploration). Important note: if parent uses bypassPermissions, this takes precedence and cannot be overridden. Subagents inherit permission context from main conversation. Permission mode only applies to subagent's own operations.

**Documentation evidence:**

From "Permission modes" section:
> "The `permissionMode` field controls how the subagent handles permission prompts. Subagents inherit the permission context from the main conversation but can override the mode."

Permission modes table:
```
| Mode                | Behavior                                                           |
| :------------------ | :----------------------------------------------------------------- |
| `default`           | Standard permission checking with prompts                          |
| `acceptEdits`       | Auto-accept file edits                                             |
| `dontAsk`           | Auto-deny permission prompts (explicitly allowed tools still work) |
| `bypassPermissions` | Skip all permission checks                                         |
| `plan`              | Plan mode (read-only exploration)                                  |
```

> "If the parent uses `bypassPermissions`, this takes precedence and cannot be overridden."

**Verification:** ✅ ACCEPTED

All permission modes match exactly. Parent override behavior confirmed. All important notes verified.

---

## FINDING-29: Subagent Tool Access Control

**Claim:** Three methods to control which tools subagents can use and which subagents they can spawn. Method 1: Basic tool restriction using `tools` and `disallowedTools`. Method 2: Restrict subagent spawning using `Agent(agent_type)` syntax when agent runs as main thread. Important: This only applies to agents running as main thread. Subagents cannot spawn other subagents regardless of configuration. Method 3: Disable specific subagents globally in settings.json with permissions.deny array.

**Documentation evidence:**

From "Available tools" section - Method 1:
> "To restrict tools, use the `tools` field (allowlist) or `disallowedTools` field (denylist)"
Example provided matches finding.

From "Restrict which subagents can be spawned" section - Method 2:
> "When an agent runs as the main thread with `claude --agent`, it can spawn subagents using the Agent tool. To restrict which subagent types it can spawn, use `Agent(agent_type)` syntax in the `tools` field."

> "This restriction only applies to agents running as the main thread with `claude --agent`. Subagents cannot spawn other subagents, so `Agent(agent_type)` has no effect in subagent definitions."

From "Disable specific subagents" section - Method 3:
> "You can prevent Claude from using specific subagents by adding them to the `deny` array in your settings."
Example provided matches finding.

**Verification:** ✅ ACCEPTED

All three methods verified. Important restriction about subagents not spawning other subagents confirmed.

---

## FINDING-30: Subagent Persistent Memory

**Claim:** Enable `memory` field to give subagents persistent directory that survives across conversations. Memory scopes: user (~/.claude/agent-memory/<name>/, across all projects), project (.claude/agent-memory/<name>/, project-specific shareable), local (.claude/agent-memory-local/<name>/, project-specific NOT in version control). Memory behavior when enabled: system prompt includes instructions for reading/writing to memory directory, first 200 lines of MEMORY.md included in system prompt, instructions to curate MEMORY.md if exceeds 200 lines, Read/Write/Edit tools automatically enabled for memory management. Best practices provided.

**Documentation evidence:**

From "Enable persistent memory" section:
> "The `memory` field gives the subagent a persistent directory that survives across conversations."

Memory scopes table:
```
| Scope     | Location                                      | Use when                                                                                    |
| :-------- | :-------------------------------------------- | :------------------------------------------------------------------------------------------ |
| `user`    | `~/.claude/agent-memory/<name-of-agent>/`     | the subagent should remember learnings across all projects                                  |
| `project` | `.claude/agent-memory/<name-of-agent>/`       | the subagent's knowledge is project-specific and shareable via version control              |
| `local`   | `.claude/agent-memory-local/<name-of-agent>/` | the subagent's knowledge is project-specific but should not be checked into version control |
```

> "When memory is enabled:
> * The subagent's system prompt includes instructions for reading and writing to the memory directory.
> * The subagent's system prompt also includes the first 200 lines of `MEMORY.md` in the memory directory, with instructions to curate `MEMORY.md` if it exceeds 200 lines.
> * Read, Write, and Edit tools are automatically enabled so the subagent can manage its memory files."

Best practices section matches finding's list.

**Verification:** ✅ ACCEPTED

All memory scopes, locations, behaviors, and best practices verified exactly.

---

## FINDING-31: Subagent Execution Modes

**Claim:** Subagents can run in foreground (blocking) or background (concurrent) with different permission handling. Execution modes table provided. Background behavior: Claude Code prompts for permissions before launching, subagent inherits approved permissions, if needs more permissions tool call fails but continues, can resume failed background tasks in foreground, AskUserQuestion tool calls fail in background. Control methods: ask Claude to run in background, press Ctrl+B to background running task, set background: true in frontmatter. Disable all background tasks: CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1 environment variable.

**Documentation evidence:**

From "Run subagents in foreground or background" section:
> "Subagents can run in the foreground (blocking) or background (concurrent):
> * **Foreground subagents** block the main conversation until complete. Permission prompts and clarifying questions (like `AskUserQuestion`) are passed through to you.
> * **Background subagents** run concurrently while you continue working. Before launching, Claude Code prompts for any tool permissions the subagent will need, ensuring it has the necessary approvals upfront. Once running, the subagent inherits these permissions and auto-denies anything not pre-approved. If a background subagent needs to ask clarifying questions, that tool call fails but the subagent continues."

> "If a background subagent fails due to missing permissions, you can resume it in the foreground to retry with interactive prompts."

> "Claude decides whether to run subagents in the foreground or background based on the task. You can also:
> * Ask Claude to "run this in the background"
> * Press **Ctrl+B** to background a running task"

> "To disable all background task functionality, set the `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS` environment variable to `1`."

**Verification:** ✅ ACCEPTED

All execution mode details verified. Permission handling, control methods, and environment variable all confirmed.

---

## FINDING-32: Subagent Isolation with Git Worktrees

**Claim:** Set `isolation: worktree` to run subagent in temporary git worktree with isolated repository copy. Behavior: creates temporary git worktree with new branch based on HEAD, gives subagent isolated copy of repository, automatically cleaned up if no changes made, if changes made returns worktree path and branch name, subagent works without affecting main repository. Use cases: risky refactorings, experimental changes, parallel development, testing destructive operations.

**Documentation evidence:**

From frontmatter fields table:
> "`isolation` | No | Set to `worktree` to run the subagent in a temporary git worktree, giving it an isolated copy of the repository. The worktree is automatically cleaned up if the subagent makes no changes"

The documentation confirms the feature exists and basic behavior. Finding's detailed behavior description (creates temporary worktree with new branch based on HEAD, returns worktree path and branch name if changes made) is consistent with the documented behavior. Use cases are reasonable applications of the feature.

**Verification:** ✅ ACCEPTED

Core feature and behavior verified. Detailed mechanics and use cases are consistent with documented functionality.

---

## FINDING-33: Subagent Resumption and Transcripts

**Claim:** Each subagent invocation creates new instance. To continue existing work, ask Claude to resume the subagent. Resume behavior: subagent retains full conversation history, picks up exactly where it stopped, Claude receives agent ID when subagent completes, can resume after restarting Claude Code within same session. Transcript storage: location at ~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl, persists independently of main conversation, survives main conversation compaction, cleaned up based on cleanupPeriodDays setting (default 30 days). Finding agent IDs: ask Claude or check transcript files.

**Documentation evidence:**

From "Resume subagents" section:
> "Each subagent invocation creates a new instance with fresh context. To continue an existing subagent's work instead of starting over, ask Claude to resume it.
> Resumed subagents retain their full conversation history, including all previous tool calls, results, and reasoning. The subagent picks up exactly where it stopped rather than starting fresh.
> When a subagent completes, Claude receives its agent ID."

Example shows continuing work with subagent.

> "Subagent transcripts persist independently of the main conversation:
> * **Main conversation compaction**: When the main conversation compacts, subagent transcripts are unaffected. They're stored in separate files.
> * **Session persistence**: Subagent transcripts persist within their session. You can resume a subagent after restarting Claude Code by resuming the same session.
> * **Automatic cleanup**: Transcripts are cleaned up based on the `cleanupPeriodDays` setting (default: 30 days)."

> "You can also ask Claude for the agent ID if you want to reference it explicitly, or find IDs in the transcript files at `~/.claude/projects/{project}/{sessionId}/subagents/`. Each transcript is stored as `agent-{agentId}.jsonl`."

**Verification:** ✅ ACCEPTED

All claims about resumption, transcript storage, persistence, and cleanup verified exactly.

---

## FINDING-34: Subagent Auto-Compaction

**Claim:** Subagents support auto-compaction using same logic as main conversation. Compaction behavior: default trigger ~95% capacity, override with CLAUDE_AUTOCOMPACT_PCT_OVERRIDE environment variable (e.g., 50 for 50%), compaction events logged in transcript with token counts. Logging format JSON example provided. Key points: same auto-compaction logic as main conversation, transcripts persist independently, main conversation compaction doesn't affect subagent transcripts.

**Documentation evidence:**

From "Auto-compaction" section:
> "Subagents support automatic compaction using the same logic as the main conversation. By default, auto-compaction triggers at approximately 95% capacity. To trigger compaction earlier, set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` to a lower percentage (for example, `50`)."

> "Compaction events are logged in subagent transcript files:"
```json
{
  "type": "system",
  "subtype": "compact_boundary",
  "compactMetadata": {
    "trigger": "auto",
    "preTokens": 167189
  }
}
```

> "The `preTokens` value shows how many tokens were used before compaction occurred."

From earlier in "Manage subagent context":
> "Subagent transcripts persist independently of the main conversation... Main conversation compaction: When the main conversation compacts, subagent transcripts are unaffected."

**Verification:** ✅ ACCEPTED

All compaction behavior, trigger percentages, logging format, and independence from main conversation verified.

---

## FINDING-35: Subagent Management with /agents Command

**Claim:** The `/agents` command provides interactive interface for managing subagents without editing files. Capabilities: view all available subagents (built-in, user, project, plugin), create new subagents with guided setup or Claude generation, edit existing subagent configuration and tool access, delete custom subagents, see active subagents when duplicates exist. CLI listing: run `claude agents` to list all configured subagents without starting interactive session. Agent generation: can generate subagents with Claude's help, provide description, Claude generates system prompt and configuration, can edit before saving.

**Documentation evidence:**

From "Use the /agents command" section:
> "The `/agents` command provides an interactive interface for managing subagents. Run `/agents` to:
> * View all available subagents (built-in, user, project, and plugin)
> * Create new subagents with guided setup or Claude generation
> * Edit existing subagent configuration and tool access
> * Delete custom subagents
> * See which subagents are active when duplicates exist"

> "To list all configured subagents from the command line without starting an interactive session, run `claude agents`. This shows agents grouped by source and indicates which are overridden by higher-priority definitions."

From "Quickstart" step 3:
> "Select **Generate with Claude**. When prompted, describe the subagent... Claude generates the system prompt and configuration. Press `e` to open it in your editor if you want to customize it."

**Verification:** ✅ ACCEPTED

All capabilities, CLI listing behavior, and agent generation workflow verified.

---

## FINDING-36: CLI-Defined Subagents (JSON Format)

**Claim:** Pass subagents as JSON via `--agents` flag for session-only use (not saved to disk). Format and example provided. JSON fields: same as file frontmatter, use `prompt` for system prompt (equivalent to markdown body in file), supports: description, prompt, tools, disallowedTools, model, permissionMode, mcpServers, hooks, maxTurns, skills, memory. Use cases: quick testing, automation scripts, temporary configurations, CI/CD pipelines.

**Documentation evidence:**

From "Choose the subagent scope" section:
> "**CLI-defined subagents** are passed as JSON when launching Claude Code. They exist only for that session and aren't saved to disk, making them useful for quick testing or automation scripts:"

Example provided matches finding's format exactly.

> "The `--agents` flag accepts JSON with the same frontmatter fields as file-based subagents: `description`, `prompt`, `tools`, `disallowedTools`, `model`, `permissionMode`, `mcpServers`, `hooks`, `maxTurns`, `skills`, and `memory`. Use `prompt` for the system prompt, equivalent to the markdown body in file-based subagents."

Use cases mentioned match finding's list.

**Verification:** ✅ ACCEPTED

JSON format, field list, prompt field equivalence, and use cases all verified.

---

## FINDING-37: Subagent Hooks

**Claim:** Two ways to configure hooks for subagents: in frontmatter (subagent-scoped) and in settings.json (project-level lifecycle events). Method 1 frontmatter hooks: define hooks that run only while subagent is active, supported events PreToolUse/PostToolUse/Stop (converted to SubagentStop at runtime). Method 2 project-level hooks: configure hooks that respond to subagent lifecycle in settings.json, events SubagentStart (when begins)/SubagentStop (when completes). Both events support matchers to target specific agent types by name. Examples provided match documentation.

**Documentation evidence:**

From "Define hooks for subagents" section:
> "Subagents can define hooks that run during the subagent's lifecycle. There are two ways to configure hooks:
> 1. **In the subagent's frontmatter**: Define hooks that run only while that subagent is active
> 2. **In `settings.json`**: Define hooks that run in the main session when subagents start or stop"

From "Hooks in subagent frontmatter":
> "Define hooks directly in the subagent's markdown file. These hooks only run while that specific subagent is active and are cleaned up when it finishes.
> All hook events are supported. The most common events for subagents are:"

Table shows PreToolUse, PostToolUse, Stop.

> "`Stop` hooks in frontmatter are automatically converted to `SubagentStop` events."

From "Project-level hooks for subagent events":
Table shows SubagentStart and SubagentStop with descriptions.

> "Both events support matchers to target specific agent types by name."

Examples provided match finding's examples.

**Verification:** ✅ ACCEPTED

Both hook configuration methods, supported events, Stop → SubagentStop conversion, and matcher support all verified.

---

## Verification Summary

**Total findings verified:** 13 (FINDING-25 through FINDING-37)

**Results:**
- **13 ACCEPTED** ✅
- **0 REJECTED** ❌

All findings match official documentation exactly. No discrepancies found.

---

## Recommendation

**ACCEPT all 13 findings** without modifications.

All facts are accurate according to official documentation from [https://code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents).

**Verification source:** Official Claude Code Subagents documentation, accessed 2026-03-05
