# GitHub Actions Caching - Operation Log

**Topic:** github-actions-caching

**Session started:** 2026-04-08

## Operations

### OP-2026-04-08-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-actions-caching-index.md` - Topic index initialised
- `github-actions-caching-log.md` - This log
- `github-actions-caching-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: Cache environments constructed for GitHub Actions

---

### OP-2026-04-08-002: Procedural research on GitHub Actions caching

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-agents-caching-facts.md` - Added FINDING-2026-04-08-1, 2026-04-08-2, 2026-04-08-3, 2026-04-08-4

**Key findings captured:**
- FINDING-2026-04-08-1: Cache restoration uses tiered key matching (exact → partial → miss); requires key and path inputs
- FINDING-2026-04-08-2: Cache scope is hierarchical by branch; main/current branch access plus base-branch for PRs; no sibling/child access
- FINDING-2026-04-08-3: Setup actions provide automatic caching for common package managers; security consideration: caches accessible to read-access users
- FINDING-2026-04-08-4: Advanced cache action inputs: fail-on-cache-miss, lookup-only, enableCrossOsArchive; outputs cache-hit status

**Supporting sources:**
- GitHub Docs: Caching dependencies to speed up workflows

**Research scope:**
Documented GitHub Actions caching mechanisms (key matching algorithm, cache scope/isolation rules, automatic caching via setup actions, security implications, and storage quota management).

**Semantic terms identified:**
- Cache key (unique identifier with dynamic expressions using hashFiles())
- Cache restoration (tiered search algorithm with exact and partial matching)
- Cache hit (exact key match or partial match found)
- Cache miss (no key match found)
- Restore keys (alternative key patterns for partial matching)
- Key rotation (dynamic cache invalidation)
- Branch scope (hierarchical access model)
- Cache isolation (PR-specific, branch-specific, tag-specific isolation)
- Automatic caching (setup-* actions)
- Cache eviction (storage quota management based on recency)
- Cross-OS caching (enableCrossOsArchive flag)
- Cache-hit output (boolean status from cache action)

**Timestamp:** 2026-04-08

---
