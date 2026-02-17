# Azure DevOps CLI Research

Research document for Azure DevOps CLI tooling and integration with the MSD Claude Code template.

## Research Questions

### Azure DevOps CLI

1. **What is the official Azure DevOps CLI equivalent to GitHub CLI?**
   - Azure DevOps Extension for Azure CLI (`az devops`)
   - Requires base Azure CLI installation
   - Extension name: `azure-devops`

2. **What are the key differences between GitHub CLI (`gh`) and Azure DevOps CLI (`az devops`)?**
   - Azure DevOps CLI is an extension to Azure CLI, not a standalone tool
   - Uses `az` prefix for all commands
   - Only supports Azure DevOps Services (cloud), not Server (on-premises)

3. **Should we include Azure CLI + DevOps extension in the DevContainer?** ✅ ANSWERED
   - ✅ Use official DevContainer feature: `ghcr.io/devcontainers/features/azure-cli:1`
   - ✅ Include `azure-devops` extension via `extensions` option
   - TBD: Evaluate specific use cases for MSD employees
   - TBD: Consider enabling by default or documenting as optional

4. **What authentication methods does Azure DevOps CLI support?** ✅ ANSWERED
   - ✅ Interactive login (`az devops login`)
   - ✅ PAT (Personal Access Token) via pipe
   - ✅ PAT via environment variable (`AZURE_DEVOPS_EXT_PAT`)
   - ✅ NOT supported: Service principals, Managed identities
   - ✅ Recommendation: Use Microsoft Entra tokens over PATs for security

5. **What are the most common Azure DevOps CLI operations for development workflows?**
   - TBD: PR creation and management (`az repos pr`)
   - TBD: Work item management (`az boards`)
   - TBD: Pipeline operations (`az pipelines`)
   - TBD: Repository operations (`az repos`)

6. **How should authentication be configured for DevContainer usage?**
   - TBD: Should PAT be in `.env` file?
   - TBD: Should we set `AZURE_DEVOPS_EXT_PAT` in container environment?
   - TBD: What default organization/project should be configured?
   - TBD: Security considerations for PAT storage

### Alternative Tools

1. **doing CLI**
   - Third-party tool from ING Bank
   - Provides GitHub-like workflow for Azure DevOps
   - URL: https://ing-bank.github.io/doing-cli/
   - TBD: Evaluate feature set vs official CLI
   - TBD: Assess maintenance and support status

## Findings

### Azure CLI Installation on Ubuntu

**System Requirements:**
- Tested on Ubuntu 22.04 (Jammy Jellyfish) and 24.04 (Noble Numbat)
- Supports both x86_64 and ARM64 architectures (ARM64 from v2.46.0+)
- Current version: 2.83.0 (as of January 2026)

**Installation Method 1: One Command (Recommended)**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Installation Method 2: Step-by-Step**
```bash
# 1. Update and install prerequisites
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# 2. Download and install Microsoft signing key
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

# 3. Add Azure CLI repository
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources

# 4. Install Azure CLI
sudo apt-get update
sudo apt-get install azure-cli
```

**Verify Installation:**
```bash
az --version
```

**Update Azure CLI:**
```bash
# Using built-in upgrade command (v2.11.0+)
az upgrade

# Or using apt-get
sudo apt-get update && sudo apt-get install --only-upgrade -y azure-cli
```

### DevContainer Feature Installation (RECOMMENDED)

**Official Feature ID:** `ghcr.io/devcontainers/features/azure-cli:1`
**Latest Version:** 1.2.9
**Maintainer:** Dev Container Spec Maintainers

**Available Options:**
- `version` - Azure CLI version (default: "latest")
- `extensions` - Comma-separated list of Azure CLI extensions to install
- `installBicep` - Install Azure Bicep (boolean, default: false)
- `bicepVersion` - Bicep version (default: "latest")
- `installUsingPython` - Use Python instead of pipx (boolean, default: false)

**Basic Configuration:**
```json
{
  "features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {}
  }
}
```

**With Azure DevOps Extension:**
```json
{
  "features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {
      "version": "latest",
      "extensions": "azure-devops"
    }
  }
}
```

**With Multiple Extensions:**
```json
{
  "features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {
      "version": "latest",
      "extensions": "azure-devops,aks-preview,containerapp",
      "installBicep": false
    }
  }
}
```

**Advantages over Manual Installation:**
- ✅ Maintained by official Dev Container Spec team
- ✅ Automatic version management
- ✅ Extensions installed during container build
- ✅ Cleaner configuration (no Dockerfile modifications needed)
- ✅ Declarative approach in devcontainer.json
- ✅ Misspelled extension names are skipped (doesn't break build)

### Manual Azure DevOps Extension Installation

**Prerequisites:**
- Azure CLI v2.0.69 or later

**Installation:**
```bash
# Add the extension
az extension add --name azure-devops

# Or update if already installed
az extension update --name azure-devops

# Verify installation
az extension list
az extension show --name azure-devops
```

**Note:** Manual installation is only needed if not using the DevContainer feature approach.

### Installation Method Comparison

| Aspect | DevContainer Feature | Manual Installation |
|--------|---------------------|---------------------|
| Configuration | In `devcontainer.json` features | In Dockerfile with RUN commands |
| Maintainability | Official spec maintainers | User maintains |
| Extension installation | Via `extensions` option | Separate `az extension add` command |
| Version management | Via `version` option | Manual version pinning in apt |
| Build failure handling | Misspelled extensions skipped | Build fails on errors |
| **Recommendation** | ✅ **Use this approach** | ❌ Not recommended |

**Command Groups:**
- `az devops` - Organization-level operations
- `az pipelines` - Pipeline management
- `az boards` - Work item and board management
- `az repos` - Repository operations (PR, branch, etc.)
- `az artifacts` - Artifact management

**Available Subgroups:**
- `admin` – Administration operations
- `extension` – Extensions management
- `project` – Team projects
- `security` – Security operations
- `service-endpoint` – Service connections
- `team` – Team management
- `user` – User management
- `wiki` – Wiki management

**Limitations:**
- Only works with Azure DevOps Services (cloud)
- Does NOT support Azure DevOps Server (on-premises)
- Does NOT support service principals or managed identities (use REST APIs instead)

### Authentication Methods

**Method 1: Interactive Sign-In**
```bash
az devops login --organization https://dev.azure.com/contoso
# Prompts for PAT token
```

**Method 2: Piped Authentication (Non-Interactive)**
```bash
# From pipeline variable
echo "$(System.AccessToken)" | az devops login --organization https://dev.azure.com/contoso/

# From file
cat my_pat_token.txt | az devops login --organization https://dev.azure.com/contoso/
```

**Method 3: Environment Variable (Recommended for Automation)**
```bash
# Linux/macOS
export AZURE_DEVOPS_EXT_PAT=xxxxxxxxxx

# Windows PowerShell
$env:AZURE_DEVOPS_EXT_PAT = 'xxxxxxxxxx'
```

**Note:** When `AZURE_DEVOPS_EXT_PAT` is set, all `az devops` commands automatically use it for authentication if no prior `az login` or `az devops login` has been performed.

**Configuration - Set Default Organization & Project:**
```bash
az devops configure --defaults organization=https://dev.azure.com/contoso project=ContosoWebApp
```

**Security Recommendation:**
Microsoft recommends using Microsoft Entra tokens instead of PATs when possible for enhanced security.

### Basic Usage Examples

**View help:**
```bash
az devops --help
az repos --help
az pipelines --help
```

**Open items in browser:**
```bash
# Opens build in browser
az pipelines build show --id 1 --open
```

**Repository operations:**
```bash
# List repositories
az repos list

# Create a pull request
az repos pr create --title "My PR" --source-branch feature/my-feature
```

**Work items:**
```bash
# Query work items
az boards query --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.State] = 'Active'"
```

**Pipelines:**
```bash
# List pipelines
az pipelines list

# Run a pipeline
az pipelines run --name MyPipeline
```

### Integration Points

**Potential integrations with DevContainer:**
- Git operations in container (already supported via mounted `.gitconfig`)
- Claude Code workflows for:
  - Creating PRs after completing code changes
  - Querying work items for context
  - Checking pipeline status
  - Managing branches and repositories

**Example Claude Code workflow:**
1. User asks Claude Code to implement a feature
2. Claude Code makes changes
3. Claude Code commits changes (existing git support)
4. Claude Code creates PR via `az repos pr create` (potential future integration)
5. Claude Code links work item to PR (potential future integration)

## Decisions

### Pending

**Installation:**
- [x] ~~Include Azure CLI + DevOps extension in DevContainer Dockerfile?~~ Use DevContainer feature instead
- [x] ~~Use one-command install vs step-by-step in Dockerfile?~~ Use DevContainer feature `ghcr.io/devcontainers/features/azure-cli:1`
- [ ] Pin to specific Azure CLI version or use latest? (Can specify via feature `version` option)

**Authentication:**
- [ ] Add `AZURE_DEVOPS_EXT_PAT` to `.env.example`?
- [ ] Add Azure DevOps organization URL to `.env.example`?
- [ ] Add default project name to `.env.example`?
- [ ] Document PAT creation process in README?
- [ ] Add PAT scope recommendations?

**Configuration:**
- [ ] Auto-configure default organization/project in container?
- [ ] Should we provide configured aliases or wrapper scripts?
- [ ] Document Azure DevOps CLI usage patterns in template?

**Use Cases to Support:**
- [ ] What specific workflows do MSD employees need?
  - PR creation and management?
  - Work item queries?
  - Pipeline triggers?
  - Repository operations?

### Made

- ✅ Authentication method: Environment variable (`AZURE_DEVOPS_EXT_PAT`) is recommended for automation/container scenarios
- ✅ Installation method: Use official DevContainer feature `ghcr.io/devcontainers/features/azure-cli:1` instead of manual installation
- ✅ Extension installation: Use `extensions` option in feature configuration to install `azure-devops` extension automatically

## References

### Official Documentation

**Azure CLI Installation:**
- [Install the Azure CLI on Linux - Microsoft Learn](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest)
- [How to install the Azure CLI - Microsoft Learn](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Install Azure CLI on Ubuntu - Ubuntu Documentation](https://documentation.ubuntu.com/azure/azure-how-to/instances/install-azure-cli/)

**Azure DevOps CLI:**
- [Get Started with Azure DevOps CLI - Microsoft Learn](https://learn.microsoft.com/en-us/azure/devops/cli/?view=azure-devops)
- [Azure DevOps Extension for Azure CLI - GitHub](https://github.com/Azure/azure-devops-cli-extension)
- [Sign in with a Personal Access Token (PAT) - Microsoft Learn](https://learn.microsoft.com/en-us/azure/devops/cli/log-in-via-pat?view=azure-devops)
- [Use Personal Access Tokens - Microsoft Learn](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops)
- [Manage Azure CLI Extensions - Microsoft Learn](https://learn.microsoft.com/en-us/cli/azure/azure-cli-extensions-overview?view=azure-cli-latest)

**DevContainer Features:**
- [Azure CLI Feature - Dev Containers](https://containers.dev/features)
- [Azure CLI Feature Source - GitHub](https://github.com/devcontainers/features/tree/main/src/azure-cli)
- [Re-visiting Dev Container Features - PAUL'S BLOG](https://paulyu.dev/article/revisiting-devcontainer-features/)

**Alternative Tools:**
- [doing CLI for Azure DevOps](https://ing-bank.github.io/doing-cli/)

## Related Files

- None yet

## Notes

This research is being conducted to determine if Azure DevOps CLI tooling should be included in the MSD Claude Code DevContainer template, similar to how GitHub CLI was initially considered.
