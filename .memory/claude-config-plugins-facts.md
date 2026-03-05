# Claude Config Facts: Plugins Subtopic

Detailed research findings on Plugins for distributing and sharing Claude Code customizations.

**Source:** [https://code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)

---

## FINDING-2026-03-04-94: Plugins Overview and Purpose

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)
**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/plugins and https://code.claude.com/docs/en/plugins-reference]

**What:**
Plugins are packages that bundle Claude Code customizations (skills, subagents, hooks, MCP servers, LSP servers) for distribution and sharing. Introduced to enable sharing configurations across teams and the community.

**Key characteristics:**
- Package multiple configuration types in a single distributable unit
- Distributed via plugin marketplaces or direct installation
- Namespaced to avoid conflicts with local configurations
- Can include skills, subagents, hooks, MCP servers, and LSP servers
- Managed via CLI commands (install, enable, disable, uninstall)
- Scoped at user, project, local, or managed policy levels

**Purpose:**
- Share configurations across teams and projects
- Distribute reusable workflows to the community
- Package organization-wide standards as plugins
- Enable ecosystem of third-party integrations
- Version and update configurations systematically

---

## FINDING-2026-03-04-95: Plugin Directory Structure

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)
**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/plugins-reference - Note: Manifest is optional, not mandatory]

**What:**
Plugins have a standard directory structure with a manifest file and component directories.

**Standard structure:**
````text
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (required)
├── skills/
│   └── my-skill/
│       └── SKILL.md
├── agents/
│   └── my-agent.agent.md
├── hooks/
│   └── my-hook.hook.md
├── .mcp.json                # MCP server configurations (optional)
├── .lsp.json                # LSP server configurations (optional)
└── README.md                # Plugin documentation (recommended)
````

**Component directories:**
- `skills/`: Skill artifacts (same structure as `.claude/skills/`)
- `agents/`: Subagent artifacts (same structure as `.claude/agents/`)
- `hooks/`: Hook configurations (same structure as `.claude/hooks/`)
- `.mcp.json`: MCP server definitions
- `.lsp.json`: LSP server definitions

**Required files:**
- `.claude-plugin/plugin.json`: Plugin manifest (MANDATORY)

**Optional files:**
- Component directories (at least one recommended)
- README.md for documentation

---

## FINDING-2026-03-04-96: Plugin Manifest Schema (plugin.json)
**Verified:** [PARTIALLY VERIFIED on 2026-03-05 - Core fields confirmed; dependencies, peerDependencies, claudeVersion, platforms not documented]

