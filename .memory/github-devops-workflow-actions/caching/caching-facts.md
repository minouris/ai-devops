# GitHub DevOps Workflow Actions — Caching and Performance - Facts

**Topic:** github-devops-workflow-actions / Subtopic: caching

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** GitHub Actions cache restoration and key matching mechanism

**Introduces terms:** [Cache restoration algorithm](../github-devops-workflow-actions-terms.md#cache-restoration-algorithm)

**Observation:**

Cache uses tiered search: exact key match → partial restore-keys match → cache miss. `actions/cache@v4` requires `key` and `path`. Optional: `restore-keys`, `enableCrossOsArchive`. `cache-hit` output indicates exact match found.

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Cache scope, branch access hierarchy, and isolation in GitHub Actions

**Introduces terms:** [Cache scope isolation](../github-devops-workflow-actions-terms.md#cache-scope-isolation)

**Observation:**

Hierarchical cache access: workflows access current/default branch caches; PRs access base branch caches; cannot access child/sibling branch caches. PR caches isolated per PR. 10 GB default quota; evicted LRU.

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Automatic dependency caching via setup-* actions and security considerations

**Uses terms:** [Automatic caching via setup actions](../github-devops-workflow-actions-terms.md#automatic-caching-via-setup-actions)

**Observation:**

Setup actions (`actions/setup-node`, etc.) provide automatic caching via `cache` parameter. Detects lock files, creates keys, restores transparently. Security risks: read access → cache contents visible; never store credentials/secrets.

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

**Topic:** GitHub cache action inputs, outputs, and advanced configuration options

**Introduces terms:** [`cache-hit` output](../github-devops-workflow-actions-terms.md#cache-hit-output)

**Observation:**

Cache action outputs `cache-hit`: 'true' (exact match), 'false' (partial match), empty string (miss). Advanced options: `enableCrossOsArchive`, `fail-on-cache-miss`, `lookup-only`. Enables conditional skipping expensive builds.

**Source:** [GitHub Actions Cache Action Repository](https://github.com/actions/cache)

**Date captured:** 2026-04-08

---
