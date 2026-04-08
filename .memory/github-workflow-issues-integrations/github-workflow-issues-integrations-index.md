# GitHub Workflow Issues Integrations - Topic Index

**Topic Slug:** github-workflow-issues-integrations

**Topic Name:** Triggering workflows on GitHub issues and providing issue R/W tools to workflow actions

**Created:** 2026-04-08

---

## Knowledge Summary

Research into triggering GitHub Actions workflows when GitHub issues are created, and providing necessary permissions and tools for workflow actions to read and write issues.

---

## Research Areas

- Issue event triggers in GitHub Actions (created, opened, labeled, etc.)
- Permission configuration for issue operations
- Reading issue data (number, title, body, author, etc.)
- Writing to issues (comments, labels, state changes)
- Tool access and restrictions in workflow jobs

---

## Key Concepts

- **Issues event** — GitHub Actions trigger for issue lifecycle changes
- **Issue permissions** — `issues: read` and `issues: write` for workflow jobs
- **GitHub token context** — `GITHUB_TOKEN` available in workflows with issue scope
- **Workflow job permissions** — Configuration of allowed operations per job
- **Issue object** — Available data from triggered issue (number, title, body, user, etc.)

---

## Navigation

- Main facts: [github-workflow-issues-integrations-facts.md](github-workflow-issues-integrations-facts.md)
- Operation log: [github-workflow-issues-integrations-log.md](github-workflow-issues-integrations-log.md)

---
