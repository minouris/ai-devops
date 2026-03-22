# Term Capture and Extraction Guidelines

**This file is loaded when: You need detailed guidance on capturing, extracting, and maintaining domain terms in analysis workflows.**

---

## Embedded Rules

### What is a Term?

A **term** is a semantic concept label for a topic. Unlike keywords which provide quick flat links to facts, terms define fine-grained concepts with singular scope, enabling hierarchical indexing and cross-domain applicability.

**Key characteristics:**
- **Semantic meaning**: Labels coherent concepts, not just access points
- **Fine-grained scope**: Each term defines ONE concept clearly
- **Hierarchical**: General principles separate from specific implementations
- **Independently referenceable**: Each term stands alone with complete context

**Example structure:**
```
General principle:    REST API
├── GitHub-specific:  GitHub REST API
└── GitHub-specific:  GitHub GraphQL API
                      GraphQL API (separate from REST API)
                      GitHub API (parent umbrella concept)
```

**NOT** bundled as one term:
- ❌ "REST API / GraphQL API" (bundles two concepts)
- ✅ Separate: "REST API", "GraphQL API", "GitHub REST API", "GitHub GraphQL API"

---

## Term File Location and Naming

**Topics maintain a central terms file:**
```
.memory/[topic]/[topic]-terms.md
```

**Subtopics contribute to the main topic terms file:**
- Subtopic findings can introduce and define new terms
- All terms (from main topic and all subtopics) are consolidated in the main topic's `[topic]-terms.md`
- Do NOT create separate terms files for subtopics

**Example:**
```
.memory/github-api/github-api-terms.md       (main terms file)
.memory/github-api/github-api-facts.md       (main facts file)
.memory/github-api/github-api-subtopic/      (subtopic folder)
├── github-api-subtopic-facts.md             (contributes terms to parent)
└── github-api-subtopic-terms.md             (NOT created - use parent file)
```

---

## Term Entry Format (MANDATORY)

**Standard format:**
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

**Field definitions:**
- `TERM-[topic-slug]-YYYY-MM-DD-N`: Unique identifier (topic slug + date + sequence number)
- `Term`: The semantic label for the concept (1-4 words typically)
- `Definition`: Clear explanation of what the term encompasses
- `Source`: Citation of where this term was extracted from (FINDING-ID or direct source)
- `Scope`: Explicit statement of what this term covers and boundaries (prevents conflation)
- `Key attributes`: 2-5 important characteristics of this concept
- `Related terms`: Links to other terms this one connects to (terms that exist + undefined concepts for future terms)
- `Used in facts`: Backlinks to every fact that uses or introduces this term
- `Verified`: Always "NOT YET VERIFIED" during capture phase (same as facts)
- `Captured`: Timestamp when term was created

**Example:**
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

### Automatic Extraction (During Fact Capture)

**When to extract terms:**

When you create a finding that introduces a new semantic concept, extract it as a term immediately:

**Trigger conditions:**
1. Finding defines a new concept label with semantic meaning
2. Concept should be independently referenceable across the topic
3. Concept has clear boundaries (singular scope)
4. Concept might be referenced in other facts

**Trigger examples:**
- ✅ Finding about "Pull Request" → Extract as term (singular semantic concept)
- ✅ Finding about "REST API" → Extract as term (general principle, cross-domain applicable)
- ✅ Finding about "Head Branch" → Extract as term (specific role in PR structure)
- ❌ Finding mentions "the number field" → NOT a term (too granular, attribute not concept)
- ❌ Finding mentions "API" casually → NOT a term unless it defines "API" as a concept

