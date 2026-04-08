# GitHub Agents Caching - Fact File

**Topic:** github-agents-caching

**Status:** Research in progress

---

## FINDING-2026-04-08-1

**Topic:** GitHub Actions cache restoration and key matching mechanism

**Observation:**

GitHub Actions caches use a tiered search algorithm to restore cached artifacts. When a workflow step requests a cache restoration, the system searches using a priority-based approach that balances exact matches against partial matches.

**Cache restoration sequence:**
1. Exact key match — The system first searches for a cache with the exact key provided
2. Partial key match — If no exact match is found, it searches partial matches of the key
3. Cache miss — If no matches are found, the workflow continues and creates a new cache after the job completes successfully

**Configuration requirements:**

The GitHub Actions `cache` action requires two mandatory inputs:

```yaml
- uses: actions/cache@v4
  with:
    key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
    path: ~/.npm
```

- **`key`** — Unique identifier for the cache (max 512 characters); supports variables and functions
- **`path`** — Directory or files to cache; supports glob patterns and relative/absolute paths

**Optional parameters:**
- `restore-keys` — Array of alternative keys (ordered from most to least specific) to use if primary key doesn't match
- `enableCrossOsArchive` — Boolean flag allowing cache sharing across different operating systems

**Cache outcome:**
The action outputs a `cache-hit` boolean indicating whether an exact match was found. This allows workflows to skip expensive build steps when caches are reused.

**Dynamic cache keys:**
Best practice is to use expressions like `hashFiles('package-lock.json')` to automatically invalidate caches when dependency files change, ensuring cache freshness without manual intervention.

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Cache scope, branch access hierarchy, and isolation in GitHub Actions

**Observation:**

GitHub Actions implements a deliberate cache scope architecture that controls which workflows can access which caches. The scope is hierarchical, based on branch relationships and pull request context, with implications for both functionality and security.

**Branch-level access hierarchy:**

The cache access model follows a directional hierarchy from upstream to downstream:

| Access Context | Can Access | Cannot Access | Scope |
|---|---|---|---|
| Current branch workflow run | Current branch caches | Child/sibling branch caches | Unidirectional from main down |
| Default branch (main) | Main branch caches | Feature branch caches | Parent scope only |
| Pull request workflow run | Base branch caches + PR caches | Unrelated branch caches | PR base + PR-specific only |

**Key scope rules:**
- Workflow runs can restore caches created in the current branch OR the default branch (usually `main`)
- Pull request-triggered workflows can ALSO restore caches created in the base branch
- Workflow runs CANNOT restore caches from child branches or sibling branches
- Each tag operates as an independent cache namespace

**Pull request cache isolation:**

Pull request-triggered workflows have restricted cache scope: "PR-triggered caches can only be restored by re-runs of the same pull request." This temporal and contextual boundary prevents cache leakage between PRs.

**Cross-workflow cache sharing:**

Within a single repository and branch, multiple workflows can access shared caches. This enables resource efficiency where different jobs in the same environment reuse built dependencies and artifacts.

**Security implications:**

This hierarchical isolation architecture intentionally compartmentalizes cache access to reduce information leakage between branches. By preventing sibling and child branch access, the system limits exposure from potentially concurrent malicious development work. Each branch and tag operates independently, further segmenting the cache namespace.

**Storage quota:**

Repositories default to 10 GB maximum cache storage. When quota is exceeded, caches are automatically evicted based on access recency (least recently accessed caches are deleted first).

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-3

**Topic:** Automatic dependency caching via setup-* actions and security considerations

**Observation:**

GitHub Actions provides automatic caching for common dependency managers through specialized setup actions. These actions eliminate the need for manual cache configuration for popular languages and package managers, while caches present specific security considerations.

**Automatic caching via setup actions:**

Language-specific setup actions (`actions/setup-node`, `actions/setup-python`, `actions/setup-java`, etc.) include built-in automatic caching of package manager artifacts:

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '18'
    cache: 'npm'  # Automatically caches node_modules based on package-lock.json
```

When the `cache` parameter is enabled on a setup action, it automatically:
- Detects package manager lock files (package-lock.json, yarn.lock, etc.)
- Creates cache keys based on lock file contents
- Restores or creates caches transparently

**Cache security considerations:**

Public repositories and pull requests present security risks with caches:

- **Read access exposure** — "Anyone with read access can create a pull request on a repository and access the contents of a cache"
- **Sensitive data storage** — Caches should NOT contain secrets, credentials, API keys, or personal data
- **Cross-PR leakage** — Pull request caches are isolated, but base branch caches are visible to PR workflows

**Best practices:**
- Use setup-* actions for automatic, safe dependency caching
- Never store credentials or secrets in caches
- Monitor cache storage usage to avoid eviction during critical builds
- Use specific restore-keys strategy to optimize cache hit rates
- Use environment-specific cache keys when dependencies vary by OS or architecture

**Source:** [GitHub Docs — Caching dependencies to speed up workflows](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-4

**Topic:** GitHub cache action inputs, outputs, and advanced configuration options

**Observation:**

The GitHub cache action (`actions/cache@v4`) provides comprehensive configuration options beyond basic key and path parameters. These advanced options enable fine-grained control over cache behaviour, cross-platform compatibility, and error handling.

**Complete action inputs:**

```yaml
- uses: actions/cache@v4
  with:
    key: ${{ runner.os }}-build-${{ github.run_id }}
    path: ./build
    restore-keys: |
      ${{ runner.os }}-build-
      ${{ runner.os }}-
    enableCrossOsArchive: false
    fail-on-cache-miss: false
    lookup-only: false
```

**Input parameters:**

- **`key`** (required) — Explicit cache identifier; typically includes OS, dependencies, and hash values
- **`path`** (required) — Files, directories, and glob patterns to cache and restore
- **`restore-keys`** — Ordered multiline list of alternative key patterns for partial matching (most to least specific)
- **`enableCrossOsArchive`** — Boolean flag (default: `false`); when `true`, allows Windows runners to share caches with other OS runners
- **`fail-on-cache-miss`** — Boolean flag (default: `false`); when `true`, workflow fails if cache restoration doesn't produce exact match
- **`lookup-only`** — Boolean flag (default: `false`); when `true`, checks cache existence without downloading content

**Action outputs:**

- **`cache-hit`** — String output with three possible values:
  - `'true'` — Exact key match found (cache restored)
  - `'false'` — Partial match found using restore-keys (restore-keys partial match)
  - Empty string `''` — No cache found (miss)

**Environment variables for tuning:**

- **`SEGMENT_DOWNLOAD_TIMEOUT_MINS`** — Cache segment download timeout in minutes (default: `10` minutes)

**Platform requirements:**

- Minimum Actions Runner version: 2.327.1
- Node.js 24 for action execution
- Self-hosted Windows runners: GNU tar and zstd recommended for optimal cross-OS caching performance

**Use case patterns:**

The `cache-hit` output enables conditional job steps:

```yaml
- uses: actions/cache@v4
  id: cache
  with:
    key: ${{ runner.os }}-npm-${{ hashFiles('package-lock.json') }}
    path: node_modules

- run: npm ci
  if: steps.cache.outputs.cache-hit != 'true'
```

This pattern skips expensive dependency installation if cache was restored.

**Source:** [GitHub Actions Cache Action Repository](https://github.com/actions/cache)

**Date captured:** 2026-04-08

---

