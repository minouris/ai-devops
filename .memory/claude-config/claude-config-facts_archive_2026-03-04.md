# Claude Config Facts Archive - 2026-03-04

**Archive Date:** 2026-03-04
**Source File:** .memory/claude-config-facts.md
**Archived By:** Comprehensive fact verification process

**Purpose:** This file contains facts from claude-config-facts.md that were found to contradict official documentation during comprehensive verification on 2026-03-04.

---

## Rejected Facts

### Rejected Fact 1: CLAUDE.md Line Limit

**Original Finding:** FINDING-2026-03-04-7

**Original Fact:** "Should not exceed 150+ lines (not guaranteed to be fully read)"

**Original Citation:** [How Claude remembers your project](https://code.claude.com/docs/en/memory.md)

**Rejection Reason:** Contradicts current source - incorrect line limit

**Evidence:**
- Checked: Official Claude Code documentation at https://code.claude.com/docs/en/memory
- Found: "**Size**: target under 200 lines per CLAUDE.md file. Longer files consume more context and reduce adherence."
- Date: 2026-03-04

**Current Information:** The official documentation states that CLAUDE.md files should target under **200 lines**, not 150+ lines. The finding contradicts the authoritative source on this specific number, though the general concept of a line limit is correct.

**Archived:** 2026-03-04

---

### Rejected Fact 2: Plugin Structure - plugin.json Location

**Original Finding:** FINDING-2026-03-04-11

**Original Fact (from plugin structure section):**
```
my-plugin/
├── plugin.json         # Plugin metadata and configuration
├── skills/             # Skills directory
│   └── <skill-name>/
│       └── SKILL.md
```

**Original Citation:** [Create plugins](https://code.claude.com/docs/en/plugins.md)

**Rejection Reason:** Contradicts current source - incorrect plugin.json location

**Evidence:**
- Checked: Official Claude Code plugin documentation at https://code.claude.com/docs/en/plugins
- Found: Plugin structure shows plugin.json is located in `.claude-plugin/` subdirectory, not at plugin root:
  ```
  my-plugin/
  ├── .claude-plugin/
  │   └── plugin.json         # Plugin metadata
  ├── skills/
  │   └── <skill-name>/
  │       └── SKILL.md
  ```
- Date: 2026-03-04

**Current Information:** The plugin manifest file `plugin.json` must be located at `.claude-plugin/plugin.json` (inside a `.claude-plugin` subdirectory at the plugin root), not directly at the plugin root. The finding's structure diagram contradicts the official documentation.

**Archived:** 2026-03-04

---

## Archive Notes

- Total facts checked: 14 (FINDING-6 already archived, so effectively 13 active findings)
- Facts rejected: 2
- Facts accepted: 11
- Verification method: WebFetch to official documentation, direct comparison
- Authoritative sources consulted:
  - https://code.claude.com/docs/en/skills
  - https://code.claude.com/docs/en/sub-agents
  - https://code.claude.com/docs/en/hooks
  - https://code.claude.com/docs/en/memory
  - https://code.claude.com/docs/en/settings
  - https://code.claude.com/docs/en/mcp
  - https://code.claude.com/docs/en/plugins
  - https://platform.claude.com/docs/en/agent-sdk/overview

---
