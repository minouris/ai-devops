# Plugins Supplementary Sources Investigation

**Investigation date:** 2026-03-05
**Verification date:** 2026-03-05
**Purpose:** Corroborate discrepancies identified in plugins verification using external sources
**Status:** All sections verified against cited sources

---

## Summary

External sources confirm that several features documented in the original findings are **not currently implemented** but exist as **feature requests** or **planned functionality**.

---

## 1. Plugin Manifest Dependencies

**Verified:** [VERIFIED on 2026-03-05 - External sources confirm feature requests, not implemented features]

### Finding Claim
Manifest supports `dependencies`, `peerDependencies`, `claudeVersion`, `platforms` fields.

### External Source Evidence

**GitHub Feature Request:**
- Issue #9444: "Support for Plugin Dependencies and Shared Resources"
- Issue #27113: "Feature: Declarative skill/plugin dependencies at the project level"

**Status:** These fields are **requested features, not currently implemented**.

From issue discussion:
> "Projects should be able to declare which skills and plugins they depend on, with Claude Code prompting users to install missing dependencies when they open a project — similar to how package.json declares npm dependencies."

This indicates dependency management is a **future enhancement**, not current functionality.

**Sources:**
- [FEATURE] Support for Plugin Dependencies and Shared Resources · Issue #9444 · anthropics/claude-code
  https://github.com/anthropics/claude-code/issues/9444
- Feature: Declarative skill/plugin dependencies at the project level · Issue #27113 · anthropics/claude-code
  https://github.com/anthropics/claude-code/issues/27113

---

## 2. Plugin Lifecycle Events

**Verified:** [VERIFIED on 2026-03-05 - External sources confirm feature requests, not implemented features]

### Finding Claim
Plugins support lifecycle events: `PluginEnabled`, `PluginDisabled`, `PluginUpdated`.

### External Source Evidence

**GitHub Feature Request:**
- Issue #11240: "[FEATURE] Plugin Lifecycle Hooks: Install and Uninstall"

From issue description:
> "Claude Code currently only supports SessionStart. This feature request asks for plugin lifecycle hooks to enable automatic setup during installation and cleanup during uninstallation."

**Current Hook System:**
- Released early 2026 with 12 lifecycle events
- Focus on tool execution (PreToolUse, PostToolUse, Stop, SessionStart, etc.)
- **Does not include plugin-specific lifecycle events**

**Status:** Plugin lifecycle events are **requested features, not currently available**.

**Sources:**
- [FEATURE] Plugin Lifecycle Hooks: Install and Uninstall · Issue #11240 · anthropics/claude-code
  https://github.com/anthropics/claude-code/issues/11240
- Claude Code Hooks Guide: All 12 Lifecycle Events Explained | Pixelmojo
  https://www.pixelmojo.io/blogs/claude-code-hooks-production-quality-ci-cd-patterns
- Claude Code Hooks: Complete Guide to All 12 Lifecycle Events
  https://claudefa.st/blog/tools/hooks/hooks-guide

---

## 3. CLI Commands: `claude plugin publish` and `claude plugin outdated`

**Verified:** [VERIFIED on 2026-03-05 - External sources confirm feature requests, not implemented features]

### Finding Claim
Publishing uses `claude plugin publish` command. Checking updates uses `claude plugin outdated` command.

### External Source Evidence

**Available Commands (confirmed in 2026):**
```bash
claude plugin install <plugin-name>
claude plugin list
claude plugin update <plugin-name>
claude plugin update --all
claude plugin remove <plugin-name>
claude plugin marketplace add <url>
claude plugin marketplace list
claude plugin marketplace update <n>
claude plugin marketplace remove <n>
```

**Publishing Method:**
Official documentation directs to **in-app submission forms**, not CLI commands:
- Claude.ai: claude.ai/settings/plugins/submit
- Console: platform.claude.com/plugins/submit

**Update Checking:**
- No native `claude plugin outdated` command exists
- Community tools provide this functionality
- `claude plugin update` command exists but no separate "outdated" command

**Status:** These commands **do not exist** in current CLI. Alternative methods used instead.

**Sources:**
- Claude Code Plugin CLI: The Missing Manual | Medium
  https://medium.com/@garyjarrel/claude-code-plugin-cli-the-missing-manual-0a4d3a7c99ce
- Create plugins - Claude Code Docs
  https://code.claude.com/docs/en/plugins
