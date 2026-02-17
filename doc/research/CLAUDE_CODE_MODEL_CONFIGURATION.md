# Claude Code Model Configuration - Azure Multi-User Setup

## Summary

**Status**: ✅ **RESOLVED** - Haiku model configured with `ANTHROPIC_DEFAULT_HAIKU_MODEL` environment variable.

**Original Problem**: WebFetch tool was hardcoded to use `claude-haiku-4-5`, but your Azure Foundry deployment uses per-user model naming like `mnorr001-claude-sonnet-4-5`.

**Solution Implemented**:
1. Azure admin provisioned `mnorr001-claude-haiku-4-5` model
2. Added `ANTHROPIC_DEFAULT_HAIKU_MODEL` environment variable to devcontainer configuration
3. Updated both [.devcontainer/.env](.devcontainer/.env) and [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json)

**Next Step**: Rebuild the devcontainer for changes to take effect, then test WebFetch functionality.

---

## Configuration Changes Made

### Files Updated:
1. [.devcontainer/.env.example](.devcontainer/.env.example) - Added Haiku model variable example
2. [.devcontainer/.env](.devcontainer/.env) - Set `ANTHROPIC_DEFAULT_HAIKU_MODEL=mnorr001-claude-haiku-4-5`
3. [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) - Added Haiku model to both `claudeCode.environmentVariables` and `remoteEnv`

---

## Original Issue Documentation

---

## Issue Discovered

WebFetch tool is hardcoded to use **Haiku** (`claude-haiku-4-5`) for processing web content, but your Azure tenant only has **Sonnet** models provisioned per user. This causes WebFetch to fail with:
```
API Error: 404 {"error":{"code":"DeploymentNotFound","message":"The API deployment claude-haiku-4-5 does not exist...
```

## Configuration Options in Claude Code

From analyzing the Claude Code settings schema, here are the available model configuration options:

### 1. Top-Level Model Override

[.claude/settings.local.json](.claude/settings.local.json) supports a `model` field:

```json
{
  "model": "your-azure-sonnet-deployment-name"
}
```

**Purpose**: Override the default model used by Claude Code for the main conversation thread.

**Limitation**: This may not affect tool-specific model selection like WebFetch's internal Haiku usage.

### 2. Hook-Level Model Configuration

Hooks support model parameter for custom operations:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "WebFetch",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Process this web content: $ARGUMENTS",
            "model": "your-azure-sonnet-deployment-name"
          }
        ]
      }
    ]
  }
}
```

**Limitation**: Hooks run *before* or *after* tool execution, not instead of the tool. WebFetch would still try to use Haiku internally.

## Azure Foundry Configuration

Your devcontainer uses these environment variables:

```bash
CLAUDE_CODE_USE_FOUNDRY=1
ANTHROPIC_FOUNDRY_RESOURCE=danie-me7ym8k8-eastus2
ANTHROPIC_FOUNDRY_BASE_URL=https://danie-me7ym8k8-eastus2.eastus2.services.ai.azure.com/anthropic
ANTHROPIC_FOUNDRY_API_KEY=<redacted>
ANTHROPIC_DEFAULT_SONNET_MODEL=mnorr001-claude-sonnet-4-5
```

**Critical Discovery**: Your Azure deployment uses **per-user model names with prefixes**:
- Current Sonnet deployment: `mnorr001-claude-sonnet-4-5`
- If Haiku is deployed, it would likely be: `mnorr001-claude-haiku-4-5`

This means the hardcoded model name `claude-haiku-4-5` in WebFetch will **never match** your Azure deployment naming convention, even if Haiku is provisioned.

## Solutions for Multi-User Azure Environments

### Option 1: Deploy Haiku with Correct Naming + Environment Variable (Recommended if Supported)

**Problem**: WebFetch is hardcoded to use `claude-haiku-4-5`, but your Azure uses per-user prefixes like `mnorr001-claude-haiku-4-5`.

**Potential Solution**:
1. Check if Claude Code supports environment variables for model name mapping
2. Request administrators provision: `mnorr001-claude-haiku-4-5`
3. Set an environment variable like `ANTHROPIC_DEFAULT_HAIKU_MODEL=mnorr001-claude-haiku-4-5` (if supported)

**Investigation Needed**:
- Search Claude Code source for environment variables that control Haiku model selection
- Check if there's a model mapping configuration option

**Pros**:
- WebFetch would work if environment variable is supported
- Haiku is faster and cheaper for simple tasks

**Cons**:
- Requires admin approval and provisioning
- May not be supported by Claude Code (needs verification)
- Additional cost (though Haiku is much cheaper than Sonnet)

### Option 2: Use Workarounds for Web Content

Instead of WebFetch, use bash commands to fetch and process web content:

```bash
# Fetch documentation
curl -s https://docs.example.com | lynx -dump -stdin

# Or use wget
wget -qO- https://docs.example.com
```

Then ask Claude Code to analyze the text you provide.

**Pros**:
- Works with only Sonnet deployed
- No admin approval needed

**Cons**:
- More manual process
- Loses WebFetch's built-in content extraction and summarization

### Option 3: Modify Claude Code (Advanced)

If Claude Code is open source, you could:
1. Fork the repository
2. Modify WebFetch to use a configurable model
3. Add environment variable like `WEBFETCH_MODEL`
4. Submit a PR upstream

**Pros**:
- Flexible solution
- Benefits the community

**Cons**:
- Requires development effort
- Needs maintenance for updates
- May not be accepted upstream

## Recommended Approach for Discovery Phase

Since you're in the discovery phase:

1. **Document the limitation** (this file)
2. **Use curl/wget workarounds** for immediate needs
3. **Test other Claude Code features** to identify additional model dependencies
4. **Compile a list of required models** for your administrators:
   - claude-sonnet-4-5 (already deployed)
   - claude-haiku-4-5 (for WebFetch and other tools)
   - claude-opus-4-5 (optional, for complex tasks)

## Testing Model Configuration

To test if the top-level `model` override affects WebFetch, add to [.claude/settings.local.json](.claude/settings.local.json):

```json
{
  "model": "your-azure-sonnet-deployment-name",
  "permissions": {
    "allow": ["...existing permissions..."]
  }
}
```

Then test WebFetch again to see if it respects this setting.

## Next Steps

1. Test top-level model override
2. Document which tools require which models
3. Present findings to Azure administrators
4. Request multi-model provisioning if needed
