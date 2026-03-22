# Term Capture and Extraction Guidelines

**This file is loaded when: You need detailed guidance on capturing, extracting, and maintaining domain terms in analysis workflows.**

---

## Embedded Rules

### Define Terms with Singular Scope

When you create a term, define it as a semantic concept label for a single coherent idea. Do not create terms that bundle multiple related concepts into one entry.

**Treat terms differently from keywords:**
- **Keywords**: Provide quick flat links to facts without semantic relationship
- **Terms**: Define fine-grained concepts with singular scope, enabling hierarchical indexing and cross-domain applicability

**Use these characteristics to guide your term creation:**
- **Semantic meaning**: When you label a concept, ensure it labels a coherent idea, not just an access point
- **Fine-grained scope**: Create each term to define ONE clear concept
- **Hierarchical**: Keep general principles separate from specific implementations
- **Independently referenceable**: Create each term as a standalone entry with complete context

**Structure term hierarchies like this example:**
```
General principle:    REST API
├── GitHub-specific:  GitHub REST API
└── GitHub-specific:  GitHub GraphQL API
                      GraphQL API (separate from REST API)
                      GitHub API (parent umbrella concept)
```

**Do NOT bundle concepts into a single term:**
- ❌ "REST API / GraphQL API" (bundles two concepts)
- ✅ Create separately: "REST API", "GraphQL API", "GitHub REST API", "GitHub GraphQL API"

---

## Term File Location and Naming

### Where to Store Terms

When you extract terms from facts, maintain a central terms file for each topic:
```
.memory/[topic]/[topic]-terms.md
```

### Consolidate Terms at Topic Level

When subtopics introduce new terms, add them to the main topic's terms file—do not create separate terms files for subtopics.

**Structure:**
```
.memory/github-api/github-api-terms.md       (main terms file - put all terms here)
.memory/github-api/github-api-facts.md       (main facts file)
.memory/github-api/github-api-subtopic/      (subtopic folder)
├── github-api-subtopic-facts.md             (contributes terms to parent)
└── (DO NOT create github-api-subtopic-terms.md)
```

---

## Term Entry Format (MANDATORY)

### Create Term Entries Using This Format

When you create a term, use this exact structure:

```markdown
### TERM-[topic-slug]-[YYYY-MM-DD-N]

**Term:** [Term Name]

**Definition:** [One or more sentences defining the concept]

**Source:** [Where the term was extracted from - FINDING-ID, user input, documentation URL]

**Scope:** [Singular concept statement - what this term covers and what it does NOT cover]

**Key attributes:**
- [Attribute 1]: [Description]
- [Attribute 2]: [Description]

**Related terms:** [TERM-ID], [TERM-ID], [Concept Name (not yet defined)]

**Used in facts:**
- [FINDING-2026-03-22-1](path/to/fact-file.md#finding anchor) - Finding Name
- [FINDING-2026-03-22-5](path/to/fact-file.md#finding anchor) - Another Finding Name

**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Captured:** YYYY-MM-DD HH:MM
```

### Field Requirements

When you create a term entry, populate each field with this requirement:

- **TERM-[topic-slug]-YYYY-MM-DD-N**: Use this unique identifier format (topic slug + date + sequence number)
- **Term**: Supply the semantic label for the concept (1-4 words)
- **Definition**: Write a clear explanation of what the term encompasses
- **Source**: Cite where you extracted this term from (FINDING-ID or direct source URL)
- **Scope**: Write an explicit statement of what this term covers and its boundaries (prevents conflation with related concepts)
- **Key attributes**: List 2-5 important characteristics that define this concept
- **Related terms**: Link to other term IDs this one connects to, and include placeholders for undefined concepts you'll create later
- **Used in facts**: Include backlinks to every fact that uses or introduces this term
- **Verified**: Always write "NOT YET VERIFIED - requires verification workflow" during capture phase (same requirement as facts)
- **Captured**: Record the timestamp when you created this term entry

### Example Term Entry

When you create a term, structure it like this example:

