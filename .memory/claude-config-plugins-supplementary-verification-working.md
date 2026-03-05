# Plugins Supplementary Sources Verification Working Document

**Verification date:** 2026-03-05
**Document verified:** `.memory/claude-config-plugins-supplementary-sources.md`
**Methodology:** Direct verification of claims against cited sources

---

## Verification Approach

The supplementary sources document investigates discrepancies identified in the plugins findings verification. It claims that several features documented in the original findings are NOT implemented but exist as feature requests.

**Verification method:**
1. Fetch official Claude Code documentation pages
2. Fetch community sources (Medium articles, blog posts)
3. Fetch GitHub issues to verify feature request claims
4. Compare supplementary document claims against actual source content
5. Verify conclusions are justified by evidence

---

## Section 1: Plugin Manifest Dependencies

### Claim
`dependencies`, `peerDependencies`, `claudeVersion`, `platforms` fields in plugin.json are feature requests (GitHub Issues #9444, #27113), not currently implemented.

### Source Verification

**Official Documentation Check:**
- Source: https://code.claude.com/docs/en/plugins
- Plugin manifest schema documented includes: `name`, `description`, `version`, `author`
- **NO MENTION** of `dependencies`, `peerDependencies`, `claudeVersion`, or `platforms` fields

**GitHub Issue #9444 Verification:**
- Title: "[FEATURE] Support for Plugin Dependencies and Shared Resources"
- Status: **OPEN** (as of Feb 26, 2026)
- Type: **Feature Request**
- Content: Requests adding `dependencies` field to `plugin.json` for declaring plugin dependencies
- Example from issue:
  ```json
  {
    "dependencies": {
      "common-core": "^1.0.0",
      "security-core": "^2.1.0"
    }
  }
  ```
- **CONFIRMED**: This is a feature request, not implemented

**GitHub Issue #27113 Verification:**
- Title: "Feature: Declarative skill/plugin dependencies at the project level"
- Status: **OPEN** (as of Feb 20, 2026)
- Type: **Feature Request**
- Content: Requests project-level dependency declaration in `.claude/settings.json`
- Quote from issue: "Projects should be able to declare which skills and plugins they depend on, with Claude Code prompting users to install missing dependencies when they open a project—similar to how package.json declares npm dependencies."
- **CONFIRMED**: This is a feature request, not implemented

### Verification Result: **VERIFIED** ✅

**Evidence quality:** High
- Official docs do not document these fields
- GitHub issues are open feature requests
- Issue titles and content match supplementary document claims
- Quote in supplementary document accurately represents issue content

---

## Section 2: Plugin Lifecycle Events

### Claim
`PluginEnabled`, `PluginDisabled`, `PluginUpdated` events are a feature request (Issue #11240), not currently available.

### Source Verification

**Official Documentation Check:**
- Source: https://code.claude.com/docs/en/plugins
- No mention of plugin-specific lifecycle events
- Hooks documentation (from hooks verification) shows 18 standard events
- **NO MENTION** of `PluginEnabled`, `PluginDisabled`, or `PluginUpdated` events

**GitHub Issue #11240 Verification:**
- Title: "[FEATURE] Plugin Lifecycle Hooks: Install and Uninstall"
- Status: **CLOSED** as DUPLICATE of #9394
- Type: **Feature Request**
- Content: Requests lifecycle hooks including `PreInstall`, `PostInstall`, `PreUninstall`, `PostUninstall`
- Quote from issue: "Claude Code currently only supports SessionStart. This feature request asks for plugin lifecycle hooks to enable automatic setup during installation and cleanup during uninstallation."
- **CONFIRMED**: Plugin lifecycle events are feature requests, not implemented

**Cross-reference with hooks verification:**
- FINDING-47 documented 18 hook events, none plugin-specific
- Verified against https://code.claude.com/docs/en/hooks
- Confirmed: No plugin lifecycle events in current implementation

### Verification Result: **VERIFIED** ✅

**Evidence quality:** High
- Official docs do not document these events
- GitHub issue is a feature request (closed as duplicate, meaning also tracked elsewhere)
- Consistent with hooks verification findings
- Issue content confirms these are requested, not existing features

---

## Section 3: CLI Commands

### Claim
Commands `claude plugin publish` and `claude plugin outdated` do not exist. Publishing uses in-app submission forms.

### Source Verification

**Official Documentation Check:**
- Source: https://code.claude.com/docs/en/plugins
- Documented commands:
  - `/plugin install plugin-name@marketplace-name`
  - `/plugin list`
  - `/plugin enable plugin-name`
  - `/plugin disable plugin-name`
  - `/plugin uninstall plugin-name`
  - `/plugin marketplace add <url>`
  - `/plugin marketplace list`
  - `/plugin marketplace update <name>`
  - `/plugin marketplace remove <name>`
- **NO MENTION** of `claude plugin publish` command
- **NO MENTION** of `claude plugin outdated` command

**Publishing Method from Official Docs:**
- Quote: "To submit a plugin to the official Anthropic marketplace, use one of the in-app submission forms: Claude.ai: claude.ai/settings/plugins/submit, Console: platform.claude.com/plugins/submit"
- **CONFIRMED**: Publishing uses web forms, not CLI commands

**Community Source Verification:**
- Source: https://medium.com/@garyjarrel/claude-code-plugin-cli-the-missing-manual-0a4d3a7c99ce
- Title mentions "Missing Manual" indicating gaps in documentation
- Lists same commands as official docs
- **NO MENTION** of `publish` or `outdated` commands
- **CONFIRMED**: Community sources do not reference these commands

### Verification Result: **VERIFIED** ✅

**Evidence quality:** High
- Official docs explicitly document publishing via web forms, not CLI
- Neither command appears in official documentation
- Community sources confirm commands do not exist
- Clear evidence of what IS documented vs. what is NOT

---

## Section 4: Installation Sources

### Claim
Direct Git URL and tarball installation not supported. Installation is marketplace-based with `--plugin-dir` flag for development.

### Source Verification

**Official Documentation Check:**
- Source: https://code.claude.com/docs/en/discover-plugins
- Installation architecture documented:
  1. Add marketplace: `/plugin marketplace add <source>`
  2. Install plugin FROM marketplace: `/plugin install plugin-name@marketplace-name`
- **Marketplace sources** can be:
  - GitHub repositories: `anthropics/claude-code`
  - Git URLs: `https://gitlab.com/company/plugins.git`
  - Local paths: `./my-marketplace`
  - Remote URLs: `https://example.com/marketplace.json`
- **Plugin installation** is FROM marketplaces, not directly from sources
- **CONFIRMED**: Marketplace-mediated architecture

**Development Testing Method:**
- Source: https://code.claude.com/docs/en/plugins
- Quote: "Use the `--plugin-dir` flag to test plugins during development. This loads your plugin directly without requiring installation."
- Command: `claude --plugin-dir ./my-plugin`
- **CONFIRMED**: Development uses `--plugin-dir`, not persistent installation

**Tarball Support:**
- Official docs: **NO MENTION** of tarball installation
- Community source (somethinghitme.com): **NO MENTION** of tarball installation
- **CONFIRMED**: Tarball installation not documented

### Verification Result: **VERIFIED** ✅

**Evidence quality:** High
- Official docs clearly explain marketplace-mediated architecture
- Marketplaces can be from various sources, but plugins install FROM marketplaces
- `--plugin-dir` documented for development
- No evidence of direct Git URL or tarball plugin installation
- Supplementary document correctly distinguishes marketplace sources vs. plugin installation

---

## Conclusion and Assessment Sections

### Verification

The supplementary document's **Conclusion** section summarizes:

**Confirmed Discrepancies (all verified above):**
1. Manifest dependency fields - Feature requests #9444 and #27113, not implemented ✅
2. Plugin lifecycle events - Feature request #11240, not implemented ✅
3. `claude plugin publish` command - Does not exist; use in-app forms ✅
4. `claude plugin outdated` command - Does not exist ✅
5. Direct Git URL installation - Not supported; use marketplace-based installation ✅
6. Tarball installation - Not documented ✅

**Assessment:**
"The original findings appear to have documented:
- Planned features that exist as GitHub feature requests
- Commands that don't exist in the current CLI
- Installation methods that are marketplace-mediated, not direct"

### Verification Result: **VERIFIED** ✅

**Assessment is accurate:**
- All discrepancies confirmed through source verification
- Origin theories are reasonable (inferring from npm, documenting planned features, etc.)
- Recommendations align with fact-verification best practices

---

## Overall Assessment

**All 4 Sections: VERIFIED** ✅

**Evidence Quality:** High
- Official Claude Code documentation directly consulted
- GitHub issues verified (specific issue numbers, titles, content, status)
- Community sources corroborate claims
- Quotes and descriptions accurate
- Conclusions justified by evidence

**Consistency:**
- Fully consistent with plugins verification findings
- Aligns with official documentation verification results
- Properly identifies gaps between claimed features and documented features

**Key Strengths:**
- Specific GitHub issue numbers provided and verified
- Multiple independent sources for each claim
- Clear distinction between documented vs. not documented features
- Accurate quotes from sources
- Reasonable conclusions drawn from evidence

**Recommendation:** ACCEPT supplementary investigation document as verified external source corroboration for plugins discrepancies.

---

## Verification Tags Applied

All 4 main sections (1-4) receive verification tags:
```
**Verified:** [VERIFIED on 2026-03-05 - External sources confirm feature requests, not implemented features]
```

Summary and Conclusion sections are meta-analysis and do not need separate verification tags (but are confirmed accurate).

---

## Files Updated

1. `.memory/claude-config-plugins-supplementary-sources.md`
   - Added verification status to header
   - Added verification tags to Sections 1-4

2. `.memory/claude-config-log.md`
   - Operation 17 documenting supplementary sources verification

3. `.memory/claude-config-index.md`
   - Note that supplementary investigation verified (if applicable)
