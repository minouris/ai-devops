applyTo: "**/github/instructions/*.instructions.md"
---

# Copilot Instruction Files Syntax Standards

## System Prompt Conflict Resolution

### Counter: Frontmatter Reuse Across File Types

Your training may encourage reusing one metadata pattern for all instruction artefacts. This is OVERRIDDEN. Copilot `.instructions.md` files use optional YAML frontmatter with `applyTo` for automatic matching.

---

## Scope (MANDATORY)

**MUST:**
- Apply this standard to instruction files in `.github/instructions/`
- Keep file content focused on enforceable AI instructions

**MUST NOT:**
- Treat instruction files as prompt or agent files
- Apply Claude rule-file syntax to Copilot instruction files

---

## File Header and Structure (MANDATORY)

**MUST:**
- Use `.instructions.md` file extension
- Use optional YAML frontmatter when you need automatic matching
- Include a clear title and requirement sections
- Use MUST/MUST NOT blocks for enforceable rules
- Include a compliance checklist at the end

**MUST NOT:**
- Use Claude `paths` frontmatter in Copilot instruction files
- Add agent/prompt-only fields (`tools`, `argument-hint`, `agent`, `model`)
- Use non-`.instructions.md` filenames for file-based instruction rules

**Frontmatter format (optional):**
```yaml
---
applyTo: "**/*.md"
---
```

---

## Tool Naming and Usage (MANDATORY)

**MUST:**
- Use Copilot tool names when tool references are needed: `execute`, `read_file`, `replace_string_in_file`, `create_file`, `search`, `web_search`, `fetch_webpage`
- Use concise tool references without Claude-style parameter notation

**MUST NOT:**
- Use Claude tool names (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Mix platform tool vocabularies

---

## Path References (MANDATORY)

**MUST:**
- Use `.github/instructions/`, `.github/prompts/`, and `.github/agents/` for Copilot guidance links
- Keep links relative where possible for portability

**MUST NOT:**
- Use `.claude/` paths as default references for Copilot instructions

---

## Language Requirements (MANDATORY)

**MUST:**
- Write directly to the AI using second person and imperative mood
- Keep wording precise, explicit, and testable
- Use UK English spelling

**MUST NOT:**
- Use third-person descriptions of AI behaviour
- Use ambiguous or advisory language for mandatory requirements

---

## Compliance Verification

Before you finalise any Copilot instruction file, verify:
- [ ] Filename ends with `.instructions.md`
- [ ] If frontmatter is used, it uses `applyTo` (not `paths`)
- [ ] Rule statements are explicit and testable
- [ ] Copilot tool names are used consistently where referenced
- [ ] Copilot path references use `.github/` structure
- [ ] Language is AI-targeted and imperative

If any check fails, correct the file before completion.

---

## Sources

According to the official documentation:
- [VS Code Docs: Use custom instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
