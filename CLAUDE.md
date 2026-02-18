# CLAUDE.md

## Working Environment

You are working in a VS Code DevContainer with Azure Foundry integration.

## Azure Foundry Model Configuration

**CRITICAL: Always use per-user model name prefixes for this Azure tenant.**

When referencing models, you MUST use these exact names:
- Primary model: `mnorr001-claude-sonnet-4-5` (NOT `claude-sonnet-4-5`)
- Fast model: `mnorr001-claude-haiku-4-5` (NOT `claude-haiku-4-5`)

**Environment variables you can reference:**
- `ANTHROPIC_FOUNDRY_RESOURCE` - Azure tenant: `danie-me7ym8k8-eastus2`
- `ANTHROPIC_FOUNDRY_API_KEY` - Authentication key
- `ANTHROPIC_DEFAULT_SONNET_MODEL` - Primary model name with user prefix
- `ANTHROPIC_DEFAULT_HAIKU_MODEL` - Fast model for web operations

**DevContainer configuration:**
- Environment variables forwarded from host to container
- Zscaler certificate handling configured for corporate proxy
- Git config mounted from host `~/.gitconfig`

See @.devcontainer/devcontainer.json for details.

## Git Workflow

**Remote:** You are connected to an Azure DevOps git repository

**Branch:** Main branch is `main`

**Authentication:**git is pre-configured via mounted host credentials.

## Development Tools

Available tools:
- Claude Code extension (`anthropic.claude-code`)
- Git with subtree support
- Standard Linux utilities (curl, wget, jq)

**Network:** Zscaler corporate proxy certificate injected at build time.

## Common Pitfalls

**MUST avoid:**
1. Using generic model names without per-user prefix
2. Forgetting to rebuild container after changing `.devcontainer/.env` or `devcontainer.json`
3. Abbreviating or summarizing rules when copying them to other files
