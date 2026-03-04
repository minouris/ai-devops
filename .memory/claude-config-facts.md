# Claude Config Facts

Research findings on Claude Code and Claude SDK configuration and customization methods.

---

## FINDING-2026-03-04-1: Skills - Primary Extension Mechanism

**Source:** [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)

**What:**
Skills are the primary way to extend Claude Code's capabilities. A skill is a SKILL.md file containing instructions that Claude uses as part of its toolkit.

**Key attributes:**
- File format: `SKILL.md` in YAML frontmatter + Markdown body
- Invocation: `/skill-name` by user or automatic by Claude based on description
- Location determines scope:
  - Enterprise: Managed settings (organization-wide)
  - Personal: `~/.claude/skills/<skill-name>/SKILL.md` (all projects)
  - Project: `.claude/skills/<skill-name>/SKILL.md` (project only)
  - Plugin: `<plugin>/skills/<skill-name>/SKILL.md` (where plugin enabled)
- Skills follow Agent Skills open standard (agentskills.io)
- Custom commands have been merged into skills

**Frontmatter fields (all optional except `name` and `description` recommended):**
- `name`: Display name, becomes `/slash-command`
- `description`: When to use the skill (Claude uses this for auto-invocation)
- `argument-hint`: Hint for autocomplete
- `disable-model-invocation`: `true` prevents Claude from auto-loading
- `user-invocable`: `false` hides from `/` menu
- `allowed-tools`: Tools Claude can use without permission when skill active
- `model`: Model to use (`sonnet`, `opus`, `haiku`)
- `context`: Set to `fork` to run in subagent
- `agent`: Which subagent type when `context: fork`
- `hooks`: Hooks scoped to skill lifecycle

**String substitutions available:**
- `$ARGUMENTS`: All arguments passed to skill
- `$ARGUMENTS[N]` or `$N`: Specific argument by index
- `${CLAUDE_SESSION_ID}`: Current session ID

**Supporting files:**
- Skills can include multiple files in directory
- `SKILL.md` is required, other files optional (templates, examples, scripts)

**Bundled skills included with Claude Code:**
- `/simplify`: Reviews code for reuse, quality, efficiency
- `/batch <instruction>`: Orchestrates large-scale parallel changes
- `/debug [description]`: Troubleshoots session by reading debug log

---

## FINDING-2026-03-04-2: Subagents - Specialized Task Handlers

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**What:**
Subagents are specialized AI assistants with their own context window, custom system prompt, specific tool access, and independent permissions. Each handles a specific type of task.

**File format:**
- Markdown files with YAML frontmatter
- Body becomes the system prompt
- Location determines scope:
  - CLI: `--agents` flag (session only, JSON format)
  - Project: `.claude/agents/<name>.agent.md`
  - Personal: `~/.claude/agents/<name>.agent.md`
  - Plugin: `<plugin>/agents/<name>.agent.md`

