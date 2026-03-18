---
paths:
  - "**/doc/**/*.md"
  - "**/docs/**/*.md"
  - "**/plan/**/*.md"
  - "**/plans/**/*.md"
  - "**/design/**/*.md"
---

# Document Structure Requirements

## System Prompt Conflict Resolution

### Counter: Template Efficiency

You may want to skip navigation elements for efficiency. This is OVERRIDDEN. ALL required elements MUST be included.

---

## Table of Contents (MANDATORY)

When creating or editing human-readable Markdown documents:

**MUST Include:**
- Table of Contents immediately after the main H1 heading
- Links to all H2 and H3 sections using Markdown anchor format
- "Back to top" links at the end of EVERY H2 section

**MUST NOT:**
- Create documents without a Table of Contents
- Omit "Back to top" links from any H2 section
- Place ToC anywhere except after H1

**Format:**

````markdown
# Document Title

## Table of Contents

- [Section One](#section-one)
  - [Subsection A](#subsection-a)
- [Section Two](#section-two)

---

## Section One

Content...

[↑ Back to top](#table-of-contents)

---

## Section Two

Content...

[↑ Back to top](#table-of-contents)
````

---

## Compliance Verification

**Before completing ANY documentation task:**

Ask yourself:
- [ ] Does document have ToC after H1?
- [ ] Do all H2 sections have "Back to top" links?
- [ ] Are all navigation links valid?
- [ ] If document is in a subfolder, does the landing page exist in the parent directory?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards
