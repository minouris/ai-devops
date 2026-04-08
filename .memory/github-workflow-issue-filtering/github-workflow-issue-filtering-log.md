# GitHub Workflow Issue Filtering - Operation Log

**Topic:** github-workflow-issue-filtering

**Session started:** 2026-04-08

## Operations

### OP-2026-04-08-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-workflow-issue-filtering-index.md` - Topic index initialised
- `github-workflow-issue-filtering-log.md` - This log
- `github-workflow-issue-filtering-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: Using job filtering conditionals to check issue labels

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-002: Documentation research on job filtering for labels

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-workflow-issue-filtering-facts.md` - Added FINDING-2026-04-08-1

**Key findings captured:**
- FINDING-2026-04-08-1: Using `contains(github.event.issue.labels.*.name, 'label-name')` in job `if` conditions to filter based on label presence
- Case-insensitive matching
- Negation syntax for checking label absence

**Source:**
- GitHub Docs: Expressions

**Key insight:**
Job-level `if` conditions can use the `contains()` function with the `github.event.issue.labels.*.name` expression to perform label-based filtering. This answers the user's question: yes, workflows can execute conditionally based on specific labels being present or absent.

**Timestamp:** 2026-04-08

---