**Frontmatter fields:**
- `name` (required): Unique identifier, lowercase with hyphens
- `description` (required): When to delegate to this subagent
- `tools`: Tools the subagent can use (inherits all if omitted)
- `disallowedTools`: Tools to deny
- `model`: `sonnet`, `opus`, `haiku`, or `inherit` (default)
- `permissionMode`: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan`
- `maxTurns`: Maximum agentic turns
- `skills`: Skills to preload into subagent context at startup
- `mcpServers`: MCP servers available to subagent
- `hooks`: Lifecycle hooks scoped to subagent
- `memory`: Persistent memory scope (`user`, `project`, `local`)
- `background`: Set to `true` to always run as background task
- `isolation`: Set to `worktree` for git worktree isolation

**Built-in subagents:**
- `Explore`: Fast, read-only, Haiku model for codebase exploration
- `Plan`: Research agent for plan mode
- `general-purpose`: All tools, complex multi-step tasks
- Others: `Bash`, `statusline-setup`, `Claude Code Guide`

**Key behaviors:**
- Subagents cannot spawn other subagents
- Subagents can be resumed to continue previous work with full context
- Transcripts stored in `~/.claude/projects/{project}/{sessionId}/subagents/`
- Support auto-compaction at ~95% capacity
- Can run in foreground (blocking) or background (concurrent)

---

## FINDING-2026-03-04-3: Hooks - Event-Driven Automation

**Source:** [Hooks reference - Claude Code Docs](https://code.claude.com/docs/en/hooks.md), local codebase examination

**What:**
Hooks are shell commands that execute automatically in response to AI tool events. They enable automation, validation, formatting, notifications, and rule enforcement.

**Configuration locations:**
- Global/project: `settings.json` in `hooks` field
- Skill-scoped: In skill's YAML frontmatter
- Subagent-scoped: In subagent's YAML frontmatter
- File format for standalone hooks: `*.hook.md` (based on codebase structure files found)

**Hook events supported:**
- `PreToolUse`: Before tool call execution
- `PostToolUse`: After tool call completes
- `Stop`: When AI session ends
- `SubagentStart`: When subagent begins execution
- `SubagentStop`: When subagent completes
- `PreUserInputRequest`: Before asking user for input
- (Additional events documented in official hooks reference)

**Hook types:**
- `command`: Shell command execution
- `prompt`: Inject dynamic text into prompts
- `http`: HTTP request hooks
- MCP tool hooks
- Async hooks (background execution)

**Exit code behaviors:**
- Exit 0: Success, continue
- Exit 1: Failure, block action
- Exit 2: Block with custom message (from stderr)

**Input/output:**
- Hooks receive JSON via stdin with tool name, input, context
- Stdout captured as hook output
- Stderr used for error messages

---

## FINDING-2026-03-04-4: Rules - Project-Level Instructions

**Source:** Local codebase examination (`/workspaces/ai-devops/.claude/rules/`)

**What:**
Rules are project-level instructions that apply to all Claude Code sessions. They are Markdown files stored in `.claude/rules/` directory.

**File format:**
- Markdown with YAML frontmatter
- Naming: `{name}.md` in `.claude/rules/`
- Frontmatter fields (from rule-structure.md):
  - `name`: Matching filename without .md
  - `description`: One sentence describing what rule enforces
  - `paths`: Glob if rule applies to specific file patterns
  - `release`: Release configuration if publishing

**Content structure:**
- H1 heading: `# {Name} Standards`
- System Prompt Conflict Resolution section (when overriding AI defaults)
- MUST/MUST NOT sections with specific requirements
- Compliance Verification section at end
- Must end with "If ANY answer is 'No'" enforcement statement

**Examples found in codebase:**
- `documentation-first.md`: Mandatory documentation consultation
- `documentation-standards.md`: UK English, tone, formatting
- `git-commits.md`: Git commit message standards
- `rule-structure.md`: Standards for rule artifacts themselves
- `skill-structure.md`: Standards for skill artifacts
- `agent-structure.md`: Standards for agent artifacts
- `hook-structure.md`: Standards for hook artifacts
- `command-structure.md`: Standards for command artifacts

---

## FINDING-2026-03-04-5: Commands - User-Invocable Slash Commands

