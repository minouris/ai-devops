# GitHub API Terms

**Last Updated:** 2026-03-22 06:30
**Verified Terms:** 11
**Pending Terms:** 0

---

## Table of Contents

- [Base Branch](#base-branch)
- [GitHub API](#github-api)
- [GitHub GraphQL API](#github-graphql-api)
- [GitHub REST API](#github-rest-api)
- [GraphQL API](#graphql-api)
- [Head Branch](#head-branch)
- [Pull Request (PR)](#pull-request-pr)
- [Repository Configuration](#repository-configuration)
- [REST API](#rest-api)
- [Review Thread](#review-thread)

---

## Base Branch

**Captured:** 2026-03-22 12:00

The target branch in a pull request that will receive merged changes from the head branch.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops create-pr.md](../../../.claude/skills/github-devops/actions/create-pr.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#base-branch) |

### Description

The Base Branch is the destination branch in a GitHub pull request that will receive the changes being proposed from the head branch. This is typically a main integration branch such as `main` or `develop`. The base branch represents the "stable" state that new work will be merged into.

Base branches are also called target branches or destination branches in some contexts. Examples include `main`, `develop`, `release/*`, or production branches.

### See Also

- [Head Branch](#head-branch) - The source branch being proposed
- [Pull Request (PR)](#pull-request-pr) - The overall mechanism that uses base and head branches

### Referenced By

- [FINDING-2026-03-22-5](../../github-api-facts.md#finding-2026-03-22-5) - Base Branch definition
- [FINDING-2026-03-22-1](../../github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions base branch

---

## GitHub API

**Captured:** 2026-03-22 12:00

The umbrella interface provided by GitHub for programmatic access to repository data, pull requests, reviews, and automation.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops SKILL.md](../../../.claude/skills/github-devops/SKILL.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#github-api) |

### Description

The GitHub API is GitHub's complete platform for programmatic access to repositories, pull requests, reviews, automation, and administration. GitHub offers two API implementations: REST API (endpoint-based) and GraphQL API (query language).

The GitHub API powers integrations, CI/CD automation, GitHub Actions, and custom applications that work with GitHub data. Authentication is typically via personal access tokens or GitHub Apps.

### See Also

- [GitHub REST API](#github-rest-api) - REST implementation of GitHub API
- [GitHub GraphQL API](#github-graphql-api) - GraphQL implementation of GitHub API
- [REST API](#rest-api) - General architectural style
- [GraphQL API](#graphql-api) - General query language

### Referenced By

- [FINDING-2026-03-22-3](../../github-api-facts.md#finding-2026-03-22-3) - GitHub API definition
- [FINDING-2026-03-22-1](../../github-api-facts.md#finding-2026-03-22-1) - Pull Request uses GitHub API

---

## GitHub GraphQL API

**Captured:** 2026-03-22 12:00

GitHub's GraphQL implementation for API access, enabling clients to request specific data fields and nested relationships.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops fetch-review-threads.md](../../../.claude/skills/github-devops/actions/fetch-review-threads.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#github-graphql-api) |

### Description

The GitHub GraphQL API is GitHub's query language implementation for API access. Clients declare exactly what data they need through GraphQL queries, and the API returns only the requested fields. This approach is particularly effective for complex nested queries like fetching review threads with nested comments.

Unlike the REST API, GraphQL queries target a single endpoint and allow selective field retrieval, reducing over-fetching problems common in REST-based architectures.

### See Also

- [GitHub API](#github-api) - Parent umbrella concept
- [GitHub REST API](#github-rest-api) - Alternative GitHub implementation
- [GraphQL API](#graphql-api) - General GraphQL principles (not GitHub-specific)

### Referenced By

- [FINDING-2026-03-22-5](../../github-api-facts.md#finding-2026-03-22-5) - GitHub GraphQL API definition
- [FINDING-2026-03-22-2](../../github-api-facts.md#finding-2026-03-22-2) - Review Thread uses GitHub GraphQL API

---

## GitHub REST API

**Captured:** 2026-03-22 12:00

GitHub's REST (Representational State Transfer) implementation for API access using HTTP methods and endpoint paths.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops create-pr.md](../../../.claude/skills/github-devops/actions/create-pr.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#github-rest-api) |

### Description

The GitHub REST API is GitHub's HTTP-based API implementation using standard REST principles. Each operation is a specific endpoint (e.g., `/repos/{owner}/{repo}/pulls/{number}`), and endpoints return fixed response structures containing all available fields.

The REST API uses HTTP methods (GET, POST, PUT, DELETE, PATCH) for operations and HTTP status codes to indicate success or failure. It is straightforward for single-resource operations but requires multiple requests for complex nested data.

### See Also

- [GitHub API](#github-api) - Parent umbrella concept
- [GitHub GraphQL API](#github-graphql-api) - Alternative GitHub implementation
- [REST API](#rest-api) - General REST architectural principles

### Referenced By

- [FINDING-2026-03-22-4](../../github-api-facts.md#finding-2026-03-22-4) - GitHub REST API definition
- [FINDING-2026-03-22-1](../../github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions REST API

---

## GraphQL API

**Captured:** 2026-03-22 12:00

A general query language and runtime for APIs that enables clients to request exactly the data they need through declarative queries.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [GraphQL Official Documentation](https://graphql.org) | VERIFIED | [Verified 2026-03-22 by official specification](../../verification.md#graphql-api) |

### Description

GraphQL is a general-purpose query language and runtime developed by Facebook for building APIs. GraphQL enables clients to request exactly the data they need, avoiding over-fetching problems where REST APIs return unnecessary fields.

GraphQL features include: declarative query syntax, strongly typed schema, single endpoint, support for nested queries and aliases, and prevention of over-fetching through selective field requests.

### See Also

- [REST API](#rest-api) - Alternative API architectural pattern
- [GitHub GraphQL API](#github-graphql-api) - GitHub's implementation of GraphQL

### Referenced By

- [FINDING-2026-03-22-7](../../github-api-facts.md#finding-2026-03-22-7) - GraphQL API definition (general principle)

---

## Head Branch

**Captured:** 2026-03-22 12:00

The source branch in a pull request containing the changes being proposed for integration.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops create-pr.md](../../../.claude/skills/github-devops/actions/create-pr.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#head-branch) |

### Description

The Head Branch is the source branch in a GitHub pull request that contains the changes being proposed. This branch will be merged into the base branch when the PR is accepted. The head branch typically represents a feature branch, bugfix branch, or other work-in-progress branch with specific changes.

Head branches are also called source branches or feature branches in some contexts. Example: `feature-new-auth` as the head merging into `main` as the base.

### See Also

- [Base Branch](#base-branch) - The target branch receiving changes
- [Pull Request (PR)](#pull-request-pr) - The overall mechanism that uses head and base branches

### Referenced By

- [FINDING-2026-03-22-8](../../github-api-facts.md#finding-2026-03-22-8) - Head Branch definition
- [FINDING-2026-03-22-1](../../github-api-facts.md#finding-2026-03-22-1) - Pull Request mentions head branch

---

## Pull Request (PR)

**Captured:** 2026-03-22 12:00

A mechanism in GitHub for proposing changes to a repository, enabling code review, discussion, and CI/CD automation.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops SKILL.md](../../../.claude/skills/github-devops/SKILL.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#pull-request) |

### Description

A Pull Request (PR) is GitHub's primary mechanism for proposing changes to a repository. A PR requests to merge changes from a head branch (source) into a base branch (target). PRs enable code review, discussion between contributors, and integration with CI/CD automation before changes are merged.

Each PR has a unique number identifier, state (open/closed/merged), HTML URL for web access, and connections to issues, reviews, and comments. PRs are fundamental to collaborative GitHub workflows.

### See Also

- [Head Branch](#head-branch) - Source branch containing proposed changes
- [Base Branch](#base-branch) - Target branch receiving merged changes
- [Review Thread](#review-thread) - Conversations within a PR

### Referenced By

- [FINDING-2026-03-22-1](../../github-api-facts.md#finding-2026-03-22-1) - Pull Request definition
- [FINDING-2026-03-22-2](../../github-api-facts.md#finding-2026-03-22-2) - Review Thread appears in Pull Requests

---

## Repository Configuration

**Captured:** 2026-03-22 12:00

A set of parameters defining which GitHub repository a skill or operation targets.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops SKILL.md](../../../.claude/skills/github-devops/SKILL.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#repository-configuration) |

### Description

Repository Configuration consists of parameters identifying the target GitHub repository for operations. The key parameters are:

- `repo`: Repository identifier in format `owner/repository-name` (e.g., `kubernetes/kubernetes`)
- `org`: Organization name (optional, used for organization-level operations)

Configuration follows a precedence order: parameters passed to the skill override environment variables, which override configuration files. This allows flexible deployment across different repositories.

### See Also

- [GitHub API](#github-api) - The API addressing these repositories
- [Pull Request (PR)](#pull-request-pr) - Operations use repository configuration

### Referenced By

- [FINDING-2026-03-22-10](../../github-api-facts.md#finding-2026-03-22-10) - Repository Configuration definition

---

## REST API

**Captured:** 2026-03-22 12:00

A general architectural style for web APIs using HTTP methods to manipulate resources identified by URIs.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [REST Architectural Principles](https://en.wikipedia.org/wiki/Representational_state_transfer) | VERIFIED | [Verified 2026-03-22 by authoritative source](../../verification.md#rest-api) |

### Description

REST (Representational State Transfer) is an architectural style for designing networked applications. REST APIs organize functionality around resources (identified by URIs) and use HTTP methods (GET, POST, PUT, DELETE, PATCH) to manipulate those resources.

Key REST characteristics: resource-oriented (URIs represent nouns, not verbs), stateless operations, HTTP methods indicate actions, and HTTP status codes provide response semantics. Well-designed REST APIs are cacheable when properly configured.

### See Also

- [GraphQL API](#graphql-api) - Alternative API architectural pattern
- [GitHub REST API](#github-rest-api) - GitHub's implementation using REST principles

### Referenced By

- [FINDING-2026-03-22-6](../../github-api-facts.md#finding-2026-03-22-6) - REST API definition (general principle)

---

## Review Thread

**Captured:** 2026-03-22 12:00

A conversation thread within a pull request containing code review comments that can be marked as resolved or unresolved.

### Sources

| Source | Status | Verification |
|--------|--------|---------------|
| [github-devops fetch-review-threads.md](../../../.claude/skills/github-devops/actions/fetch-review-threads.md) | VERIFIED | [Verified 2026-03-22 by source examination](../../verification.md#review-thread) |

### Description

A Review Thread groups related code review comments within a pull request. Each thread has a unique identifier and tracks its resolution status (resolved or unresolved). Review threads organize PR discussion around specific code sections and enable tracking which feedback has been addressed.

Review threads are queryable via the GitHub GraphQL API and include the thread ID, resolution status, and all associated comments with their content and metadata.

### See Also

- [Pull Request (PR)](#pull-request-pr) - Review threads appear within PRs
- [GitHub GraphQL API](#github-graphql-api) - Used to fetch review threads

### Referenced By

- [FINDING-2026-03-22-2](../../github-api-facts.md#finding-2026-03-22-2) - Review Thread definition
