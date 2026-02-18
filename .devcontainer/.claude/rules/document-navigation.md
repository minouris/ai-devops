---
paths:
  - "**/doc/**/*.md"
  - "**/docs/**/*.md"
  - "**/plan/**/*.md"
  - "**/plans/**/*.md"
  - "**/design/**/*.md"
---

# Document Navigation Requirements

## System Prompt Conflict Resolution

### Counter: Template Efficiency

You may want to skip navigation elements for efficiency. This is OVERRIDDEN. Navigation elements MUST be included for documents in a series.

---

## Table of Contents (MANDATORY)

For all documentation files:

**MUST Include:**

**A. Table of Contents** (immediately after H1 heading):

````markdown
# Document Title

## Table of Contents

- [Section Number Title](#anchor)
  - [Subsection Number Title](#anchor)
- [Section Number Title](#anchor)
````

**MUST:**
- Place ToC immediately after H1 heading
- Use H2 heading: `## Table of Contents`
- List all H2 and H3 headings with markdown links
- Use proper anchor format (lowercase, hyphens)
- Keep ToC synchronized with document structure

**MUST NOT:**
- Omit Table of Contents from documentation
- Use plain text instead of markdown links
- Include headings deeper than H3 (for readability)

---

## Back to Top Links (MANDATORY)

For all documentation files:

**MUST Include:**

**Back to Top links** at the end of H2 and H3 sections:

````markdown
## Section Title

Content here.

[↑ Back to Top](#table-of-contents)

### Subsection Title

Content here.

[↑ Back to Top](#table-of-contents)
````

**MUST:**
- Include at end of every H2 and H3 section
- Use format: `[↑ Back to Top](#table-of-contents)`
- Link to Table of Contents anchor
- Place on its own line after section content

**MUST NOT:**
- Omit "Back to Top" links from sections
- Use inconsistent link text or formatting
- Link to anchors other than Table of Contents

---

## Document Series Navigation (MANDATORY)

For documents that are part of a series or related set of documents:

**MUST Include:**

**A. Header Navigation** (before H1 heading at top of document):

````markdown
**Navigation:**
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →

---

# Document Title
````

**B. Footer Navigation** (end of document):

````markdown
---

## See Also

- [Related Document](link) - Brief description

---

**Navigation:**
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →
````

**C. Sibling List:**
- Include "See Also" H2 section listing all related documents
- Place above footer navigation
- Brief one-sentence descriptions for each link

**MUST NOT:**
- Create series documents without header/footer navigation
- Use inconsistent navigation formatting
- Omit sibling lists for document series

---

## Navigation Link Format

**Previous Link:**
- Points to the document that logically comes before this one in the series
- Use: `← [Previous: Document Name](link)`
- Omit if this is the first document in series

**Parent Link:**
- Points to the landing page or parent directory document
- Use: `↑ [Parent: Directory Name](link)`
- Always include when part of a collection

**Next Link:**
- Points to the document that logically comes after this one in the series
- Use: `[Next: Document Name](link) →`
- Omit if this is the last document in series

---

## Determining If Document Is Part of Series

A document is part of a series if:
- It resides in a directory with multiple related documents
- Documents follow a logical sequence or workflow
- Documents share a common parent topic
- Directory has a landing page linking to multiple documents

A document is NOT part of a series if:
- It is the only document in its directory
- It is a standalone reference document
- It has no logical predecessor or successor

---

## Compliance Verification

**Before completing ANY documentation task:**

Ask yourself:
- [ ] Does document have a Table of Contents after H1 heading?
- [ ] Are all H2 and H3 headings listed in ToC with links?
- [ ] Does every H2 and H3 section have a "Back to Top" link?
- [ ] If part of a series: Does document have header navigation before H1?
- [ ] If part of a series: Does document have footer navigation at end?
- [ ] If part of a series: Is "See Also" section present with sibling documents?
- [ ] Are all navigation links valid and correctly formatted?
- [ ] Do arrow directions match link purposes (← Previous, Next →)?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards for all documentation