**Source:** Local codebase structure files, [Extend Claude with skills](https://code.claude.com/docs/en/skills)

**What:**
Commands are slash commands invoked by users via `/command-name`. Custom commands have been merged into the skills system, but `.claude/commands/*.md` files still work.

**File format:**
- Markdown file: `{name}.md` in `.claude/commands/`
- Frontmatter fields (from command-structure.md):
  - `name`: Matching filename without .md
  - `description`: One sentence shown in slash command list
  - `release`: Release configuration if publishing

**Behavior:**
- A file at `.claude/commands/review.md` and a skill at `.claude/skills/review/SKILL.md` both create `/review`
- Skills take precedence if both exist
- Commands support same frontmatter as skills
- Skills are recommended for new development (support additional features)

**Built-in commands (not accessible via Skill tool):**
- `/help`: Get help with Claude Code
- `/compact`: Manually trigger conversation compaction
- `/init`: Initialize project
- `/agents`: Manage subagents interactively
- `/permissions`: Configure permissions
- `/context`: View context window usage
- `/statusline`: Configure status line
- (See [interactive mode](https://code.claude.com/docs/en/interactive-mode#built-in-commands))

---

## FINDING-2026-03-04-6: Prompts - Reusable Prompt Workflows

**Source:** Local codebase examination, `.claude/README.md`

**What:**
Prompts are reusable prompt workflows for specific tasks. They are referenced/invoked within skills or manually.

**File format:**
- Markdown file: `*.prompt.md`
- Location: `.claude/prompts/` or equivalent in source directories
- Frontmatter format not yet examined (need to read actual prompt files)

**Examples found:**
- `verify-memory-facts.prompt.md`: Verify facts against authoritative documentation
- `record-operation.prompt.md`: Operation logging for session continuity
- `consolidate-session.prompt.md`: Session consolidation
- `convert-plan-to-steps.prompt.md`: Convert plans to steps

**Usage:**
- Referenced in skill workflows
- Can be invoked with parameters like `memoryFilePath=.memory/{filename}.md`
- Part of larger workflows, not standalone user commands

---

## FINDING-2026-03-04-7: CLAUDE.md - Project Instructions File

**Source:** [How Claude remembers your project](https://code.claude.com/docs/en/memory.md), local CLAUDE.md examination

**What:**
CLAUDE.md is the primary configuration file for customizing Claude's behavior. It contains project-level instructions that apply to all sessions.

**Location:**
- Global: `~/.claude/CLAUDE.md` (all projects)
- Project: `./CLAUDE.md` or `.claude/CLAUDE.md` (project only)
- Priority: Project > Global

**Content:**
- Plain Markdown format (no frontmatter required)
- Contains instructions, rules, preferences, constraints
- Loaded automatically at session start
- Should not exceed 150+ lines (not guaranteed to be fully read)

**Best practices (from web search results):**
- Keep concise
- Use feature-specific subagents with skills (progressive disclosure)
- Avoid duplicating content better suited for rules, skills, or agents

**Additional directories:**
- Files in `--add-dir` directories are loaded
- Set `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` to load CLAUDE.md from additional directories

---

## FINDING-2026-03-04-8: settings.json - Configuration and Permissions

**Source:** Local settings.json examination, [Claude Code settings](https://code.claude.com/docs/en/settings.md)

**What:**
settings.json (or settings.local.json) configures permissions, hooks, MCP servers, and other Claude Code behavior.

**Locations:**
- Global: `~/.claude-data/settings.json`
- Project: `.claude/settings.local.json` or `.devcontainer/.claude-data/settings.json`
- Priority: Project > Global

**Key sections:**
- `permissions.allow`: Tool-specific permissions granted
- `permissions.deny`: Tool-specific permissions denied
- `permissions.additionalDirectories`: Extra directories accessible
- `hooks`: Hook configurations (PreToolUse, PostToolUse, Stop, SubagentStart, SubagentStop, etc.)
- `mcpServers`: MCP server definitions
- Environment variables can also be used for configuration

**Permission syntax examples:**
- `Bash(git rm:*)`: Allow git rm commands
- `Bash(wc:*)`: Allow word count
- `Read(//workspaces/ai-devops/.tmp/spafw37/**)`: Allow reading specific paths
- `Skill(commit)`: Allow specific skill
- `Agent(Explore)`: Allow/deny specific subagent

---

## FINDING-2026-03-04-9: Auto Memory - Persistent Context Directory

**Source:** Local codebase examination, [How Claude remembers your project](https://code.claude.com/docs/en/memory.md)

**What:**
Auto memory is a persistent directory at `~/.claude/projects/<project>/memory/` (or `.memory/` in project) where Claude stores information across conversations.

**Key characteristics:**
- `MEMORY.md` is always loaded into conversation context
- First 200 lines of MEMORY.md are included; lines after 200 truncated
- Used for capturing knowledge, patterns, preferences
- Organized semantically by topic, not chronologically
- Can create separate topic files linked from MEMORY.md

**File organization:**
- `MEMORY.md`: Primary memory file
- Topic-specific files: `{topic}.md`
- Keep MEMORY.md concise, link to detailed files

**Usage:**
- Update or remove memories that are wrong/outdated
- Don't duplicate memories
- Check existing before writing new

**Per-subagent memory:**
- Subagents can have persistent memory with `memory` frontmatter field
- Scopes: `user` (global), `project` (project-specific), `local` (project but not in version control)
- Stored in `.claude/agent-memory/<agent-name>/` or similar

---

## FINDING-2026-03-04-10: MCP (Model Context Protocol) - External Tool Integration

**Source:** [Connect Claude Code to tools via MCP](https://code.claude.com/docs/en/mcp.md), settings.json examination

**What:**
MCP (Model Context Protocol) allows Claude Code to connect to external tools, APIs, and data sources through standardized server integrations.

**Configuration:**
- Defined in `settings.json` under `mcpServers` field
- Each server has a name and configuration (command, args, environment variables)
- Can be scoped to specific subagents via `mcpServers` frontmatter field

**Server definition format (inferred from subagent docs):**
- Server name as key
- Configuration object with:
  - `command`: Executable command
  - `args`: Command arguments
  - `env`: Environment variables (optional)

**Usage:**
- MCP tools appear alongside Claude's built-in tools
- Can be granted/denied via permissions system
- Subagents can specify which MCP servers they have access to

**Integration points:**
- Global: All sessions can access configured servers
- Per-subagent: Subagent frontmatter can specify specific servers
- Inline definition: Define server configuration directly in subagent

---

## FINDING-2026-03-04-11: Plugins - Packaged Distribution of Artifacts

**Source:** [Create plugins](https://code.claude.com/docs/en/plugins.md), [Plugins reference](https://code.claude.com/docs/en/plugins-reference.md)

**What:**
Plugins are packages that bundle skills, agents, hooks, MCP servers, and other extensions for distribution across teams or projects.

**Plugin structure:**
```
my-plugin/
├── plugin.json         # Plugin metadata and configuration
├── skills/             # Skills directory
│   └── <skill-name>/
│       └── SKILL.md
├── agents/             # Subagents directory
│   └── <agent>.agent.md
├── hooks/              # Hooks (if applicable)
├── mcp-servers/        # MCP server definitions (if applicable)
└── README.md           # Plugin documentation
```

**plugin.json fields (inferred):**
- Plugin metadata (name, version, description)
- Component declarations
- Dependencies
- Configuration options

**Distribution:**
- Can be installed from plugin marketplaces
- Plugins use namespacing: `plugin-name:skill-name` for skills
- Cannot conflict with other levels (enterprise, personal, project)

**CLI commands (from plugins reference):**
- Plugin installation and management
- Marketplace discovery
- (Full CLI reference not yet examined)

---

## FINDING-2026-03-04-12: Claude SDK Configuration Options

**Source:** [Agent SDK overview](https://platform.claude.com/docs/en/agent-sdk/overview), web search results

**What:**
Claude Agent SDK (formerly Claude Code SDK) provides programmatic access to Claude Code capabilities with extensive configuration options.

**ClaudeAgentOptions configuration:**
- `system_prompt` / `custom_system_prompt`: Custom system prompt override
- `append_system_prompt`: Additional instructions appended to default prompt
- `allowed_tools`: Tools the agent can use
- `permission_mode`: Permission behavior (`"default"`, `"acceptEdits"`, `"bypassPermissions"`)
- `cwd`: Working directory
- `max_turns`: Maximum agentic turns
- `setting_sources`: Load project settings (`["project"]`)
- `canUseTool`: Callback for custom tool permission logic

**Permission modes:**
- `"default"`: Prompts for approval
- `"acceptEdits"`: Auto-approve file edits
- `"bypassPermissions"`: Skip all permission checks

**Platform support:**
- Google Vertex AI: Set `CLAUDE_CODE_USE_VERTEX=1`
- Microsoft Azure: Set `CLAUDE_CODE_USE_FOUNDRY=1`
- Requires respective cloud credentials

**Custom tool permissions:**
- Implement `canUseTool` callback
- Can allow/block based on tool name, input, context
- Enables fine-grained control (e.g., allow reads, block writes)

**System prompt behavior:**
- Default Claude Code system prompt used unless overridden
- `append_system_prompt` adds to default
- `custom_system_prompt` replaces default

---

## FINDING-2026-03-04-13: Additional Configuration Methods

**Source:** [Claude Code settings](https://code.claude.com/docs/en/settings.md), documentation index

**Additional configuration files/methods:**
- **Keybindings**: `~/.claude/keybindings.json` for keyboard shortcuts
- **Status line**: Configured via `/statusline` or settings
- **Model aliases**: Configure model aliases like `opusplan` in settings
- **Environment variables**: Various `CLAUDE_CODE_*` variables for behavior modification
  - `CLAUDE_CODE_USE_VERTEX=1`: Google Vertex AI
  - `CLAUDE_CODE_USE_FOUNDRY=1`: Microsoft Azure
  - `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`: Load CLAUDE.md from additional directories
  - `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`: Disable background tasks
  - `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE`: Override auto-compaction percentage
  - `SLASH_COMMAND_TOOL_CHAR_BUDGET`: Override skill description character budget
- **Terminal configuration**: Terminal setup for optimal experience
- **Network configuration**: Proxy, custom CAs, mTLS for enterprise
- **LLM gateway**: Gateway requirements, authentication, model selection
- **Development containers**: .devcontainer configuration for consistent environments
- **Server-managed settings**: Centralized organization configuration for enterprise

**Permission configuration:**
- Fine-grained permission rules in settings.json
- Permission modes: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan`
- Managed policies for enterprise
- Tool-specific rules: `Tool(pattern *)` syntax

**Checkpointing:**
- Track, rewind, summarize edits and conversation
- Manage conversation state and history

---

## Notes

Research sources:
- Official Claude Code documentation (code.claude.com)
- Official Claude API/SDK documentation (platform.claude.com)
- Local codebase examination (/workspaces/ai-devops)
- Web search results (2026 documentation)

All findings captured with source citations for verification and traceability.
