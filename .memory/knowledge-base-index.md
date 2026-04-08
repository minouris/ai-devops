# Knowledge Base Index

**Last Updated:** 2026-04-07

---

## Quick Search Guide

Use this index to locate knowledge relevant to your task:

| If you need... | See Topic | Key Findings |
|---|---|---|
| Triggering Claude agent on GitHub issue events | [github-workflow-actions-issues](#github-workflow-actions-issues) | Trigger config, permission requirements |
| Running a Copilot prompt as a GitHub Actions workflow | [github-workflow-agent-actions](#github-workflow-agent-actions) | Authentication, CLI invocation |
| Specifying model in Copilot CLI | [copilot-cli-agent-modes](#copilot-cli-agent-modes) | `--model=<model>` flag, config methods |
| Triggering workflows on issues and providing issue tools | [github-workflow-issues-integrations](#github-workflow-issues-integrations) | Issue events, permissions, R/W access |
| Installing and authenticating GitHub CLI in workflows | [github-workflow-devops](#github-workflow-devops) | CLI installation, authentication, GITHUB_TOKEN |
| Filtering jobs based on issue labels | [github-workflow-issue-filtering](#github-workflow-issue-filtering) | Job conditionals, label presence checks |
| Caching environments in GitHub Actions | [github-agents-caching](#github-agents-caching) | Caching strategies, dependency management |

---

## Topic Directories

### GitHub Workflow Actions Issues

**Knowledge Summary:**

Research into triggering a GitHub Actions workflow that runs a Claude Code skill via the GitHub Claude agent when a GitHub issue is created. Covers the `issues` event trigger, the `anthropics/claude-code-action` runner, required permissions, and how to target a specific skill.

**Quick Links:**
- Full index: [github-workflow-actions-issues-index.md](github-workflow-actions-issues/github-workflow-actions-issues-index.md)
- Main facts: [github-workflow-actions-issues-facts.md](github-workflow-actions-issues/github-workflow-actions-issues-facts.md)

**Research Areas:**
- GitHub Actions issue event trigger (0 verified findings)
- Claude Code Action configuration (0 verified findings)
- Issue read/write permissions (0 verified findings)

**Key Concepts:**
- `issues` event — GitHub Actions event that fires on issue lifecycle changes
- `anthropics/claude-code-action` — GitHub Action that runs Claude Code with a given prompt or skill

### GitHub Workflow Agent Actions

**Knowledge Summary:**

Research into executing GitHub Copilot prompts via Claude Code as GitHub Actions workflow actions. Focuses on authentication, skill invocation, and integration with GitHub Copilot's Claude Agent SDK for automated workflows.

**Quick Links:**
- Full index: [github-workflow-agent-actions-index.md](github-workflow-agent-actions/github-workflow-agent-actions-index.md)
- Main facts: [github-workflow-agent-actions-facts.md](github-workflow-agent-actions/github-workflow-agent-actions-facts.md)

**Research Areas:**
- Copilot prompt execution in GitHub Actions (0 verified findings)
- Authentication mechanisms for Copilot workflows (0 verified findings)
- Skill invocation strategies (0 verified findings)

**Key Concepts:**
- `anthropics/claude-code-action` — GitHub Action for running Claude Code
- **GitHub Copilot Agent SDK** — Project authentication mechanism
- **Prompt invocation** — Executing Copilot prompts in automated workflows

### GitHub Copilot CLI Agent Modes

**Knowledge Summary:**

Research into specifying AI models with GitHub Copilot CLI via the `--model=<model>` flag. Focuses on configuration methods (CLI flag, environment variable, config file), model selection priority, and available Copilot-provided models.

**Quick Links:**
- Full index: [copilot-cli-agent-modes-index.md](copilot-cli-agent-modes/copilot-cli-agent-modes-index.md)
- Main facts: [copilot-cli-agent-modes-facts.md](copilot-cli-agent-modes/copilot-cli-agent-modes-facts.md)

**Research Areas:**
- Model specification via `--model` flag (1 verified finding)
- Configuration methods: CLI, environment, config file (1 verified finding)
- Available Copilot models (1 verified finding)
- Model selection priority (1 verified finding)

**Key Concepts:**
- **`--model=<model>` flag** — CLI option to specify which AI model to use
- **`COPILOT_MODEL` environment variable** — Configure model via environment
- **`~/.copilot/config.json`** — Persistent model configuration file
- **Available models** — claude-haiku-4.5, claude-sonnet-4.6, gpt-5.3-codex, gpt-5.2 (examples)

---

### GitHub Workflow Issues Integrations

**Knowledge Summary:**

Research into triggering GitHub Actions workflows when GitHub issues are created, and providing necessary permissions and tools for workflow actions to read and write issues. Covers issue event triggers, permission configuration, and issue data access.

**Quick Links:**
- Full index: [github-workflow-issues-integrations-index.md](github-workflow-issues-integrations/github-workflow-issues-integrations-index.md)
- Main facts: [github-workflow-issues-integrations-facts.md](github-workflow-issues-integrations/github-workflow-issues-integrations-facts.md)

**Research Areas:**
- Issue event triggers (0 verified findings)
- Permission configuration (0 verified findings)
- Issue read/write operations (0 verified findings)

**Key Concepts:**
- **Issues event** — GitHub Actions trigger for issue lifecycle changes
- **Issue permissions** — `issues: read` and `issues: write` for workflow jobs
- **GITHUB_TOKEN** — Token available in workflows with issue scope

---

### GitHub Workflow DevOps

**Knowledge Summary:**

Research into installing and authenticating the GitHub CLI tool within GitHub Actions workflows, enabling actions to use GitHub CLI commands for repository operations.

**Quick Links:**
- Full index: [github-workflow-devops-index.md](github-workflow-devops/github-workflow-devops-index.md)
- Main facts: [github-workflow-devops-facts.md](github-workflow-devops/github-workflow-devops-facts.md)

**Research Areas:**
- GitHub CLI installation in workflows (0 verified findings)
- Authentication methods (0 verified findings)
- GITHUB_TOKEN usage (0 verified findings)

**Key Concepts:**
- **GitHub CLI** — Command-line interface for GitHub
- **Installation in workflows** — Methods to install gh tool
- **GITHUB_TOKEN** — Automatic authentication token
- **Authentication** — Configuring gh for workflow use

---

### GitHub Workflow Issue Filtering

**Knowledge Summary:**

Research into using GitHub Actions job filtering and conditionals to determine whether specific labels are present or absent on issues, enabling conditional job execution based on issue labels.

**Quick Links:**
- Full index: [github-workflow-issue-filtering-index.md](github-workflow-issue-filtering/github-workflow-issue-filtering-index.md)
- Main facts: [github-workflow-issue-filtering-facts.md](github-workflow-issue-filtering/github-workflow-issue-filtering-facts.md)

**Research Areas:**
- Job-level conditionals (0 verified findings)
- Issue label data access (0 verified findings)
- Conditional syntax for labels (0 verified findings)

**Key Concepts:**
- **Job filtering** — Using `if` conditions to control job execution
- **Issue labels** — Label data available in issue events
- **Conditional expressions** — GitHub Actions expressions for decision logic

---

### GitHub Agents Caching

**Knowledge Summary:**

Research into caching strategies for environments and dependencies constructed within GitHub Actions workflows, optimizing CI/CD pipeline performance through artifact reuse across runs.

**Quick Links:**
- Full index: [github-agents-caching-index.md](github-agents-caching/github-agents-caching-index.md)
- Main facts: [github-agents-caching-facts.md](github-agents-caching/github-agents-caching-facts.md)

**Research Areas:**
- Caching mechanisms in GitHub Actions (1 verified finding)
- Dependency and environment caching (2 verified findings)
- Cache scope and management (1 verified finding)

**Key Concepts:**
- **Caching** — Storing and reusing artifacts across workflow runs
- **Dependency management** — Node modules, packages, build outputs
- **Environment setup** — Pre-constructed runtime environments

---## Central Index Maintenance Log

| Date | Topic | Action | Details |
|---|---|---|---|
| 2026-04-07 | All | knowledge-base-index.md created | Initial knowledge base bootstrap |
| 2026-04-07 | github-workflow-actions-issues | Topic added | Research: trigger action for Claude skill on issue creation |
| 2026-04-08 | github-workflow-agent-actions | Topic added | Research: running Copilot prompts in GitHub Actions workflows |
| 2026-04-08 | copilot-cli-agent-modes | Topic added | Research: specifying models in Copilot CLI |
| 2026-04-08 | github-workflow-issues-integrations | Topic added | Research: triggering workflows on issues and providing issue tools |
| 2026-04-08 | github-workflow-devops | Topic added | Research: install and authenticate GitHub CLI in workflows |
| 2026-04-08 | github-workflow-issue-filtering | Topic added | Research: using job filtering to check issue labels |
| 2026-04-08 | github-agents-caching | Topic added | Research: cache environments constructed for GitHub Actions |

---
