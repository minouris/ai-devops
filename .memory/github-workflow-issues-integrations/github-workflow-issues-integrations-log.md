# GitHub Workflow Issues Integrations - Operation Log

**Topic:** github-workflow-issues-integrations

**Session started:** 2026-04-08

## Operations

### OP-2026-04-08-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-workflow-issues-integrations-index.md` - Topic index initialised
- `github-workflow-issues-integrations-log.md` - This log
- `github-workflow-issues-integrations-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: Triggering workflows on issue creation and providing issue R/W tools

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-002: Initial documentation research on issue events and permissions

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-workflow-issues-integrations-facts.md` - Added FINDING-2026-04-08-1, 2026-04-08-2, 2026-04-08-3

**Key findings captured:**
- FINDING-2026-04-08-1: `issues` event trigger with activity types (opened, closed, labeled, etc.)
- FINDING-2026-04-08-2: Permission configuration (`issues: read` and `issues: write`) at workflow and job levels
- FINDING-2026-04-08-3: Issue data available in workflow context via `github.event.issue` object

**Sources:**
- GitHub Docs: Events that Trigger Workflows
- GitHub Docs: Workflow Syntax for GitHub Actions
- GitHub REST API: Issues

**Next steps:**
- Ready to capture additional facts from user or documentation
- May require deeper exploration of issue data schema

**Timestamp:** 2026-04-08

---
