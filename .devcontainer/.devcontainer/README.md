# Claude Code Dev Container

This dev container includes the Claude Code extension pre-configured with Anthropic Foundry settings.

## Setup

### Option 1: Using Environment Variables (Recommended for sharing)

1. Set environment variables on your host machine:
   ```bash
   export ANTHROPIC_FOUNDRY_API_KEY="your-api-key"
   export ANTHROPIC_DEFAULT_SONNET_MODEL="your-model-name"
   ```

2. Open the workspace in VS Code and reopen in the container

### Option 2: Using .env File (For local development)

1. Copy `.env.example` to `.env`:
   ```bash
   cp .devcontainer/.env.example .devcontainer/.env
   ```

2. Edit `.env` and add your credentials

3. Open the workspace in VS Code and reopen in the container

## Configuration

The container includes:
- Claude Code extension (`anthropic.claude-code`)
- Pre-configured Foundry settings
- Disabled login prompt
- Foundry resource: `danie-me7ym8k8-eastus2`
- Azure CLI with Azure DevOps extension
- Persistent Claude Code data storage

### Claude Code Data Persistence

Claude Code conversation history, todos, plans, and settings are automatically persisted to `.devcontainer/.claude-data/`.

**Benefits of workspace-local storage:**
- Each project clone maintains isolated conversation history and settings
- No cross-contamination between different projects
- Data persists across container rebuilds and restarts for that specific project
- Directory is automatically created by Docker on first container build
- Excluded from git via `.gitignore` to prevent accidental commits

**Note**: Each project workspace maintains its own separate Claude Code data. This is intentional to keep project contexts isolated.

### Template File Structure

Template infrastructure is organized to balance visibility with organization:

**Core template files (at repository root):**
- `README.md` - Template documentation (visible immediately)
- `CLAUDE.md` - Project instructions (customize per-project)

**Shared infrastructure (in `.devcontainer/`, mounted to root):**
```
.devcontainer/
├── .claude/               # Claude Code rules (mounted to root)
├── .claude-data/          # Conversation history (gitignored, auto-created)
├── README.md              # DevContainer-specific documentation
└── devcontainer.json      # Container configuration with mounts
```

**How it appears in the container:**
```
/workspaces/your-project/
├── README.md              # Template docs (at root)
├── CLAUDE.md              # Project instructions (at root, editable)
├── .claude/               # ← Mounted from .devcontainer/.claude/
├── .devcontainer/         # Template infrastructure
└── [Your project files]   # Your code here
```

**Benefits:**
- Important docs (README.md, CLAUDE.md) immediately visible and easily customizable
- Shared rules (.claude/) provide consistency across all projects using git subtree
- Template infrastructure stays organized in `.devcontainer/`

## Updating Shared Configuration from Upstream

The `.devcontainer/.claude/` directory is integrated from the upstream [minouris/ai-devops](https://github.com/minouris/ai-devops) repository using git subtree.

### For Template Users (Most Users)

Template users receive configuration updates when pulling from the template repository. No special action is required:

```bash
git pull origin main
```

Your `.devcontainer/.claude/` directory will automatically include any upstream updates that template maintainers have integrated.

### For Template Maintainers Only

If you maintain this template and need to pull the latest shared configuration from upstream:

```bash
# Add upstream remote (one-time setup)
git remote add ai-devops https://github.com/minouris/ai-devops

# Pull updates from upstream release/claude
git subtree pull --prefix .devcontainer/.claude ai-devops main --squash

# Commit and push the updates to the template repository
git push origin main
```

**Note:** Only template maintainers should pull from upstream. Regular users get updates by pulling from the template repository.

## Azure DevOps CLI Setup

The dev container includes Azure CLI with the Azure DevOps extension automatically installed for working with Azure Repos, Pipelines, and Work Items.

**Note:** The Azure DevOps extension is installed via `postCreateCommand` after the container starts. This ensures the `AZURE_CLI_DISABLE_CONNECTION_VERIFICATION` environment variable is available to bypass Zscaler certificate validation during installation. The extension will be ready to use once the container finishes starting.

### Prerequisites

You'll need a Personal Access Token (PAT) to authenticate with Azure DevOps CLI.

### Creating a Personal Access Token (PAT)

1. Navigate to your Azure DevOps organization (e.g., `https://dev.azure.com/your-organization`)
2. Click on **User Settings** (icon in top-right) > **Personal access tokens**
3. Click **+ New Token**
4. Configure your token:
   - **Name**: `DevContainer CLI Access` (or your preferred name)
   - **Organization**: Select your organization
   - **Expiration**: Choose appropriate expiration (90 days recommended for security)
   - **Scopes**: Select **Custom defined** and enable:
     - **Code**: Read & Write (for repository and PR operations)
     - **Work Items**: Read & Write (for work item queries)
     - **Build**: Read (for pipeline status)
     - **Release**: Read (for release information)
5. Click **Create**
6. **IMPORTANT**: Copy the token immediately - you won't be able to see it again!

### Configuring Authentication

1. Add your PAT to `.devcontainer/.env`:
   ```bash
   # Azure DevOps CLI Configuration
   AZURE_DEVOPS_EXT_PAT=your-actual-pat-token-here
   AZURE_DEVOPS_ORG_URL=https://dev.azure.com/your-organization
   AZURE_DEVOPS_PROJECT=your-project-name
   ```

2. Restart VS Code or reload the window to pick up the new environment variables

3. Verify authentication:
   ```bash
   az devops configure --defaults organization=$AZURE_DEVOPS_ORG_URL project=$AZURE_DEVOPS_PROJECT
   az devops project list
   ```

### Common Azure DevOps CLI Commands

```bash
# List repositories
az repos list

# Create a pull request
az repos pr create --title "My PR" --source-branch feature/my-feature --target-branch main

# List work items
az boards query --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.State] = 'Active'"

# List pipelines
az pipelines list

# View help for any command
az devops --help
az repos pr --help
```

### Security Notes

- **Never commit your PAT to git** - the `.env` file is already in `.gitignore`
- Use the minimum required scopes for your PAT
- Set an appropriate expiration date (90 days or less recommended)
- Rotate your PAT regularly
- Consider using Microsoft Entra tokens instead of PATs for enhanced security (see [Azure DevOps CLI documentation](https://learn.microsoft.com/en-us/azure/devops/cli/log-in-via-pat))
