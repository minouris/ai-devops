# Knowledge Base Index

**Last Updated:** 2026-04-09

---

## Quick Search Guide

Use this index to locate knowledge relevant to your task:

| If you need... | See Topic | Key Findings |
|---|---|---|
| Complete GitHub DevOps workflow, actions, Copilot CLI, and runner information | [github-devops-workflow-actions](#github-devops-workflow-actions) | Comprehensive workflow automation guide with 6 subtopics |

---

---

## Topic Directories

### GitHub DevOps Workflow Actions

**Knowledge Summary:**

Comprehensive research into GitHub Actions workflow automation, runner environments, and integration tools. Covers runner scoping, Copilot CLI execution, GitHub CLI tooling, issue event handling, job conditionals, performance optimization through caching, and complete workflow architecture.

**Organization:** 6 organized subtopics

**Quick Links:**
- Main index: [github-devops-workflow-actions-index.md](github-devops-workflow-actions/github-devops-workflow-actions-index.md)

**Subtopics:**
1. **Copilot CLI Configuration** — Model specification, custom instructions, command options
2. **Workflow Execution** — Running Copilot CLI in workflows, authentication, skill invocation
3. **GitHub CLI Integration** — GitHub CLI installation and authentication
4. **Issue Handling** — Issue triggers, permissions, label filtering, conditionals
5. **Caching and Performance** — Cache strategies, dependency optimization, build acceleration
6. **Runner Environment** — Runner scope, GITHUB_WORKSPACE, checkout requirements, isolation

**Key Concepts:**
- **Copilot CLI** — Direct prompt execution with `copilot -p "PROMPT" --model <model>`
- **GitHub Actions Runner** — Freshly-provisioned VMs requiring explicit checkout
- **Issue Events** — Triggered by issue lifecycle changes with label filtering support
- **Caching** — Artifact reuse across runs with tiered restoration algorithm
- **Workflow Permissions** — Granular access control for issue, content, and token scopes

---

## Central Index Maintenance Log

| Date | Topic | Action | Details |
|---|---|---|---|
| 2026-04-07 | All | knowledge-base-index.md created | Initial knowledge base bootstrap |
| 2026-04-08 | github-workflow-agent-actions | Topic added | Research: running Copilot prompts in GitHub Actions workflows |
| 2026-04-08 | copilot-cli-agent-modes | Topic added | Research: specifying models in Copilot CLI |
| 2026-04-08 | github-workflow-issues-integrations | Topic added | Research: triggering workflows on issues and providing issue tools |
| 2026-04-08 | github-workflow-devops | Topic added | Research: install and authenticate GitHub CLI in workflows |
| 2026-04-08 | github-workflow-issue-filtering | Topic added | Research: using job filtering to check issue labels |
| 2026-04-08 | github-actions-caching | Topic added | Research: cache environments constructed for GitHub Actions |
| 2026-04-08 | github-workflow-actions-issues | Topic removed | Obsolete: replaced by Copilot CLI approach, no longer relevant |
| 2026-04-09 | github-actions-scope | Topic added | Research: runner scope, working directory, repository code availability |
| 2026-04-09 | github-agents-caching | Topic renamed | Renamed to github-actions-caching for consistency |
| 2026-04-09 | github-devops-workflow-actions | Topic created | Merged 7 separate workflow/actions topics into single consolidated topic with 6 subtopics |
| 2026-04-09 | github-workflow-agent-actions, copilot-cli-agent-modes, github-workflow-issues-integrations, github-workflow-devops, github-workflow-issue-filtering, github-actions-caching, github-actions-scope | Topics merged | All rolled into github-devops-workflow-actions for unified workflow knowledge |

---
