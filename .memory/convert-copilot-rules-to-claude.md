# Convert Copilot Instructions to Claude Code Rules

**Purpose:** Instructions for converting GitHub Copilot instruction files to Claude Code rule files.

**Created:** 2026-02-19
**Updated:** 2026-02-19 with verified syntax from official documentation

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Copilot to Claude Code, you MUST transform ALL platform-specific elements to match Claude Code conventions, not preserve Copilot patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Rule Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.github/instructions/*.md` → `.claude/rules/*.md`
- Preserve filename exactly (e.g., `ai-targeted-language.md` stays `ai-targeted-language.md`)
- Create `.claude/rules/` directory if it does not exist

**MUST NOT:**
- Place Claude Code rule files in `.github/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

**Source:** [Claude Code Memory documentation](https://code.claude.com/docs/en/memory) - "For larger projects, you can organize instructions into multiple files using the `.claude/rules/` directory."

---

### 2. Frontmatter Conversion

**Copilot Instructions Frontmatter:**
```markdown
# No frontmatter - instructions start directly with markdown content
```

According to [GitHub Copilot documentation](https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot), Copilot instruction files do not use frontmatter.

**Claude Code Rules Frontmatter (OPTIONAL):**
```yaml
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
  - "**/*.prompt.md"
---
```

According to [Claude Code Memory documentation](https://code.claude.com/docs/en/memory), rules can optionally include frontmatter with a `paths` field to scope them to specific files.

**MUST:**
- Add `paths` frontmatter ONLY if the rule should apply to specific file patterns
- Use glob patterns in the `paths` array
- Omit frontmatter entirely for rules that apply to all files

**MUST NOT:**
- Include `tools` property (belongs to agents/skills, not rules)
- Include `argument-hint` property (belongs to skills, not rules)
- Include `name` or `description` properties (rules don't require these)

**Glob Patterns:**
- `**/*.ts` - All TypeScript files in any directory
- `src/**/*` - All files under src/ directory
- `*.md` - Markdown files in project root
- `**/*.{ts,tsx}` - All .ts and .tsx files (brace expansion)

---

### 3. Tool Name Mapping

**When converting tool references in rule content, map Copilot tools to Claude Code tools:**

| Copilot Tool | Claude Code Tool | Notes |
|---|---|---|
| `execute` | `Bash` | Command execution |
| `read_file` | `Read` | File reading |
| `edit` / `replace_string_in_file` | `Edit` | File editing |
| `create_file` | `Write` | File creation/writing |
| `search` | `Grep` or `Glob` | Content search / file pattern matching |
| `web` or `web_search` | `WebSearch` | Web search |
| `fetch_webpage` | `WebFetch` | Fetch webpage content |

**Sources:**
- [Claude Code Settings - Tools](https://code.claude.com/docs/en/settings#tools-available-to-claude)
- [GitHub Copilot Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)

---

## Sources

- [Claude Code Memory documentation](https://code.claude.com/docs/en/memory)
- [Claude Code Settings - Tools](https://code.claude.com/docs/en/settings)
- [GitHub Copilot Custom Instructions](https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- [GitHub Copilot Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
