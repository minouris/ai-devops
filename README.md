# Claude Code DevContainer Template for MSD

A template repository providing a pre-configured VS Code DevContainer with Claude Code integration for MSD employees using Azure Anthropic Foundry models.

> **⚠️ NOTICE: This template is still under active development and is not yet production ready.**
>
> Features, configuration, and documentation are subject to change. Please report any issues or suggestions to the template maintainers.

## Overview

This template provides:
- **DevContainer environment** with Claude Code extension pre-installed
- **Azure Foundry integration** configured for MSD's Azure tenant
- **Zscaler certificate handling** for corporate proxy
- **Standard rules** for Claude Code behavior and documentation practices
- **Git configuration** with Azure DevOps integration
- **Upstream configuration** via git subtree from [minouris/ai-devops](https://github.com/minouris/ai-devops)

## Prerequisites

Before cloning and using this template, ensure you have:

1. **VS Code** with the Dev Containers extension (should be bundled with up-to-date VS Code)
2. **Docker Desktop OR Docker Engine in WSL** (WSL is preferred)
3. **Azure Anthropic Foundry access** with your credentials:
   - Foundry resource name (e.g., `danie-me7ym8k8-eastus2`)
   - Foundry base URL
   - API key
   - Your personalized model names (e.g., `mnorr001-claude-sonnet-4-5`)
4. **Zscaler Root CA certificate** (or your corporate certificate) - you'll need to adjust the path in [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) to match your certificate location
5. **Git credentials configured in WSL** at `~/.gitconfig` (automatically mounted)
   - **Windows users:** If not using WSL, you'll need to adjust the mount path in [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) to point to your Windows gitconfig (typically `C:\Users\<user>\.gitconfig`)

## Setup Instructions

**CRITICAL: You must create the `.env` file BEFORE opening the DevContainer.**

### Step 1: Clone This Template

```bash
git clone <your-new-repo-url>
cd <your-new-repo>
```

### Step 2: Create Environment File

Copy the example environment file and fill in your credentials:

```bash
cp .devcontainer/.env.example .devcontainer/.env
```

### Step 3: Configure Your Credentials

Edit [.devcontainer/.env](.devcontainer/.env) and add your values:

```bash
# Your Anthropic Foundry Resource Name
ANTHROPIC_FOUNDRY_RESOURCE=your-resource-name-here

# Your Anthropic Foundry Base URL
ANTHROPIC_FOUNDRY_BASE_URL=https://your-resource-name.region.services.ai.azure.com/anthropic

# Your Anthropic Foundry API Key
ANTHROPIC_FOUNDRY_API_KEY=your-api-key-here

# Your default Sonnet model name (with your user prefix)
ANTHROPIC_DEFAULT_SONNET_MODEL=yourname-claude-sonnet-4-5

# Your default Haiku model name (with your user prefix)
ANTHROPIC_DEFAULT_HAIKU_MODEL=yourname-claude-haiku-4-5

# Your Zscaler Root CA certificate path
ZSCALER_ROOT_CA=/etc/ssl/certs/Zscaler_Root_CA.pem
```

**Important:** Model names in the Azure tenant require per-user prefixes. Do not use generic names like `claude-sonnet-4-5`.

### Step 4: Configure Git Credentials for Azure DevOps

To prevent Git credential popups when VS Code polls Azure DevOps, configure Git to cache credentials and use the full URL path:

```bash
git config --global credential.https://dev.azure.com.helper cache --timeout=3600
git config --global credential.https://dev.azure.com.useHttpPath true
```

**Why this is needed:**
- According to the [official Git documentation](https://git-scm.com/docs/gitcredentials), `useHttpPath = true` is required for Azure DevOps because different organizations/projects share the same `dev.azure.com` hostname
- The credential helper caches your credentials in memory for 1 hour (3600 seconds) to prevent repeated authentication prompts

**Alternative:** For persistent credential storage (plaintext on disk), use `store` instead of `cache`:
```bash
git config --global credential.https://dev.azure.com.helper store
git config --global credential.https://dev.azure.com.useHttpPath true
```

See [Git credential documentation](https://git-scm.com/docs/git-credential-cache) and [Azure DevOps credential setup guide](https://learn.microsoft.com/en-us/azure/devops/repos/git/set-up-credential-managers) for more details.

### Step 5: Open in DevContainer

1. Open the repository in VS Code
2. When prompted, click "Reopen in Container"
3. Alternatively, use the Command Palette: `Dev Containers: Reopen in Container`

The container will build automatically, injecting the Zscaler certificate and configuring Claude Code.

## What's Included

### Repository Structure with Git Subtree

This DevContainer template integrates shared configuration from the upstream [minouris/ai-devops](https://github.com/minouris/ai-devops) repository using git subtree:

- **`.devcontainer/.claude/`** - Shared Claude Code rules and settings (from `minouris/ai-devops/release/claude`)

#### Updating Shared Configuration

To pull the latest shared configuration from upstream (for maintainers):

```bash
# Add upstream remote (one-time setup)
git remote add ai-devops https://github.com/minouris/ai-devops

# Pull updates from upstream release/claude
git subtree pull --prefix .devcontainer/.claude ai-devops main --squash
```

**Note:** Template users receive configuration updates when pulling from the template repository. Only template maintainers need to pull from upstream.

#### Design Documents and Research

Design documentation, research notes, and project planning are maintained in the upstream repository: [minouris/ai-devops](https://github.com/minouris/ai-devops)

### DevContainer Configuration

- **Base image:** Ubuntu with Docker-in-Docker support
- **Extensions:** Claude Code (`anthropic.claude-code`)
- **Network:** Zscaler corporate proxy certificate injected at build time
- **Template File Organization:**
  - Core template docs (README.md, CLAUDE.md) at root for easy visibility and customization
  - Shared infrastructure (.claude rules) in `.devcontainer/`, mounted to root
  - Keeps template clean while allowing project-specific customization
- **Mounts:**
  - `~/.gitconfig` for git credentials
  - `.devcontainer/.claude/` → `/workspaces/<project>/.claude/` (shared Claude Code rules)
  - `.devcontainer/.claude-data/` → `/home/vscode/.claude` (conversation history)
    - Each project clone maintains its own isolated conversation history and settings
    - Directory is automatically created by Docker on first container build
    - Excluded from git via `.gitignore`

See [devcontainer.json](devcontainer.json) for full configuration.

### Claude Code Rules

Located in [.claude/rules/](.claude/rules/) (mounted from `.devcontainer/.claude/rules/`), these rules customize Claude Code's behavior:

#### [documentation-first.md](.claude/rules/documentation-first.md)
- Requires consulting official documentation before answering queries
- Mandates citation of sources in all responses
- Prohibits speculation or assumptions without verification
- Establishes documentation source priority hierarchy

#### [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
- Enforces direct, imperative language in instruction files
- Requires second-person "you" addressing the AI
- Prohibits third-person documentation style
- Balances brevity with completeness to prevent ambiguity

#### [rule-copying.md](.claude/rules/rule-copying.md)
- Requires verbatim copying of rules without abbreviation
- Prevents summarization or paraphrasing of directives
- Ensures anti-hallucination directives persist in AI-executed files

#### [documentation-standards.md](.claude/rules/documentation-standards.md)
- Requires UK English spelling and grammar
- Prohibits marketing language, buzzwords, and cultural idioms
- Enforces factual, technical tone
- Requires proper heading hierarchy (not bold text as headings)

#### [markdown-formatting.md](.claude/rules/markdown-formatting.md)
- Requires quad-backticks for nested code blocks
- Enforces lower-snake-case filename convention
- Specifies language identifiers for code blocks

#### [mermaid-diagrams.md](.claude/rules/mermaid-diagrams.md)
- Requires Mermaid syntax for all diagrams (not ASCII art)
- Enforces top-to-bottom layout by default
- Provides hierarchical colour schemes for nested structures
- Limits diagram complexity (max 15-20 nodes)

#### [rule-embedding.md](.claude/rules/rule-embedding.md)
- Governs selective rule embedding in skills and agents
- Prevents context flooding by embedding only relevant rules
- Provides rule selection matrix by task type
- Ensures complete sections embedded (no abbreviation)

#### [document-structure.md](.claude/rules/document-structure.md)
- Requires table of contents after H1 heading
- Mandates "Back to top" links after each H2 section
- Specifies directory landing page requirements
- Applies to all human-readable documentation

#### [document-navigation.md](.claude/rules/document-navigation.md)
- Requires header and footer navigation for document series
- Specifies Previous/Parent/Next link format
- Mandates "See Also" section for related documents
- Applies when documents are part of a logical sequence


### Project Instructions

[CLAUDE.md](CLAUDE.md) provides environment-specific instructions for Claude Code:
- Azure Foundry model naming conventions
- Git workflow with Azure DevOps
- Development tools available in the container
- Common pitfalls to avoid
- **Customize this file** for your specific project needs

## Project Structure

**Physical structure (in repository):**
```
.
├── .devcontainer/
│   ├── .claude/                  # → Git subtree from minouris/ai-devops/release/claude
│   │   ├── rules/                # Claude Code rules
│   │   │   ├── documentation-first.md
│   │   │   ├── ai-targeted-language.md
│   │   │   ├── rule-copying.md
│   │   │   ├── documentation-standards.md
│   │   │   ├── markdown-formatting.md
│   │   │   ├── mermaid-diagrams.md
│   │   │   ├── rule-embedding.md
│   │   │   ├── document-structure.md
│   │   │   └── document-navigation.md
│   │   ├── agents/               # Agent definitions
│   │   ├── commands/             # Custom commands
│   │   └── settings.local.json   # Local Claude Code settings
│   ├── .claude-data/             # Workspace conversation data (gitignored, auto-created)
│   ├── Dockerfile                # Container build configuration
│   ├── devcontainer.json         # VS Code DevContainer settings with mounts
│   ├── .env.example              # Template for environment variables
│   ├── .env                      # Your credentials (gitignored)
│   └── README.md                 # DevContainer-specific documentation
├── .gitignore                    # Git ignore rules
├── CLAUDE.md                     # Claude Code project instructions (customize per-project)
├── README.md                     # This file - template documentation
└── [Your project files here]     # Add your actual project files in the root
```

**How it appears inside the container:**
```
/workspaces/your-project/
├── .claude/                      # ← Mounted from .devcontainer/.claude/
├── CLAUDE.md                     # Project-specific instructions (edit as needed)
├── README.md                     # Template documentation
├── .devcontainer/                # Template infrastructure
└── [Your project files]          # Your actual project files
```

**Benefits of this structure:**
- `README.md` and `CLAUDE.md` are immediately visible and easily customizable
- Shared rules and instructions in `.devcontainer/` provide consistency
- Template infrastructure stays organized and separate from project code

## Usage

Once the DevContainer is running:

1. **Open Claude Code:** Use the Command Palette (`Cmd/Ctrl+Shift+P`) and select "Claude Code: Open"
2. **Start a conversation:** Ask Claude Code to help with your software development tasks
3. **Claude Code will automatically:**
   - Use your Azure Foundry models with proper prefixes
   - Follow the documentation-first approach
   - Apply AI-targeted language standards
   - Reference official sources with citations

## Customization

### Adding Rules

**Note:** A formal process for contributing rules will be documented in a future update.

Rules should be contributed via pull request to the upstream template repository, not added directly to child projects. This ensures all MSD employees benefit from improved rules.

For now, to propose a new rule:
1. Create a feature branch in the template repository
2. Add your rule file to [.devcontainer/.claude/rules/](.claude/rules/)
3. Follow the AI-targeted language standards from [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
4. Submit a pull request for review

_Detailed contribution guidelines will be added here once the formal process is established._

### Modifying Model Configuration

Edit [.devcontainer/.env](.devcontainer/.env) to change model names or Foundry settings. You must rebuild the container after changes:

```bash
# From VS Code Command Palette
Dev Containers: Rebuild Container
```

## Troubleshooting

### Claude Code Not Connecting

1. Verify [.devcontainer/.env](.devcontainer/.env) contains correct credentials
2. Check that model names include your user prefix
3. Rebuild the container: `Dev Containers: Rebuild Container`

### Certificate Errors

1. Verify your corporate certificate exists at the path specified in `.env`
2. Check that the certificate path in [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) matches your certificate location
3. Rebuild the container to re-inject the certificate

### Git Authentication Issues

If you're experiencing repeated credential prompts:

1. Ensure you completed [Step 4: Configure Git Credentials for Azure DevOps](#step-4-configure-git-credentials-for-azure-devops) on your host machine
2. **WSL users:** Verify `~/.gitconfig` exists in your WSL environment with git credentials configured
3. **Windows users:** Check that your gitconfig path in [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) points to your Windows gitconfig (e.g., `C:\Users\<user>\.gitconfig`)
4. The DevContainer mounts your host git configuration automatically, so changes must be made on the host

## Contributing

This is a template repository for MSD employees. To contribute improvements:

1. Create a feature branch
2. Make your changes
3. Test in a DevContainer
4. Submit a pull request to the Azure DevOps repository

## Support

For issues or questions:
- Check [README.md](README.md) for DevContainer-specific help
- Contact your team's Claude Code administrator

## License

Internal MSD template repository. Not for external distribution.
