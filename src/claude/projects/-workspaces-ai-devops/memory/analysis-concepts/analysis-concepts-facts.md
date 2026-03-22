# Analysis Concepts - Fact File

## FINDING-2026-03-22-1

**Topic:** Term definition and utility in analysis indexing

**Observation:**
A `term` is a label for a concept within a topic. It may consist of one or more words. It is a less "blind" form of keyword—where keywords may provide quick links to facts, they lack usefulness as a form of index as they lack wider meaning.

**Key distinction:**
- **Keywords**: Quick access, but lack semantic context for indexing
- **Terms**: Semantically meaningful concept labels, better suited for systematic indexing

**Date captured:** 2026-03-22
**Source:** User observation (analysis-concepts session)

---

## FINDING-2026-03-22-2

**Topic:** Practical application - terms as semantic indexing tool

**Observation:**
Using the GitHub API domain as a test case demonstrates the utility of terms-based indexing. By systematically extracting semantic terms (Pull Request, Review Thread, REST API, Head Branch, Base Branch, Repository Configuration, Compliance Gate) rather than raw keywords, we create a meaningful taxonomy that:

1. **Enables navigation**: Each term has related terms, creating a web of concepts
2. **Supports documentation**: Definitions connect to source materials and examples
3. **Organizes knowledge**: Terms can be grouped by category (GitHub Concepts, API Patterns, Configuration, etc.)
4. **Preserves context**: Each term includes attributes, synonyms, and related concepts

**Contrast with keyword approach:**
- Keyword: "pull", "request", "PR" → no semantic relationship, no context
- Term: "Pull Request (PR)" → complete definition, attributes, relationships, examples

**Indexing benefit:**
Terms enable hierarchical organization; keywords are flat links without meaningful structure.

**Date captured:** 2026-03-22
**Source:** Analytical research on github-api topic (github-devops skill examination)
**Clarifies:** FINDING-2026-03-22-1

---

## FINDING-2026-03-22-3

**Topic:** Term definition standards - fine-grained scope

**Observation:**
Terms must define **fine-grained concepts with singular scope**. This means:

**INCORRECT approach:**
- Term: "REST API / GraphQL API"
- Problem: Bundles two distinct concepts; lacks singular focus

**CORRECT approach:**
- Parent term: "GitHub API" – the umbrella concept
- Specific terms: "GitHub REST API", "GitHub GraphQL API" – GitHub-specific implementations
- General terms: "REST API", "GraphQL API" – general principles (defined independently)

**Principle:**
Each term should define ONE coherent concept. When multiple concepts show a hierarchy or relationship, create separate terms at each level of specificity rather than bundling them.

**Benefits of fine-grained terms:**
- Each term is independently searchable and referenceable
- Hierarchies emerge naturally (parent → specific implementations)
- Cross-domain applicability (REST API applies beyond GitHub)
- Prevents conflation of distinct concepts

**Date captured:** 2026-03-22
**Source:** User feedback on github-api term extraction methodology
