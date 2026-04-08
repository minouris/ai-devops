# GitHub Workflow Issues Integrations - Fact File

**Topic:** github-workflow-issues-integrations

**Status:** Research in progress

---

## FINDING-2026-04-08-1

**Topic:** Triggering workflows on GitHub issue events

**Introduces terms:** [`issues` event](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#issues-event), [Issue activity types](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#issue-activity-types)

**Observation:**

The `issues` event in GitHub Actions triggers workflows when issues in the repository are created or modified. The event fires for multiple activity types representing different issue lifecycle changes:

**Supported activity types:**
- Creation & Modification: `opened`, `edited`, `deleted`
- State Changes: `closed`, `reopened`
- Assignments: `assigned`, `unassigned`
- Organization: `labeled`, `unlabeled`, `pinned`, `unpinned`, `transferred`
- Milestone: `milestoned`, `demilestoned`
- Additional: `locked`, `unlocked`, `typed`, `untyped`

**Default behaviour:**
By default, workflows are triggered by all activity type events. To limit triggering to specific events, use the `types` keyword in the workflow configuration.

**Configuration example to trigger only on issue creation:**
```yaml
on:
  issues:
    types: [opened]
```

**Configuration example for multiple event types:**
```yaml
on:
  issues:
    types: [opened, edited, milestoned]
```

**Critical requirement:**
The workflow file must exist on the repository's default branch for the issue event to trigger the workflow.

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Configuring permissions for issue operations in workflow jobs

**Introduces terms:** [`issues: write` permission](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#issues-write-permission), [`issues: read` permission](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#issues-read-permission)

**Observation:**

The `issues` permission in GitHub Actions workflow jobs controls access to repository issues. Permissions can be configured at workflow level or job level, with job-level settings overriding workflow-level settings.

**Permission levels:**
- **`issues: write`** — Allows both reading and writing to issues; includes full read access
- **`issues: read`** — Allows reading issue data only
- **`issues: none`** — Removes all issue access (explicit denial)

**Configuration at workflow level:**
```yaml
permissions:
  issues: write
```

**Configuration at job level:**
```yaml
jobs:
  my_job:
    permissions:
      issues: write
```

**Key details:**
- Writing includes reading: `issues: write` provides both read and write access
- Default permissions: Any permissions not explicitly specified default to `none`
- Minimal by default: Job-level permissions override workflow-level permissions, enabling granular control
- Use case example: An action adding a comment to an issue requires `issues: write` permission

**Source:** [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Issue data available in GitHub Actions workflows

**Introduces terms:** [`github.event.issue` context object](../github-devops-workflow-actions/github-devops-workflow-actions-terms.md#githubeeventissue-context-object)

**Observation:**

When a GitHub Actions workflow is triggered by the `issues` event, issue data is available through the `github.event.issue` object in the workflow context.

**Known accessible properties:**
- **`github.event.issue.number`** — The issue number (explicitly documented with example usage)
- **`github.event.issue.pull_request`** — Available for differentiating between issues and pull requests

**Implied availability (referenced but not detailed in workflow syntax documentation):**
The GitHub Actions documentation references the GraphQL API Issue object and REST API endpoints for issues for comprehensive field documentation. This indicates that additional properties exist on the issue object (such as title, body, author, labels, state, assignees, milestones, etc.) but the complete set of accessible workflow context properties is not enumerated in the workflow triggering documentation.

**Documentation structure:**
- Workflow-level issue access documented in Events that Trigger Workflows
- Complete issue schema documented in REST API and GraphQL API references
- Properties accessible in workflow context inferred from API schema

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows); [REST API — Issues](https://docs.github.com/en/rest/issues)

**Date captured:** 2026-04-08

---

