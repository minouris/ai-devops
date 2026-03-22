# GitHub API - Operation Log

**Topic:** github-api
**Session started:** 2026-03-22

## Operations

### OP-2026-03-22-001: Extract and catalog GitHub API terms

**Operation type:** Analytical research - systematic extraction of domain terms from github-devops skill

**Files created:**
- `github-api-facts.md` - Term definitions and concepts
- `github-api-index.md` - Index file
- `github-api-log.md` - This log

**Terms extracted:** 7 findings
- FINDING-2026-03-22-1: Pull Request (PR)
- FINDING-2026-03-22-2: Review Thread
- FINDING-2026-03-22-3: REST API / GraphQL API
- FINDING-2026-03-22-4: Head Branch
- FINDING-2026-03-22-5: Base Branch
- FINDING-2026-03-22-6: Repository Configuration
- FINDING-2026-03-22-7: Compliance Gate

**Methodology:**
- Examined github-devops SKILL.md and action files
- Extracted semantic terms (not blind keywords)
- Defined each term with context, attributes, and relationships
- Organized by category: GitHub Concepts, API Patterns, Git/PR Concepts, Configuration, Quality Control

**Timestamp:** 2026-03-22

---

### OP-2026-03-22-002: Apply fine-grained term scoping methodology

**Operation type:** Term refinement - implement singular scope principle

**Refinement rationale:**
User feedback identified that bundled terms (e.g., "REST API / GraphQL API") violate fine-grained scoping principle. Each term should define ONE concept clearly, with hierarchies emerging naturally rather than being forced into a single term.

**Changes applied:**
- Separated "REST API / GraphQL API" into 5 granular terms:
  1. GitHub API (parent umbrella concept)
  2. GitHub REST API (specific to GitHub)
  3. GitHub GraphQL API (specific to GitHub)
  4. REST API (general principles)
  5. GraphQL API (general principles)

**Result:**
- 11 terms total (was 7)
- Each term has singular, clear scope
- Hierarchy visible: General principles → GitHub implementations → specific operations
- Terms can be independently referenced and understood

**Previous structure:** One bundled term for two concepts
**New structure:** Parent + specific implementations + general principles

**Timestamp:** 2026-03-22
