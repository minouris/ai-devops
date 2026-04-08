# GitHub Actions Scope - Topic Index

**Topic Slug:** github-actions-scope

**Topic Name:** GitHub Actions Scope and Working Copy Access

**Created:** 2026-04-09

---

## Knowledge Summary

Research into the execution scope of GitHub Actions workflows and whether runners have default access to a working copy of the current branch.

---

## Research Areas

- Runner scope and limitations
- Default filesystem access and working directory
- Checkout requirements and default behavior
- Branch/ref availability in workflows
- File system permissions and isolation

---

## Key Concepts

- **Runner** — Hosted or self-hosted machine that executes workflow jobs
- **Working directory** — Default filesystem location where jobs execute
- **Checkout** — Action to retrieve repository files into the runner environment
- **Branch scope** — Whether runners know about current branch context

---

## Research Progress

**Total Findings Captured:** 3

| Finding | Topic | Status |
|---------|-------|--------|
| FINDING-2026-04-09-1 | Default working directory (GITHUB_WORKSPACE) | Captured |
| FINDING-2026-04-09-2 | Repository code availability and checkout requirement | Captured |
| FINDING-2026-04-09-3 | Branch context availability | Captured (incomplete) |

**Files:**
- Main facts: [github-actions-scope-facts.md](github-actions-scope-facts.md)
- Operation log: [github-actions-scope-log.md](github-actions-scope-log.md)

**Status:** Research in progress

---

## Key Findings Summary

**Default Working Directory:**
- `GITHUB_WORKSPACE` environment variable points to default working directory
- Example path: `/home/runner/work/my-repo-name/my-repo-name`
- Available on all runners, but initially empty

**Repository Code Access:**
- **NOT available by default** — Runners do NOT have repository code on startup
- **Requires explicit checkout** — `actions/checkout` action must be used to fetch and place repository code in `$GITHUB_WORKSPACE`
- Runners start as freshly-provisioned VMs with only system tools and preinstalled software

**Scope:** Runners can access `$GITHUB_WORKSPACE` and system tools by default. Repository access requires checkout.

---
