# GitHub API - Fact File: Terms and Concepts

## FINDING-2026-03-22-1: Pull Request (PR)

**Term:** Pull Request (PR)

**Definition:** A mechanism in GitHub for proposing changes to a repository. A PR requests to merge changes from a source branch (head) into a target branch (base). PRs enable code review, discussion, and CI/CD automation before changes are integrated.

**Key attributes:**
- Has unique number identifier (`number`)
- Contains state: `open`, `closed`, `merged`
- Has HTML URL for web access
- Merges from head branch to base branch

**Related terms:** Review Thread, Head, Base

**Date captured:** 2026-03-22
**Source:** github-devops SKILL.md, create-pr.md

---

## FINDING-2026-03-22-2: Review Thread

**Term:** Review Thread

**Definition:** A conversation thread within a pull request containing code review comments. Threads group related review comments and can be marked as resolved or unresolved. Each thread has a unique ID and tracks its resolution status.

**Key attributes:**
- Thread ID (unique identifier)
- Resolution status: `isResolved` (boolean)
- Contains comments in `comments.nodes` array
- Queryable via GraphQL API

**Related terms:** Pull Request, Review Comment, Thread Resolution

**Date captured:** 2026-03-22
**Source:** github-devops fetch-review-threads.md

---

## FINDING-2026-03-22-3: GitHub API

**Term:** GitHub API

**Definition:** The umbrella interface provided by GitHub for programmatic access to repository data, pull requests, reviews, and automation. GitHub offers two API implementations: REST API (endpoint-based) and GraphQL API (query language).

**Key attributes:**
- Authentication via personal access tokens or GitHub Apps
- Multiple API versions and implementations
- Powers integrations and CI/CD automation

**Related terms:** GitHub REST API, GitHub GraphQL API, REST API, GraphQL API

**Date captured:** 2026-03-22
**Source:** github-devops SKILL.md, multiple action files

---

## FINDING-2026-03-22-4: GitHub REST API

**Term:** GitHub REST API

**Definition:** GitHub's REST (Representational State Transfer) implementation for API access. Uses HTTP methods (GET, POST, PUT, DELETE) with fixed endpoint paths. Each endpoint returns a structured response containing specific fields.

**Key attributes:**
- Endpoint-based (e.g., `/repos/{owner}/{repo}/pulls/{number}`)
- Fixed response structure (cannot specify which fields to return)
- HTTP status codes indicate success/failure
- Simpler for straightforward operations

**Example:** Creating a pull request uses GitHub REST API

**Related terms:** GitHub API, REST API, GitHub GraphQL API

**Date captured:** 2026-03-22
**Source:** github-devops create-pr.md

---

## FINDING-2026-03-22-5: GitHub GraphQL API

**Term:** GitHub GraphQL API

**Definition:** GitHub's GraphQL implementation for API access. Uses a query language to request specific data fields and nested relationships. Clients specify exactly what data they need, reducing over-fetching.

**Key attributes:**
- Query-based (declare data requirements)
- Only returns requested fields
- Single request for complex nested queries
- Better for large data structures with selective field access

**Example:** Fetching review threads with nested comments uses GitHub GraphQL API

**Related terms:** GitHub API, GraphQL API, GitHub REST API

**Date captured:** 2026-03-22
**Source:** github-devops fetch-review-threads.md

---

## FINDING-2026-03-22-6: REST API

**Term:** REST API

**Definition:** A general architectural style for web APIs using HTTP methods (GET, POST, PUT, DELETE, PATCH) to manipulate resources identified by URIs. REST APIs organize functionality around resource endpoints and use HTTP status codes for response semantics.

**Key attributes:**
- Resource-oriented (URIs represent nouns, not verbs)
- Stateless operations
- HTTP methods indicate action (verb)
- Cacheable responses (when properly configured)

**Related terms:** GraphQL API, GitHub REST API, API

**Date captured:** 2026-03-22
**Source:** General principle; GitHub implements this pattern

---

## FINDING-2026-03-22-7: GraphQL API

**Term:** GraphQL API

**Definition:** A general query language and runtime for APIs developed by Facebook. GraphQL enables clients to request exactly the data they need through a declarative query syntax, avoiding over-fetching and under-fetching problems common in REST APIs.

**Key attributes:**
- Declarative query language
- Strongly typed schema
- Single endpoint (typically `/graphql`)
- Supports nested queries and aliases
- Prevents over-fetching (request only needed fields)

**Related terms:** REST API, GitHub GraphQL API, API

**Date captured:** 2026-03-22
**Source:** General principle; GitHub implements this pattern

---

## FINDING-2026-03-22-8: Head Branch

**Term:** Head Branch

**Definition:** The source branch in a pull request containing the changes being proposed. This is the branch that will be merged into the base branch. In git terminology, `head` refers to the branch with the new commits.

**Synonyms:** source branch, feature branch

**Example:** In a PR, head: `feature-new-auth`, base: `main`

**Related terms:** Base Branch, Pull Request

**Date captured:** 2026-03-22
**Source:** github-devops create-pr.md

---

## FINDING-2026-03-22-9: Base Branch

**Term:** Base Branch

**Definition:** The target branch in a pull request that will receive the merged changes. This is typically a main integration branch like `main` or `develop`.

**Synonyms:** target branch, destination branch

**Example:** In a PR, head: `feature-new-auth`, base: `main`

**Related terms:** Head Branch, Pull Request

**Date captured:** 2026-03-22
**Source:** github-devops create-pr.md

---

## FINDING-2026-03-22-10: Repository Configuration

**Term:** Repository Configuration

**Definition:** A set of parameters defining which GitHub repository a skill or operation targets. Includes:
- `repo`: Repository identifier in format `owner/repository-name`
- `org`: Organization name (optional, for app-level operations)

**Configuration precedence:**
1. Parameters passed to skill
2. Environment variables (`GITHUB_REPO`, `GITHUB_ORG`)
3. Configuration file (config.md)

**Example values:**
- `repo: minouris/ai-devops`
- `repo: kubernetes/kubernetes`

**Date captured:** 2026-03-22
**Source:** github-devops SKILL.md, config.md

---

## FINDING-2026-03-22-11: Compliance Gate

**Term:** Compliance Gate

**Definition:** A verification checkpoint in API operations that validates the response before accepting the operation as successful. Gates verify that response structure contains required fields and expected values before proceeding.

**Example compliance checks:**
- Response exit code is 0
- JSON response contains required fields (`number`, `html_url`)
- State field has expected value (`open`)

**Purpose:** Prevents accepting incomplete or malformed API responses

**Date captured:** 2026-03-22
**Source:** github-devops create-pr.md, fetch-review-threads.md