```markdown
### TERM-github-api-2026-03-22-4

**Term:** GitHub REST API

**Definition:** GitHub's REST (Representational State Transfer) implementation for API access. Uses HTTP methods (GET, POST, PUT, DELETE) with fixed endpoint paths. Each endpoint returns a structured response containing specific fields.

**Source:** FINDING-2026-03-22-4 (extracted from github-devops create-pr.md)

**Scope:** Refers specifically to GitHub's REST API implementation. Does NOT include general REST API principles (see "REST API" term) or GitHub GraphQL API (see "GitHub GraphQL API" term).

**Key attributes:**
- **Endpoint-based**: Each operation is a specific HTTP endpoint (e.g., `/repos/{owner}/{repo}/pulls/{number}`)
- **Fixed response structure**: Cannot request specific fields; server returns all fields
- **HTTP semantics**: Uses GET, POST, PUT, DELETE, PATCH methods and status codes
- **Simpler for operations**: Straightforward for single-resource operations

**Related terms:** TERM-github-api-2026-03-22-3 (GitHub API), TERM-github-api-2026-03-22-7 (REST API), TERM-github-api-2026-03-22-5 (GitHub GraphQL API)

**Used in facts:**
- [FINDING-2026-03-22-4](github-api-facts.md#finding-2026-03-22-4) - GitHub REST API definition extracted
- [FINDING-2026-03-22-1](github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions REST API

**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Captured:** 2026-03-22 12:45
```

---

## Term Extraction Workflow

### Extract Terms Automatically When Facts Introduce Concepts

When you create a fact that introduces a new semantic concept, extract it as a term immediately.

**Determine whether to extract a term:**

Use these conditions to decide:
1. Does the fact define a new concept label with semantic meaning?
2. Should this concept be independently referenceable across the topic?
3. Does the concept have clear boundaries (singular scope)?
4. Might other facts reference this concept?

If all conditions are yes, extract a term.

**Extract when you identify these triggers:**
- ✅ Finding about "Pull Request" → Extract as term (singular semantic concept)
- ✅ Finding about "REST API" → Extract as term (general principle, cross-domain applicable)
- ✅ Finding about "Head Branch" → Extract as term (specific role in PR structure)
- ❌ Finding mentions "the number field" → Do NOT extract (too granular, attribute not concept)
- ❌ Finding mentions "API" casually → Do NOT extract unless it defines "API" as a concept

**Execute automatic extraction workflow:**

1. After you append a finding to a fact file
2. Identify whether the finding introduces a concept that should be a term
3. Create term entry in `[topic]-terms.md` (create file if it does not exist)
4. Add backlink in finding to new term (or add term reference if term already existed)
5. Update terms index

### Extract Terms On Demand

When the user explicitly requests term extraction from facts, use this workflow:

**Execute on-demand extraction workflow:**

1. Read the specified fact files
2. Scan for semantic concepts (not keywords)
3. For each concept:
   - Check whether term already exists in `[topic]-terms.md`
   - If new: Create term entry with complete definition, scope, and attributes
   - If existing: Update "Used in facts" backlinks with new findings
4. Update terms index
5. Report findings: how many terms created/updated, what relationships emerged

---

## Bidirectional Linking (MANDATORY)

When you link facts and terms, you must maintain two-way links for complete traceability.

### Add Term Links to Fact Entries

When you create a fact, add term references to the fact entry:

**Add this line to fact entries:**
```markdown
**Introduces term:** TERM-github-api-2026-03-22-1

**Uses terms:** TERM-github-api-2026-03-22-3, TERM-github-api-2026-03-22-5
```

**Link format requirements:**
- Write "**Introduces term:**" when the fact defines or first introduces this term
- Write "**Uses terms:**" when the fact uses existing terms without introducing them
- Use the complete TERM-ID for each link

### Add Fact Backlinks to Term Entries

When you maintain a term, keep its "Used in facts" section current:

**Update "Used in facts" whenever:**
- A new fact introduces or uses this term
- An existing fact is archived (remove it from the "Used in facts" list)

**Format backlinks like this:**
```markdown
**Used in facts:**
- [FINDING-2026-03-22-4](github-api-facts.md#finding-2026-03-22-4) - GitHub REST API definition
- [FINDING-2026-03-22-1](github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions REST API
```

---

## Term Validation Criteria (MANDATORY)

When you create and maintain terms, apply the exact same validation requirements as you apply to facts.

### Verify Terms During Creation

Before finalizing a term entry, verify it meets these requirements:

**MUST have before creating a term:**
- Clear, singular scope (what this term covers; what it does NOT cover)
- Source citation (where extracted from)
- Complete definition with context
- Key attributes that characterize the concept (2-5 attributes)
- Related terms listed (existing terms + placeholders for future related terms)

**MUST NOT do when creating terms:**
- Create terms that bundle multiple concepts (violates singular scope)
- Create terms without clear source
- Create terms without definition
- Create terms that are just aliases for existing concepts

### Run Verification Workflow

When you engage the verification workflow, treat terms the same as facts:

