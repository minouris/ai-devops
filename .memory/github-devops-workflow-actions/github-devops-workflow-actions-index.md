# GitHub DevOps Workflow Actions - Index

## Knowledge Summary

**Overview:** Systematic documentation of GitHub Actions workflow configuration, Copilot CLI automation, issue trigger mechanisms, label-based job filtering, caching strategies, and runner environment scope.

**Research Domains:** Workflow automation, GitHub Actions event handling, Copilot CLI integration, permission management, dependency caching, runner provisioning

**Core Terminology:** Workflow events, Copilot CLI invocation, issue permissions, label filtering, cache restoration, environment variables, custom actions, workflow files

**Verification Status:**
- Verified: 0 findings
- Unverified: 27 findings
- Disproven: 0 findings
- **Status:** Active research — terms extracted, findings pending verification

**Total Findings:** 27

**Last Updated:** 2026-04-09

---

**Topic:** github-devops-workflow-actions

## Fact Files

- `github-devops-workflow-actions-terms.md` - Semantic terms index (27 pending terms)

## Findings

| Finding | Topic | Name | Terms |
|---------|-------|------|-------|
| [FINDING-2026-04-08-1](./github-devops-workflow-actions-facts.md#finding-2026-04-08-1) | Custom Actions | GitHub Actions overview and custom actions | [Custom actions](#custom-actions) |
| [FINDING-2026-04-08-2](./github-devops-workflow-actions-facts.md#finding-2026-04-08-2) | Workflow Syntax | GitHub Workflow file structure and core properties | [Workflow file](#workflow-file) |
| [FINDING-2026-04-08-3](./github-devops-workflow-actions-facts.md#finding-2026-04-08-3) | Event Triggers | Event triggers and custom inputs in workflows | [Event triggers](#event-triggers), [Workflow_dispatch trigger](#workflow_dispatch-trigger) |
| [FINDING-2026-04-08-4](./github-devops-workflow-actions-facts.md#finding-2026-04-08-4) | Command Execution | Executing commands in workflow steps | [Run keyword](#run-keyword) |
| [FINDING-2026-04-08-5](./github-devops-workflow-actions-facts.md#finding-2026-04-08-5) | Step Configuration | Invoking custom actions and passing inputs to steps | [Uses keyword](#uses-keyword), [Steps](#steps) |
| [FINDING-2026-04-08-6](./github-devops-workflow-actions-facts.md#finding-2026-04-08-6) | AI Integration | GitHub Copilot functionality and GitHub integration | [GitHub Copilot](#github-copilot) |
| [FINDING-2026-04-08-7](./github-devops-workflow-actions-facts.md#finding-2026-04-08-7) | Copilot Automation | Running GitHub Copilot CLI in GitHub Actions workflows | [Copilot CLI invocation](#copilot-cli-invocation), [`--no-ask-user` flag](#--no-ask-user-flag), [`COPILOT_GITHUB_TOKEN` environment variable](#copilot_github_token-environment-variable), [npm installation of Copilot CLI](#npm-installation-of-copilot-cli) |
| [FINDING-2026-04-08-8](./github-devops-workflow-actions-facts.md#finding-2026-04-08-8) | Model Configuration | Specifying model in Copilot CLI for GitHub Actions workflows | [`--model` flag](#--model-flag), [`COPILOT_MODEL` environment variable](#copilot_model-environment-variable), [Model selection priority](#model-selection-priority) |
| [FINDING-2026-04-09-1](./github-devops-workflow-actions-facts.md#finding-2026-04-09-1) | Custom Instructions | Custom instructions configuration for Copilot CLI | [Custom instructions](#custom-instructions) |
| [FINDING-2026-04-09-2](./github-devops-workflow-actions-facts.md#finding-2026-04-09-2) | Instructions Directory | Specifying custom instructions directories for Copilot CLI | [Custom instructions](#custom-instructions), [`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable](#copilot_custom_instructions_dirs-environment-variable) |
| [FINDING-2026-04-08-1](./github-devops-workflow-actions-facts.md#finding-2026-04-08-1) | GitHub CLI | GitHub CLI preinstallation and setup requirement | [GitHub CLI preinstallation](#github-cli-preinstallation) |
| [FINDING-2026-04-08-2](./github-devops-workflow-actions-facts.md#finding-2026-04-08-2) | CLI Authentication | Authenticating GitHub CLI with GH_TOKEN in workflows | [`GH_TOKEN` environment variable](#gh_token-environment-variable), [`GITHUB_TOKEN` automatic token](#github_token-automatic-token) |
| [FINDING-2026-04-08-3](./workflow-execution/workflow-execution-facts.md#finding-2026-04-08-3) | CLI Installation | Copilot CLI installation requirement vs GitHub CLI preinstallation | [npm installation of Copilot CLI](#npm-installation-of-copilot-cli) |
| [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) | Issue Events | Triggering workflows on GitHub issue events | [`issues` event](#issues-event), [Issue activity types](#issue-activity-types) |
| [FINDING-2026-04-08-2](./issue-handling/issue-handling-facts.md#finding-2026-04-08-2) | Issue Permissions | Configuring permissions for issue operations in workflow jobs | [`issues: write` permission](#issues-write-permission), [`issues: read` permission](#issues-read-permission) |
| [FINDING-2026-04-08-3](./issue-handling/issue-handling-facts.md#finding-2026-04-08-3) | Issue Context | Issue data available in GitHub Actions workflows | [`github.event.issue` context object](#githubeeventissue-context-object) |
| [FINDING-2026-04-08-1](./issue-handling/issue-handling-facts.md#finding-2026-04-08-1) | Label Filtering | Using contains() function to filter jobs based on issue labels | [`contains()` function](#contains-function), [Label filtering](#label-filtering) |
| [FINDING-2026-04-08-1](./caching/caching-facts.md#finding-2026-04-08-1) | Cache Mechanism | GitHub Actions cache restoration and key matching mechanism | [Cache restoration algorithm](#cache-restoration-algorithm) |
| [FINDING-2026-04-08-2](./caching/caching-facts.md#finding-2026-04-08-2) | Cache Scope | Cache scope, branch access hierarchy, and isolation in GitHub Actions | [Cache scope isolation](#cache-scope-isolation) |
| [FINDING-2026-04-08-3](./caching/caching-facts.md#finding-2026-04-08-3) | Automatic Caching | Automatic dependency caching via setup-* actions and security considerations | [Automatic caching via setup actions](#automatic-caching-via-setup-actions) |
| [FINDING-2026-04-08-4](./caching/caching-facts.md#finding-2026-04-08-4) | Cache Action | GitHub cache action inputs, outputs, and advanced configuration options | [`cache-hit` output](#cache-hit-output) |
| [FINDING-2026-04-09-1](./runner-environment/runner-environment-facts.md#finding-2026-04-09-1) | Runner Environment | GitHub Actions runner environment and default working directory | [`GITHUB_WORKSPACE` environment variable](#github_workspace-environment-variable) |
| [FINDING-2026-04-09-2](./runner-environment/runner-environment-facts.md#finding-2026-04-09-2) | Repository Access | Repository code availability and checkout requirement | [`actions/checkout` action](#actionscheckout-action), [GitHub-hosted runner provisioning](#github-hosted-runner-provisioning), [Preinstalled software on runners](#preinstalled-software-on-runners) |
| [FINDING-2026-04-09-3](./runner-environment/runner-environment-facts.md#finding-2026-04-09-3) | Branch Context | GitHub Actions scope regarding branch context and ref information | [GitHub context object](#github-context-object) |
