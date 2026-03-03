# Rule Structure Standards

Defines the required structure for rule artifacts. Use this file both to guide creation of new rules and to validate existing rules against required standards.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required frontmatter fields, e.g.:
- Include `name` field matching filename (without .md)
- Include `description` field (one sentence)
- Include `paths` glob if the rule applies to specific file patterns
- Include `release` block if publishing
-->

**MUST NOT:**
<!-- TODO: List forbidden frontmatter patterns -->

**Example:**
```yaml
---
name: example-standards
description: Brief one-sentence description of what this rule enforces.
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - rule-structure
---
```

---

## File Structure Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required file structure, e.g.:
- Place rule file in `src/{platform}/rules/`
- Name file as `{name}.md`
-->

**MUST NOT:**
<!-- TODO: Define forbidden structural patterns -->

---

## Content Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required sections, e.g.:
- Include a "# {Name} Standards" H1 heading
- Include "## System Prompt Conflict Resolution" section when overriding AI defaults
- Include at least one MUST/MUST NOT standards section
- Include a "## Compliance Verification" section at the end
- End Compliance Verification with "If ANY answer is 'No'" enforcement statement
-->

**MUST NOT:**
<!-- TODO: Define forbidden content patterns, e.g.:
- Omit the Compliance Verification section
- Write standards in third person ("The AI should...")
- Use vague language ("try to", "consider")
-->

---

## System Prompt Conflict Resolution Requirements (MANDATORY when overriding defaults)

**MUST:**
<!-- TODO: Define when and how to write conflict resolution, e.g.:
- Include when the rule overrides AI default behaviour
- Use "Counter: {Default Behaviour}" as subsection heading
- State explicitly what is OVERRIDDEN and what replaces it
-->

**MUST NOT:**
<!-- TODO: Forbidden conflict resolution patterns -->

---

## MUST/MUST NOT Section Format (MANDATORY)

**MUST:**
<!-- TODO: Define formatting requirements for standards sections, e.g.:
- Use bold "**MUST:**" and "**MUST NOT:**" labels
- Use bullet lists under each label
- Include examples where requirement is ambiguous
- Use "## {Section Name} (MANDATORY)" heading format for required sections
-->

**MUST NOT:**
<!-- TODO: Forbidden formatting patterns -->

---

## Compliance Verification Section Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define requirements for the verification section, e.g.:
- Include a checkbox list of items to verify
- Each item must correspond to a MUST requirement
- End with "If ANY answer is 'No':" enforcement block
- Enforcement block must say "These are mandatory standards"
-->

**MUST NOT:**
<!-- TODO: Forbidden verification patterns -->

---

## Naming Conventions (MANDATORY)

**MUST:**
<!-- TODO: Define naming rules, e.g.:
- Use lowercase with hyphens for rule name
- Use `.md` extension
- Name reflects the standard being enforced (not the artifact type it applies to)
-->

**MUST NOT:**
<!-- TODO: Forbidden naming patterns -->

---

## Compliance Verification

**Before completing any rule artifact:**

Ask yourself:
<!-- TODO: Add checklist items matching the MUST requirements above -->
- [ ] Does the file include an H1 heading?
- [ ] Is there a System Prompt Conflict Resolution section (if overriding defaults)?
- [ ] Is there at least one MUST/MUST NOT section?
- [ ] Does the file end with a Compliance Verification section?
- [ ] Does the Compliance Verification end with "If ANY answer is 'No'" enforcement?
- [ ] Are all instructions written in second-person imperative?

**If ANY answer is "No":**
- Fix the issue before declaring the rule complete
- These are mandatory standards