**During verification phase:**
- Verify definition against source material
- Verify scope boundaries are accurate
- Verify related terms are correct
- Verify backlinks to facts are accurate

**Update verification tag after verification:**
```markdown
**Verified:** VERIFIED on YYYY-MM-DD by [source-url]
```

### Archive Disproven Terms

When you discover a term is incorrect or misconstrued, archive it immediately—never delete it.

**Archive disproven terms using this format:**

Create or update `.memory/[topic]/[topic]-terms-disproven.md` with:

```markdown
### TERM-github-api-2026-03-22-12 [DISPROVEN]

**Original term:** [Term Name]

**Disproven:** 2026-03-22 15:00

**Reason:** [Explanation of why this term was inaccurate]

**Evidence:** [References showing the term was incorrect]

[Original definition and attributes...]

**Disproven by finding:** FINDING-YYYY-MM-DD-N
```

---

## Terms Index Maintenance (MANDATORY)

When you manage terms, maintain an index file at the topic level.

### Create and Update Terms Index

Maintain this index file: `.memory/[topic]/[topic]-terms-index.md`

**Update the index after each significant operation:**
- New term created
- Term verified
- Term archived
- Backlinks updated

**Structure the index like this:**
```markdown
# [Topic] Terms Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Terms Summary

- **Total terms:** N
- **Verified:** N
- **Pending verification:** N
- **Archived (disproven):** N

---

## Terms by Category

### [Category 1]

| Term | ID | Verified | Used in Facts |
|------|----|-----------|----|
| [Term 1](path/to/terms.md#term anchor) | TERM-ID-1 | ✅ | 3 facts |
| [Term 2](path/to/terms.md#term anchor) | TERM-ID-2 | ⏳ | 1 fact |

### [Category 2]

| Term | ID | Verified | Used in Facts |
|------|----|-----------|----|
| [Term 3](path/to/terms.md#term anchor) | TERM-ID-3 | ✅ | 5 facts |

---

## Term Relationships

[When you maintain multiple related terms, document their hierarchy]

**Example hierarchy:**
```
GitHub API (parent)
├── GitHub REST API
└── GitHub GraphQL API

REST API (general principle)
GraphQL API (general principle)
```

---

## Verification Status

| Term | Status | Last Verified | Source |
|------|--------|---------------|----|
| TERM-github-api-2026-03-22-1 | ✅ VERIFIED | 2026-03-22 14:30 | [source-url] |
| TERM-github-api-2026-03-22-4 | ⏳ PENDING | — | FINDING-2026-03-22-4 |
```

---

## Integration with Analysis Workflow

### Where Term Extraction Fits in Your Process

Execute term extraction as step 1.5 in the analysis workflow:

1. ✅ Capture Research in Fact Files (existing)
2. ✨ **Extract and Maintain Terms (THIS STEP)** ← You are here
   - Auto-extract terms from facts as created
   - Update bidirectional links
   - Maintain terms index
3. ✅ Archive Disproven Findings (existing)
4. ✅ Update Analysis Index (existing)
5. ✅ Create Final Output (existing)
6. ✅ Operation Logging (existing)

### Create Terms File When Needed

Create `[topic]-terms.md` when:
- You extract your first term from a finding
- User explicitly requests term extraction
- Topic has 2+ semantic concepts worth indexing

### Keep Terms Current

Update existing terms when:
- New facts are added that use or reference the term
- Clarifications refine the term definition (append as new term referencing original)
- Verification updates the term's status
- Related terms are discovered

---

## File Size Management for Terms

**Monitor term file size:**
- **Maximum:** 30,000 characters (~7,500 tokens)
- **Action trigger:** When you would add terms that would exceed this limit

**When you exceed the threshold, execute this process:**
1. Create subtopic terms file: `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-terms.md`
2. Move related term entries to subtopic file
3. Update both files' indices to cross-reference
4. Update main topic terms index with subtopic reference

---

## MUST/MUST NOT Summary

**During term capture, you MUST:**
- Extract terms with singular, clear scope
- Include complete source citation
- Define key attributes distinct from keywords (2-5 attributes)
- Link bidirectionally with facts
- Update terms index after each change
- Apply exact same validation criteria as facts
- Archive disproven terms without deletion

**During term capture, you MUST NOT:**
- Create terms that bundle multiple concepts
- Create terms without clear scope boundaries
- Skip source citations
- Create separate terms files for subtopics
- Edit existing terms during research phase (append clarifications instead)
- Mark terms as verified before running verification workflow
- Delete or lose bidirectional links