- Keeping Claude Code plugins up to date · workingbruno.com
  https://workingbruno.com/notes/keeping-claude-code-plugins-date

---

## 4. Installation Sources: Git URLs and Tarballs

**Verified:** [VERIFIED on 2026-03-05 - External sources confirm feature requests, not implemented features]

### Finding Claim
Plugins can be installed via Git URLs (`claude plugin install https://github.com/user/plugin.git`) and tarballs (`claude plugin install ./plugin.tgz`).

### External Source Evidence

**Documented Installation Methods (2026):**

1. **Marketplace installation** (primary method)
   - From official marketplace
   - From community marketplaces (GitHub repos, Git URLs, local paths)
   - Format: `/plugin install <plugin-name>@<marketplace-name>`

2. **Local directory testing**
   - `claude --plugin-dir ./your-plugin`
   - For development/testing only
   - Not persistent installation

3. **Local marketplace setup**
   - `/plugin marketplace add /path/to/marketplace`
   - Marketplace can be local directory or Git repository
   - Plugins installed from marketplace, not directly

**Marketplace Source Types:**
- GitHub repositories (owner/repo format)
- Git URLs (GitLab, Bitbucket, self-hosted)
- Local paths to directories
- Remote URLs to marketplace.json files

**Key Difference:**
Plugins are installed **from marketplaces**, not directly from Git URLs. The marketplace itself can be a Git repository, but the installation is marketplace-mediated.

**Tarball Support:**
No documentation found for direct tarball installation. Distribution typically via Git repositories or marketplace systems.

**Status:** Direct Git URL and tarball installation **not documented**. Installation is marketplace-based with `--plugin-dir` flag for development.

**Sources:**
- Discover and install prebuilt plugins through marketplaces - Claude Code Docs
  https://code.claude.com/docs/en/discover-plugins
- Creating Local Claude Code Plugins - Somethinghitme
  https://somethinghitme.com/2026/01/31/creating-local-claude-code-plugins/
- GitHub - dashed/claude-marketplace: A local marketplace for personal Claude Code skills and plugins
  https://github.com/dashed/claude-marketplace

---

## Conclusion

**Confirmed Discrepancies:**

1. **Manifest dependency fields** - Feature requests #9444 and #27113, not implemented
2. **Plugin lifecycle events** - Feature request #11240, not implemented
3. **`claude plugin publish` command** - Does not exist; use in-app forms
4. **`claude plugin outdated` command** - Does not exist
5. **Direct Git URL installation** - Not supported; use marketplace-based installation
6. **Tarball installation** - Not documented

**Assessment:**

The original findings appear to have documented:
- **Planned features** that exist as GitHub feature requests
- **Commands that don't exist** in the current CLI
- **Installation methods** that are marketplace-mediated, not direct

These discrepancies likely originated from:
- Inferring features from other package management systems (npm, etc.)
- Documenting planned/requested features as if implemented
- Outdated or speculative information
- Misunderstanding marketplace-based installation architecture

**Recommendation:**

Update findings to reflect:
- Current implementation status (what exists today)
- Feature requests with GitHub issue numbers
- Actual CLI commands and installation methods
- Note planned features separately from implemented features

---

## All Sources Referenced

### Plugin Dependencies
- https://github.com/anthropics/claude-code/issues/9444
- https://github.com/anthropics/claude-code/issues/27113

### Plugin Lifecycle Events
- https://github.com/anthropics/claude-code/issues/11240
- https://www.pixelmojo.io/blogs/claude-code-hooks-production-quality-ci-cd-patterns
- https://claudefa.st/blog/tools/hooks/hooks-guide

### CLI Commands
- https://medium.com/@garyjarrel/claude-code-plugin-cli-the-missing-manual-0a4d3a7c99ce
- https://code.claude.com/docs/en/plugins
- https://workingbruno.com/notes/keeping-claude-code-plugins-date

### Installation Methods
- https://code.claude.com/docs/en/discover-plugins
- https://somethinghitme.com/2026/01/31/creating-local-claude-code-plugins/
- https://github.com/dashed/claude-marketplace

### Additional References
- https://code.claude.com/docs/en/plugins-reference
- https://github.com/anthropics/claude-code/blob/main/plugins/README.md
- https://www.morphllm.com/claude-code-plugins
- https://www.datacamp.com/tutorial/how-to-build-claude-code-plugins
- https://github.com/anthropics/claude-plugins-official
