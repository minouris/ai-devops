# GitHub Actions Scope - Operation Log

**Topic:** github-actions-scope

**Session started:** 2026-04-09

## Operations

### OP-2026-04-09-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-actions-scope-index.md` - Topic index initialised
- `github-actions-scope-log.md` - This log
- `github-actions-scope-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: GitHub Actions scope and default working copy access

**Timestamp:** 2026-04-09

---

### OP-2026-04-09-002: Procedural research — runner scope and repository access

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-actions-scope-facts.md` - Added FINDING-2026-04-09-1, 2, 3

**Key findings:**
- FINDING-2026-04-09-1: `GITHUB_WORKSPACE` is the default working directory (path like `/home/runner/work/my-repo-name/my-repo-name`)
- FINDING-2026-04-09-2: Repository code is NOT available by default; `actions/checkout` is required
- FINDING-2026-04-09-3: Branch context requires further investigation

**Critical discovery:**
Runners are freshly-provisioned VMs with only system tools and preinstalled software. Repository code is NOT automatically available—the `actions/checkout` action must be explicitly included in workflow steps to access repository files.

**Research approach:**
- Consulted GitHub hosted runners documentation
- Reviewed actions/checkout documentation
- Searched variables reference for `GITHUB_WORKSPACE` definition
- Attempted to find documentation on branch context availability

**Gaps identified:**
- Branch/ref context availability not explicitly documented
- Runner scope regarding file access outside GITHUB_WORKSPACE not documented
- Whether all system files are accessible not clearly specified

**Next steps:**
- Investigate `github` context variables for event and ref information
- Determine runner file system scope and permissions
- Clarify branch availability without explicit checkout

**Timestamp:** 2026-04-09

---