**Workflow:**
1. After appending finding to fact file
2. Identify if finding introduces a concept that should be a term
3. Create term entry in `[topic]-terms.md` (create file if doesn't exist)
4. Add backlink in finding to new term (or add term reference if already existed)
5. Update terms index

### On-Demand Extraction

When explicitly requested by user: "Extract terms from these facts" or "Create a terms file for this topic"

**Workflow:**
1. Read specified fact files
2. Scan for semantic concepts (not keywords)
3. For each concept:
   - Check if term already exists in `[topic]-terms.md`
   - If new: Create term entry with complete definition, scope, and attributes
   - If existing: Update "Used in facts" backlinks with new findings
4. Update terms index
5. Report findings: how many terms created/updated, what relationships emerged

---

## Bidirectional Linking (MANDATORY)

Terms and facts must maintain two-way links for traceability.

### Facts → Terms

In fact entries, link to any terms that are defined or used:

**Where to add link:**
Add a new line in fact entry:
```markdown
### FINDING-2026-03-22-1

**Term:** Pull Request (PR)

**Definition:** A mechanism in GitHub...

**Captured:** 2026-03-22
**Source:** github-devops SKILL.md
**Keywords:** api, github, concept

**Introduces term:** TERM-github-api-2026-03-22-1

**Verified:** [NOT YET VERIFIED - requires verification workflow]
```

**Link format:**
```markdown
**Introduces term:** TERM-github-api-2026-03-22-1

**Uses terms:** TERM-github-api-2026-03-22-3, TERM-github-api-2026-03-22-5
```

### Terms → Facts

In term entries, link to all facts that introduce or use the term:

**Backlink maintenance:**
Update "Used in facts" section whenever:
- A new fact introduces or uses this term
- An existing fact is archived (remove it from the "Used in facts" list)

**Backlink format:**
```markdown
**Used in facts:**
- [FINDING-2026-03-22-4](github-api-facts.md#finding-2026-03-22-4) - GitHub REST API definition
- [FINDING-2026-03-22-1](github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions REST API
```

---

## Term Validation Criteria

Terms are subject to the **exact same validation requirements as facts**.

### Creation Phase Validation

**MUST have before creating a term:**
- Clear, singular scope (what this term covers; what it doesn't)
- Source citation (where extracted from)
- Complete definition with context
- Key attributes that characterize the concept
- Related terms listed (existing and placeholders for future)

**MUST NOT:**
- Create terms that bundle multiple concepts (violates singular scope)
- Create terms without clear source
- Create terms without definition
- Create terms that are just aliases for existing concepts

### Verification Workflow

**During verification phase:**
- Terms go through the same verification workflow as facts
- Verify definition against source material
- Verify scope boundaries are accurate
- Verify related terms are correct
- Verify backlinks to facts are accurate

**Verification tag format:**
```markdown
**Verified:** VERIFIED on YYYY-MM-DD by [source-url]
```

### Disproven Terms

When a term is disproven or found to be misconstrued:

**MUST:**
- Archive to `-terms-disproven.md` companion file (never delete)
- Include disproof metadata (reason, evidence, date)
- Keep all backlinks for historical reference

**Archive format:**
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

**File location:**
```
.memory/[topic]/[topic]-terms-index.md
```

**Update after each significant operation:**
- New term created
- Term verified
- Term archived
- Backlinks updated

**Index structure:**
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

[Visual or textual representation of term hierarchy and relationships]

**Hierarchy Example:**
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

### Step 0.5: Extract and Maintain Terms (NEW)

This workflow step sits between Fact Capture and Disproven Finding archival.

**In your overall research process:**

1. ✅ Capture Research in Fact Files (existing)
2. ✨ **Extract and Maintain Terms (NEW)**
   - Auto-extract terms from facts as created
   - Update bidirectional links
   - Maintain terms index
3. ✅ Archive Disproven Findings (existing)
4. ✅ Update Analysis Index (existing)
5. ✅ Create Final Output (existing)
6. ✅ Operation Logging (existing)

### When to Create Terms File

Create `[topic]-terms.md` when:
- First term is extracted from a finding
- User explicitly requests term extraction
- Topic has 2+ semantic concepts worth indexing

### When to Update Terms

Update existing terms when:
- New facts are added that use or reference the term
- Clarifications refine the term definition (append as new term referencing original)
- Verification updates the term's status
- Related terms are discovered

---

## File Size Management for Terms

**Size threshold:**
- **Maximum:** 30,000 characters (~7,500 tokens)
- **Action trigger:** When adding terms would exceed threshold

**Action on threshold exceeded:**
1. Create subtopic terms file: `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-terms.md`
2. Move related term entries to subtopic file
3. Update both files' indices to cross-reference
4. Update main topic terms index with subtopic reference

---

## Examples

### Simple Term

```markdown
### TERM-analysis-concepts-2026-03-22-1

**Term:** Term (in analysis indexing)

**Definition:** A semantic concept label for a topic. A term labels coherent concepts with singular scope, enabling hierarchical indexing and cross-domain applicability. Unlike keywords which provide quick flat access, terms define meaningful concept relationships.

**Source:** User observation (analysis-concepts session)

**Scope:** Refers to semantic concept labels in systematic analysis and indexing workflows. Does NOT include keyword tags (which lack semantic structure) or arbitrary labels.

**Key attributes:**
- **Semantic meaning**: Labels coherent concepts, not just access points
- **Singular scope**: Each term defines ONE clear concept
- **Independent**: Can be referenced and understood standalone
- **Hierarchical**: Enables parent-child and related concept relationships

**Related terms:** TERM-analysis-concepts-2026-03-22-2 (Keyword), TERM-analysis-concepts-2026-03-22-3 (Topic Index)

**Used in facts:**
- [FINDING-2026-03-22-1](analysis-concepts-facts.md#finding-2026-03-22-1) - Introduces term vs keyword distinction
- [FINDING-2026-03-22-2](analysis-concepts-facts.md#finding-2026-03-22-2) - Practical application

**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Captured:** 2026-03-22 10:00
```

### Hierarchical Terms

```markdown
### TERM-github-api-2026-03-22-3

**Term:** GitHub API

**Definition:** The umbrella interface provided by GitHub for programmatic access to repository data, pull requests, reviews, automation, and administration. GitHub offers two API implementations: REST API (endpoint-based) and GraphQL API (query language).

**Source:** FINDING-2026-03-22-3 (extracted from github-devops SKILL.md)

**Scope:** Refers to GitHub's complete API platform. Does NOT include specific implementations (see "GitHub REST API", "GitHub GraphQL API") or general API principles (see "REST API", "GraphQL API").

**Key attributes:**
- **Two implementations**: REST and GraphQL APIs available
- **Authentication**: Personal access tokens and GitHub Apps
- **Multiple versions**: Different API versions available
- **Integrations**: Powers GitHub Actions, apps, and CI/CD

**Related terms:** TERM-github-api-2026-03-22-1 (Pull Request), TERM-github-api-2026-03-22-4 (GitHub REST API), TERM-github-api-2026-03-22-5 (GitHub GraphQL API)

**Used in facts:**
- [FINDING-2026-03-22-3](github-api-facts.md#finding-2026-03-22-3) - GitHub API definition
- [FINDING-2026-03-22-1](github-api-facts.md#finding-2026-03-22-1) - Pull Request uses GitHub API

**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Captured:** 2026-03-22 12:00
```

---

## MUST/MUST NOT Summary

**During term capture:**

**MUST:**
- Extract terms with singular, clear scope
- Include complete source citation
- Define key attributes distinct from keywords
- Link bidirectionally with facts
- Update terms index after each change
- Subject terms to exact same validation as facts
- Never delete disproven terms (archive instead)

**MUST NOT:**
- Create terms that bundle multiple concepts
- Create terms without clear scope boundaries
- Skip source citations
- Create separate terms files for subtopics
- Edit existing terms during research phase (append clarifications instead)
- Mark terms as verified before verification workflow
- Delete or lose bidirectional links
