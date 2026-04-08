# GitHub DevOps Workflow Actions — Issue Handling and Label Filtering - Facts

**Topic:** github-devops-workflow-actions / Subtopic: issue-handling

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** Triggering workflows on GitHub issue events

**Introduces terms:** [`issues` event](../github-devops-workflow-actions-terms.md#issues-event), [Issue activity types](../github-devops-workflow-actions-terms.md#issue-activity-types)

**Observation:**

`issues` event triggers workflows for multiple activity types: opened, edited, deleted, closed, reopened, assigned, unassigned, labeled, unlabeled, pinned, unpinned, transferred, milestoned, demilestoned, locked, unlocked. Workflow file must exist on default branch to trigger.

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Configuring permissions for issue operations in workflow jobs

**Introduces terms:** [`issues: write` permission](../github-devops-workflow-actions-terms.md#issues-write-permission), [`issues: read` permission](../github-devops-workflow-actions-terms.md#issues-read-permission)

**Observation:**

Permissions configured at workflow or job level. `issues: write` allows read and write; `issues: read` allows read only; `issues: none` denies access. Job-level overrides workflow-level.

**Source:** [GitHub Actions — Workflow Syntax for GitHub Actions](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Issue data available in GitHub Actions workflows

**Introduces terms:** [`github.event.issue` context object](../github-devops-workflow-actions-terms.md#githubeeventissue-context-object)

**Observation:**

When triggered by `issues` event, issue data accessible via `github.event.issue`. Documented properties: `issue.number`, `issue.pull_request`. Full schema aligns with REST API Issue object.

**Source:** [GitHub Actions — Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

**Topic:** Using contains() function to filter jobs based on issue labels

**Introduces terms:** [`contains()` function](../github-devops-workflow-actions-terms.md#contains-function), [Label filtering](../github-devops-workflow-actions-terms.md#label-filtering)

**Observation:**

Use `contains(github.event.issue.labels.*.name, 'label-name')` in job conditionals. Case-insensitive matching. Negation: `!contains(...)` checks for label absence.

**Source:** [GitHub Actions — Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions)

**Date captured:** 2026-04-08

---