**Note:** See [supplementary investigation on manifest dependencies](claude-config-plugins-supplementary-sources.md#1-plugin-manifest-dependencies) for evidence that `dependencies`, `peerDependencies`, `claudeVersion`, and `platforms` fields are feature requests (GitHub Issues #9444, #27113), not currently implemented.

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
The `plugin.json` manifest defines plugin metadata, dependencies, and configuration.

**Complete field specification:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Unique plugin identifier (lowercase, hyphens only) |
| `version` | string | Yes | Semantic version (e.g., "1.0.0") |
| `description` | string | Yes | Brief description of plugin purpose |
| `author` | string | No | Plugin author name or organization |
| `license` | string | No | SPDX license identifier (e.g., "MIT") |
| `repository` | string | No | Git repository URL |
| `homepage` | string | No | Plugin documentation/homepage URL |
| `keywords` | array | No | Search keywords for marketplace discovery |
| `dependencies` | object | No | Required plugin dependencies with versions |
| `peerDependencies` | object | No | Optional plugin dependencies |
| `claudeVersion` | string | No | Minimum required Claude Code version |
| `platforms` | array | No | Supported platforms: "linux", "darwin", "win32" |

**Example manifest:**
````json
{
  "name": "my-company-standards",
  "version": "1.0.0",
  "description": "Company-wide coding standards and workflows",
  "author": "My Company",
  "license": "MIT",
  "repository": "https://github.com/mycompany/claude-plugin",
  "homepage": "https://mycompany.com/docs/claude-plugin",
  "keywords": ["standards", "workflow", "company"],
  "dependencies": {
    "security-hooks": "^2.0.0"
  },
  "claudeVersion": ">=2.1.0",
  "platforms": ["linux", "darwin", "win32"]
}
````

---

## FINDING-2026-03-04-97: Plugin Installation and Management
**Verified:** [MOSTLY VERIFIED on 2026-03-05 - CLI commands and scopes confirmed; some installation sources not documented]

**Note:** See [supplementary investigation on installation sources](claude-config-plugins-supplementary-sources.md#4-installation-sources-git-urls-and-tarballs) for evidence that direct Git URL and tarball installation are not supported. Installation is marketplace-based with `--plugin-dir` flag for development.

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)

**What:**
Plugins managed via CLI commands with multiple installation sources and scopes.

**Installation sources:**

| Source Type | Command Example | Use Case |
|-------------|----------------|----------|
| Marketplace | `claude plugin install plugin-name` | Public plugins from official marketplace |
| Git URL | `claude plugin install https://github.com/user/plugin.git` | Direct from repository |
| Local path | `claude plugin install /path/to/plugin` | Development or private plugins |
| Tarball | `claude plugin install ./plugin.tgz` | Offline distribution |

**Installation scopes:**

| Scope | Flag | Location | Use When |
|-------|------|----------|----------|
| User | `--user` (default) | `~/.claude/plugins/` | Personal plugins for all projects |
| Project | `--project` | `./.claude/plugins/` | Team-shared plugins in version control |
| Local | `--local` | `./.claude/plugins-local/` | Project-specific, not in version control |
| Managed | `--managed` | System directory | Organization-wide mandated plugins |

**Management commands:**
````bash
# Install plugin
claude plugin install plugin-name
claude plugin install plugin-name --project

# List installed plugins
claude plugin list
claude plugin list --all  # Include disabled plugins

# Enable/disable plugin
claude plugin enable plugin-name
claude plugin disable plugin-name

# Update plugin
claude plugin update plugin-name
claude plugin update --all

# Uninstall plugin
claude plugin uninstall plugin-name
````

---

**Verified:** [MOSTLY VERIFIED on 2026-03-05 - Namespacing format confirmed; resolution priority implied but not fully documented]
## FINDING-2026-03-04-98: Plugin Namespacing and Resolution

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins use namespacing to prevent conflicts with local configurations and other plugins.

**Namespace format:**
- Plugin components accessed via: `plugin-name:component-name`
- Example: `/my-plugin:my-skill` invokes skill from plugin
- Example: `Agent(my-plugin:my-agent)` spawns subagent from plugin

**Resolution priority (highest to lowest):**
1. Local configurations (`.claude/skills/`, `.claude/agents/`, etc.)
2. Project plugins (`.claude/plugins/`)
3. User plugins (`~/.claude/plugins/`)
4. Managed plugins (system directory)

**Conflict handling:**
- Local configurations always take precedence over plugins
- Project plugins override user plugins
- Within same scope, first installed plugin takes precedence
- Use explicit namespace to invoke plugin component when conflicts exist

**Example invocation:**
````text
# If both local skill and plugin skill named "review" exist:
/review                    # Invokes local skill
/my-plugin:review         # Explicitly invokes plugin skill

# Subagent from plugin:
Use my-plugin:code-reviewer agent to review this file
````

**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/plugins-reference]
---

## FINDING-2026-03-04-99: Plugin Environment and Path Resolution

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins have special environment variable and path resolution for accessing plugin files.

**Environment variable:**
- `${CLAUDE_PLUGIN_ROOT}`: Path to plugin installation directory
- Available in all plugin component files (skills, hooks, agents)
- Use for referencing plugin files (scripts, templates, data)

**Example usage in hook:**
````yaml
---
name: plugin-validation-hook
event: PreToolUse
---

Run validation script from plugin:
command: "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
````

**Example usage in skill:**
````markdown
---
name: plugin-workflow
description: Workflow using plugin templates
---

# Workflow

1. Read template from plugin:
   Use Read tool: ${CLAUDE_PLUGIN_ROOT}/templates/workflow-template.md

2. Process template...
````

**Path resolution:**
- Relative paths in plugin components resolve relative to plugin root
- `${CLAUDE_PLUGIN_ROOT}` expands to absolute plugin installation path
- Same variable works across all installation scopes (user, project, local, managed)
**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/plugins-reference]

---

## FINDING-2026-03-04-100: Plugin MCP Server Configuration

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins can bundle MCP (Model Context Protocol) server configurations in `.mcp.json` file.

**MCP configuration format:**
````json
{
  "mcpServers": {
    "my-plugin-server": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/servers/my-server.js"],
      "env": {
        "API_KEY": "${MY_API_KEY}"
      }
    },
    "another-server": {
      "command": "python",
      "args": ["-m", "my_plugin.server"],
      "cwd": "${CLAUDE_PLUGIN_ROOT}/servers"
    }
  }
}
````

**Key features:**
- Define multiple MCP servers in single plugin
- Use `${CLAUDE_PLUGIN_ROOT}` for plugin-relative paths
- Support environment variable substitution
- Servers automatically available when plugin enabled
- Servers namespace-prefixed to avoid conflicts

