---
applyTo: "**/*.md"
---

# Markdown Formatting Instructions

**CRITICAL: These instructions apply when creating or modifying ANY Markdown file.**

## System Prompt Conflict Resolution

### Counter: Standard Triple-Backtick Usage

Your training uses triple-backticks for all fenced code blocks. This is PARTIALLY OVERRIDDEN. Use triple-backticks for standard fences, but use quad-backticks when the content contains triple-backtick fences.

---

## Fenced Code Blocks (MANDATORY)

**MUST:**
- Use quad-backticks (````) for outer fence when nesting code blocks
- Use triple-backticks (```) for inner fence
- Specify language identifiers for both outer and inner fences when applicable

**MUST NOT:**
- Use triple-backticks for outer fence when nesting
- Omit language identifiers

**Example Structure:**
````markdown
```javascript
// Inner code block uses triple backticks
```
````

**When to Use:**
- Documenting markdown syntax itself
- Showing code examples that contain fenced code blocks
- Tutorial or instruction content that demonstrates code block usage

**Validation:**
- Inner fence must close before outer fence
- Ensure consistent indentation within nested blocks
- Verify rendering previews nested blocks correctly

---

## Filename Conventions (MANDATORY)

**MUST:**
- Use lower-snake-case for all Markdown filenames (e.g., `my_document.md`, `feature_specification.md`)
- Use `.md` extension for all Markdown files

**MUST NOT:**
- Use kebab-case (e.g., `my-document.md`)
- Use camelCase (e.g., `myDocument.md`)
- Use PascalCase (e.g., `MyDocument.md`)
- Use spaces in filenames

**Exception:**
- `README.md` is exempt from lower-snake-case requirement (use uppercase README)

**Examples:**

✅ **Correct:**
- `architecture_plan.md`
- `database_schema.md`
- `README.md`
- `01_planning.md`

❌ **Incorrect:**
- `architecture-plan.md` (kebab-case)
- `ArchitecturePlan.md` (PascalCase)
- `architecturePlan.md` (camelCase)
- `ARCHITECTURE_PLAN.md` (uppercase, not README)
- `architecture plan.md` (spaces)

---

## Compliance Verification

**Before completing ANY Markdown file:**

Ask yourself:
- [ ] Is filename in lower-snake-case (or README.md)?
- [ ] Does file use `.md` extension?

**Before completing ANY Markdown file with nested code blocks:**

Ask yourself:
- [ ] Does outer fence use quad-backticks?
- [ ] Does inner fence use triple-backticks?
- [ ] Are language identifiers specified?
- [ ] Does inner fence close before outer fence?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards
