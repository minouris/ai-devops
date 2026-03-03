# Skill Structure Standards

Defines the required structure for skill artifacts. Use this file both to guide creation of new skills and to validate existing skills against required standards.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
<!-- TODO: List required frontmatter fields, e.g.:
- Include `name` field matching directory name
- Include `description` field (one sentence)
- Include `disable-model-invocation: true` for orchestration skills
- Include `release` block with `publish`, `platforms`, and `validation` fields
-->

**MUST NOT:**
<!-- TODO: List forbidden frontmatter patterns, e.g.:
- Omit the `name` field
- Use multi-sentence descriptions
-->

**Example:**
```yaml
---
name: example-skill
description: Brief one-sentence description of when to use this skill.
disable-model-invocation: true
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - skill-structure
---
```

---

## File Structure Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required directory structure, e.g.:
- Place skill in `src/{platform}/skills/{name}/`
- Include `SKILL.md` as the main entry point
- Include `references/` subdirectory for per-phase detail files
- Name reference files after the phase they describe
-->

**MUST NOT:**
<!-- TODO: Define forbidden structural patterns, e.g.:
- Place all instructions in a single monolithic SKILL.md
- Create reference files outside the `references/` subdirectory
-->

---

## SKILL.md Content Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required sections in SKILL.md, e.g.:
- Include a "# {Name} Skill" H1 heading
- Include a "# Workflow Overview" section listing all phases
- Reference each phase file as `[references/{phase-name}.md](references/{phase-name}.md)`
- Include an "# Important Notes" section with MUST/MUST NOT
-->

**MUST NOT:**
<!-- TODO: Define forbidden content patterns, e.g.:
- Include detailed step instructions in SKILL.md (delegate to references/)
- Omit the workflow overview section
-->

---

## Reference File Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define requirements for per-phase reference files, e.g.:
- Start with `# {Phase Name} Phase` H1 heading
- Include numbered steps
- Include an "## Important Notes" section with MUST/MUST NOT
- End with a clear "## Output" or precondition/postcondition summary
-->

**MUST NOT:**
<!-- TODO: Define forbidden reference file patterns -->

---

## Naming Conventions (MANDATORY)

**MUST:**
<!-- TODO: Define naming rules, e.g.:
- Use lowercase with hyphens for skill name
- Name SKILL.md exactly as `SKILL.md` (uppercase)
- Name reference files in lowercase with hyphens
-->

**MUST NOT:**
<!-- TODO: Forbidden naming patterns -->

---

## Compliance Verification

**Before completing any skill artifact:**

Ask yourself:
<!-- TODO: Add checklist items matching the MUST requirements above -->
- [ ] Does `SKILL.md` have valid frontmatter with all required fields?
- [ ] Does `SKILL.md` have a workflow overview referencing all phase files?
- [ ] Does each referenced phase file exist in `references/`?
- [ ] Does each reference file have numbered steps and a MUST/MUST NOT section?
- [ ] Are all filenames lowercase with hyphens (except `SKILL.md`)?

**If ANY answer is "No":**
- Fix the issue before declaring the skill complete
- These are mandatory standards