**Integration:**
- MCP servers from plugins merge with user/project MCP configurations
- Plugin servers available to skills and subagents
**Verified:** [VERIFIED on 2026-03-05 by https://code.claude.com/docs/en/plugins-reference]
- Namespace: `my-plugin:my-plugin-server`

---

## FINDING-2026-03-04-101: Plugin LSP Server Configuration

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins can bundle LSP (Language Server Protocol) server configurations in `.lsp.json` file.

**LSP configuration format:**
````json
{
  "lspServers": {
    "my-language-server": {
      "command": "my-language-server",
      "args": ["--stdio"],
      "filetypes": ["*.mylang"],
      "rootPatterns": ["mylang.config.json", ".git"],
      "env": {
        "PATH": "${CLAUDE_PLUGIN_ROOT}/bin:${PATH}"
      }
    }
  }
}
````

**Field specification:**

| Field | Type | Description |
|-------|------|-------------|
| `command` | string | LSP server executable command |
| `args` | array | Command arguments |
| `filetypes` | array | File patterns to activate server (glob format) |
| `rootPatterns` | array | Patterns to detect project root |
| `env` | object | Environment variables for server process |
| `initializationOptions` | object | LSP initialization options |

**Use cases:**
- Bundle language servers for custom languages
- Provide enhanced IDE features for frameworks
**Verified:** [MOSTLY VERIFIED on 2026-03-05 - Marketplace distribution confirmed; some details not documented]
- Add linting and formatting capabilities
- Enable code intelligence for DSLs

---

## FINDING-2026-03-04-102: Plugin Distribution via Marketplaces

**Note:** See [supplementary investigation on CLI commands](claude-config-plugins-supplementary-sources.md#3-cli-commands-claude-plugin-publish-and-claude-plugin-outdated) for evidence that `claude plugin publish` command does not exist. Publishing uses in-app submission forms instead.

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)

**What:**
Plugins distributed via official Claude Code plugin marketplace and third-party marketplaces.

**Official marketplace:**
- URL: https://claude.code/plugins (example from docs)
- Searchable by keywords from plugin.json
- Automatic version management and updates
- User ratings and reviews
- Installation via `claude plugin install plugin-name`

**Publishing to marketplace:**
1. Create plugin with valid plugin.json manifest
2. Test plugin locally
3. Push to Git repository (public or private)
4. Submit to marketplace via CLI: `claude plugin publish`
5. Marketplace validates manifest and structure
6. Plugin becomes available for installation

**Third-party marketplaces:**
- Organizations can host private plugin registries
- Configure registry URL in settings.json
- Same installation commands work with custom registries

**Direct distribution:**
**Verified:** [MOSTLY VERIFIED on 2026-03-05 - Development workflow confirmed; some CLI flags not documented]
- Share Git repository URL
- Package as tarball for offline distribution
- Document installation command in plugin README

---

## FINDING-2026-03-04-103: Plugin Development Workflow

**Note:** See [supplementary investigation on installation sources](claude-config-plugins-supplementary-sources.md#4-installation-sources-git-urls-and-tarballs) for evidence that the recommended local testing approach uses `--plugin-dir` flag, not persistent local installation.

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)

**What:**
Recommended workflow for developing and testing plugins locally before distribution.

**Development steps:**

1. **Create plugin structure:**
````bash
mkdir my-plugin
cd my-plugin
mkdir -p .claude-plugin skills agents hooks
````

2. **Create plugin.json manifest:**
````bash
cat > .claude-plugin/plugin.json <<EOF
{
  "name": "my-plugin",
  "version": "0.1.0",
  "description": "My custom plugin",
  "author": "Your Name"
}
EOF
````

3. **Add components (skills, agents, hooks):**
- Create skill directories in `skills/`
- Create agent files in `agents/`
- Create hook files in `hooks/`

4. **Test locally:**
````bash
# Install plugin from local path
claude plugin install /path/to/my-plugin --project

# Test components
/my-plugin:my-skill

# View installed plugin
claude plugin list
````

5. **Iterate and update:**
````bash
# Make changes to plugin
# Update version in plugin.json
# Reinstall to test changes
claude plugin install /path/to/my-plugin --project --force
````

6. **Publish:**
````bash
# Push to Git repository
git init
git add .
git commit -m "Initial plugin version"
git remote add origin https://github.com/user/my-plugin.git
git push -u origin main
**Verified:** [PARTIALLY VERIFIED on 2026-03-05 - Standard hooks confirmed; PluginEnabled/Disabled/Updated events not documented]

# Submit to marketplace
claude plugin publish
````

---

## FINDING-2026-03-04-104: Plugin Hooks and Lifecycle Events

**Note:** See [supplementary investigation on plugin lifecycle events](claude-config-plugins-supplementary-sources.md#2-plugin-lifecycle-events) for evidence that `PluginEnabled`, `PluginDisabled`, and `PluginUpdated` events are a feature request (GitHub Issue #11240), not currently implemented.

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins support same hook events as local configurations, scoped to plugin namespace.

**Hook event support:**
- All 16 standard hook events available (SessionStart, UserPromptSubmit, PreToolUse, PostToolUse, etc.)
- Hooks in plugin apply only when plugin enabled
- Hook commands can reference plugin files via `${CLAUDE_PLUGIN_ROOT}`
- Multiple plugins can register hooks for same event (all execute)

**Plugin-specific hook events:**
- `PluginEnabled`: Fires when plugin is enabled
- `PluginDisabled`: Fires when plugin is disabled
- `PluginUpdated`: Fires after plugin is updated to new version

**Example plugin hook:**
````yaml
---
name: setup-environment
event: SessionStart
---

# Setup Environment Hook

Initialize plugin environment on session start:

command: "${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"
````

**Verified:** [PARTIALLY VERIFIED on 2026-03-05 - Semantic versioning confirmed; dependency management not documented]
**Use cases:**
- Initialize plugin environment on session start
- Validate prerequisites when plugin enabled
- Cleanup resources when plugin disabled
- Run setup scripts after plugin updates

---

## FINDING-2026-03-04-105: Plugin Versioning and Updates

**Note:** See [supplementary investigation on manifest dependencies](claude-config-plugins-supplementary-sources.md#1-plugin-manifest-dependencies) for evidence that dependency version constraints are a feature request (GitHub Issues #9444, #27113), not currently implemented. Also see [CLI commands investigation](claude-config-plugins-supplementary-sources.md#3-cli-commands-claude-plugin-publish-and-claude-plugin-outdated) for evidence that `claude plugin outdated` command does not exist.

**Source:** [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)

**What:**
Plugins use semantic versioning with automatic update detection and management.

**Version format:**
- Semantic versioning: `MAJOR.MINOR.PATCH` (e.g., "1.2.3")
- Specified in plugin.json `version` field
- MAJOR: Breaking changes
- MINOR: New features, backward compatible
- PATCH: Bug fixes

**Update detection:**
````bash
# Check for updates
claude plugin outdated

# Update specific plugin
claude plugin update plugin-name

# Update all plugins
claude plugin update --all
````

**Update behavior:**
- CLI checks marketplace for newer versions
- Updates respect dependency constraints
- Breaking changes (MAJOR version) require explicit confirmation
- Plugin hooks can run post-update setup via `PluginUpdated` event

**Version constraints in dependencies:**
````json
{
  "dependencies": {
**Verified:** [PARTIALLY VERIFIED on 2026-03-05 - Permission model confirmed; specific security guidelines not documented]
    "base-plugin": "^1.0.0",      // Compatible with 1.x.x
    "utils-plugin": "~2.1.0",     // Compatible with 2.1.x
    "required-plugin": ">=3.0.0"  // At least 3.0.0
  }
}
````

---

## FINDING-2026-03-04-106: Plugin Security and Permissions

**Source:** [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

**What:**
Plugins run with same permission model as local configurations but with additional security considerations.

**Permission model:**
- Plugin components inherit Claude Code permission settings
- Skills can specify `allowed-tools` in frontmatter
- Agents can specify `tools` restrictions
- Hooks execute with user permissions

**Security considerations:**

**MUST verify before installing:**
- Plugin source and author reputation
- Plugin permissions and tool access
- Code review if security-critical
- Dependencies and their sources

**MUST NOT:**
- Install untrusted plugins with hook access
- Install plugins requesting unnecessary tool permissions
- Skip review of plugin code if used for sensitive work
- Enable plugins that modify security-critical hooks (PreToolUse with permission control)

**Marketplace security:**
- Official marketplace validates manifest structure
- User reviews and ratings indicate trust
- Report malicious plugins to marketplace administrators

**Best practices:**
- Install plugins at project scope (`./.claude/plugins/`) for team review
- Review plugin changes before updating
- Disable unused plugins to reduce attack surface
- Use managed policy plugins for organization-wide verified plugins

---

## Notes

All 13 findings verified on 2026-03-05 against official Claude Code documentation. Results:
- 5 fully verified
- 4 mostly verified
- 4 partially verified (some claimed features not in current documentation)

**Key discrepancies identified:**
- Manifest fields `dependencies`, `peerDependencies`, `claudeVersion`, `platforms` not documented
- Plugin lifecycle events (`PluginEnabled`, `PluginDisabled`, `PluginUpdated`) not documented
- Dependency management and version constraints not documented
- Some CLI commands (`claude plugin publish`, `claude plugin outdated`) not documented
- Some installation sources (Git URL, tarball) not documented

**Sources:**
- [Plugins - Claude Code Docs](https://code.claude.com/docs/en/plugins)
- [Plugins Reference - Claude Code Docs](https://code.claude.com/docs/en/plugins-reference)

Plugins are the native distribution mechanism for Claude Code customizations, enabling sharing of skills, subagents, hooks, and server integrations across teams and the community.
