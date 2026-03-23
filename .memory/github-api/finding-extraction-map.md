# GitHub API Findings Extraction Map

## Purpose
This document provides a complete mapping of findings by subtopic, including verification status and exact line ranges for extraction from source files.

---

## Subtopic: Authentication

### Topic Description
Authentication methods and security best practices for GitHub API access.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-06 | VERIFIED | github-api-facts.md | 90-110 | authentication, method, pat, token, oauth | Five GitHub API authentication methods: PAT v2/v1, GitHub App Tokens, GITHUB_TOKEN, OAuth Apps, Basic Auth (GHES only) |
| FINDING-2026-03-11-07 | VERIFIED | github-api-facts.md | 111-130 | best-practice, credential, security, storage, token | GitHub credential security recommendations: choose method, minimum permissions, secure storage, secure access patterns, breach remediation |
| FINDING-2026-03-11-08 | VERIFIED | github-api-facts.md | 131-146 | authentication, error, rate-limit, security | GitHub API security protections: invalid credential response codes (401, 404, 403), failed login limits, rate limiting differences |

---

## Subtopic: Comment Resolution

### Topic Description
Pull request review comment resolution mechanisms and technical implementation.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-01 | DISPROVEN | github-api-facts.md | 3-12 (reference) | api, comment, graphql, resolution | REST PATCH endpoint does NOT support comment resolution; GraphQL mutations required |
| FINDING-2026-03-11-02 | VERIFIED | github-api-facts.md | 13-24 | api, comment, graphql, mutation, resolution | GraphQL mutations (resolveReviewThread, unresolveReviewThread) handle review comment resolution |
| FINDING-2026-03-11-03 | VERIFIED | github-api-facts.md | 25-38 | api, comment, hypothesis, resolution, thread | Comment resolution managed at review thread level, not individual comment level |
| FINDING-2026-03-11-04 | PARTIALLY VERIFIED | github-api-facts.md | 39-61 | api, endpoint, error, failure, rest | PATCH comment endpoint 404 testing; resolution requires GraphQL mutations, not REST API |
| FINDING-2026-03-11-05 | VERIFIED | github-api-facts.md | 62-89 | api, graphql, mutation, resolution, thread | Recommended solution: GraphQL resolveReviewThread mutation for PR review thread resolution |
| FINDING-2026-03-11-13 | DISPROVEN | github-api-facts.md | 228-237 (reference) | api, comment, endpoint, rest | Reply parameter is `in_reply_to` not `in_reply_to_id`; in_reply_to_id field absent from responses |
| FINDING-2026-03-11-15 | MANUAL VERIFICATION | github-api-facts.md | 256-314 | api, documentation, graphql, procedure, research | Documented but untested curl patterns for comment operations and GraphQL resolution mutations |

---

## Subtopic: PR Management

### Topic Description
Pull request listing, creation, retrieval, and manipulation operations.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-09 | VERIFIED | github-api-facts.md | 147-169 | api, comment, data-model, link-relation, pr | PR REST API data model: 8 link relation types (self, html, issue, comments, review_comments, etc.); PR-issue relationship |
| FINDING-2026-03-11-10 | VERIFIED | github-api-facts.md | 170-191 | api, create, endpoint, list, management, pr, rest | PR REST API operations: listing, manipulation, commit access, comments, related issue access |

---

## Subtopic: Reviews

### Topic Description
Pull request review operations, state management, and review dismissal.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-11 | DISPROVEN | github-api-facts.md | 192-201 (reference) | api, review, state, dismissed | Review state value error: "REQUESTED_CHANGES" incorrect; correct value is "CHANGES_REQUESTED" |
| FINDING-2026-03-11-12 | MANUAL VERIFICATION | github-api-facts.md | 202-227 | api, dismiss, endpoint, rest, review, submit | PR Reviews REST API: listing, creation/submission, modification, dismissal, comment access, review requests, deletion |

---

## Subtopic: Credential Acquisition

### Topic Description
Methods to acquire, create, and manage different credential types (PAT, GitHub Apps, OAuth).

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-16 | PARTIALLY VERIFIED | github-api-facts.md | 315-352 | app, authentication, credential, pat, registration | PAT creation process: fine-grained (recommended) vs classic tokens; configuration options; 50 token limit; token cannot be viewed after form closure |
| FINDING-2026-03-11-17 | DISPROVEN | github-api-facts.md | 353-362 (reference) | app, registration, required-fields | Missing Permissions and Installation Scope fields; incorrectly lists webhook config as required when optional |
| FINDING-2026-03-11-18 | PARTIALLY VERIFIED | github-api-facts.md | 363-394 | app, authentication, credential, oauth, registration | OAuth App creation process: registration steps, constraints, credential retrieval, GitHub App recommendation |
| FINDING-2026-03-11-19 | PARTIALLY VERIFIED | github-api-facts.md | 395-426 | api, credential, documentation, github-app, limitation, oauth, pat | Documented credential acquisition gaps: GitHub App private key generation, credential retrieval procedures |

---

## Subtopic: Git Credential Management

### Topic Description
Using Git credential helpers to store, retrieve, and manage credentials programmatically.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-20 | VERIFIED | github-api-facts.md | 427-476 | authentication, credential, fill, git, token | Git credential fill command: retrieves credentials via stdin; input format (protocol, host, path); output with username/password |
| FINDING-2026-03-11-21 | VERIFIED | github-api-facts.md | 477-534 | authentication, cache, credential, helper, keychain, storage, token | Git credential helpers: cache (15 min), store (plaintext), osxkeychain (encrypted), wincred/GCM; configuration commands; security recommendations |
| FINDING-2026-03-11-22 | VERIFIED | github-api-facts.md | 535-603 | approve, authentication, credential, git, reject, token | Git credential approve/reject actions: storing and removing credentials; typical workflow; scripting examples |

---

## Subtopic: Integration

### Topic Description
Curl-based GitHub API integration with credential management and advanced patterns.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-23 | VERIFIED | github-api-facts.md | 604-673 | authentication, credential, fill, git, parsing, script, variable | Shell script patterns for git credential retrieval and parsing; basic method and advanced associative arrays |
| FINDING-2026-03-11-24 | VERIFIED | github-api-facts.md | 674-719 | api, authentication, curl, github, header, token | Curl with GitHub REST API: Bearer token authentication; authorization header variations; required headers; HTTP methods |
| FINDING-2026-03-11-25 | DISPROVEN | github-api-facts.md | 720-729 (reference) | api, credential, curl, security, variable | Curl version error: states 7.73.0+ but correct version is 8.3.0 for variable expansion |
| FINDING-2026-03-11-26 | DISPROVEN | github-api-facts.md | 730-739 (reference) | api, credential, curl, security | Script contains invalid bash syntax (set -q) and undocumented curl option (--expand-header) |

---

## Subtopic: Documentation

### Topic Description
Documentation access and research methodology limitations.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-14 | VERIFIED | github-api-facts.md | 238-252 | api, documentation, graphql, limit, research | GitHub documentation accessibility limitations: auto-generated content, web scraping barriers; GraphQL testing recommended |

---

## Subtopic: Implementation

### Topic Description
Practical, tested implementations of GitHub API patterns and workflows.

### Findings Included

| Finding ID | Status | Source File | Line Range | Keywords | Summary |
|-----------|--------|------------|-----------|----------|---------|
| FINDING-2026-03-11-27 | VERIFIED | github-api-facts.md | 740-872 | api, comment, curl, github, graphql, mutation, resolve, thread, tested | Verified method: resolve review threads via GraphQL mutation; step-by-step with curl examples; tested on minouris/ai-devops PR #15 |
| FINDING-2026-03-11-28 | VERIFIED | github-api-facts.md | 874-925 | api, github, graphql, mutation, pr, resolve, thread, verified | Practical application: bulk resolve addressed review threads with commit references; tested on PR #15 |
| FINDING-2026-03-11-29 | VERIFIED | github-api-facts.md | 927-968 | api, comment, github, graphql, markdown, mutation, pr, resolve, thread, verified | Practical application: interactive thread resolution with explanatory comments; tested on PR #15 |

---

## Disproven Findings Location Reference

The following findings have been moved to `github-api-facts-disproven.md` and are referenced in the main file:

| Finding ID | Disproven File Line Range | Main File Reference | Reason Disproven |
|-----------|--------------------------|-------------------|------------------|
| FINDING-2026-03-11-01 | 7-35 | 3-12 | REST API PATCH doesn't support resolution; only GraphQL mutations do |
| FINDING-2026-03-11-11 | 36-76 | 192-201 | Incorrect review state enum: "REQUESTED_CHANGES" vs correct "CHANGES_REQUESTED" |
| FINDING-2026-03-11-13 | 77-141 | 228-237 | Wrong parameter name: `in_reply_to_id` vs correct `in_reply_to`; field absent from responses |
| FINDING-2026-03-11-17 | 144-201 | 353-362 | Missing required fields and incorrect optional field listings in GitHub App registration |
| FINDING-2026-03-11-25 | 204-248 | 720-729 | Curl version error: 7.73.0+ claimed but correct version is 8.3.0 |
| FINDING-2026-03-11-26 | 250-336 | 730-739 | Invalid bash syntax (set -q) and undocumented curl option (--expand-header) |

---

## Extraction Instructions

### For Each Subtopic File

1. Read the source file (github-api-facts.md) for the specified line ranges
2. Extract complete finding content from `### FINDING-...` header through to the line before the next finding's `---` separator
3. For disproven findings, reference the disproven file for complete details
4. Create subtopic markdown file in appropriate directory structure:
   ```
   .memory/github-api/
   ├── authentication/
   │   └── findings.md
   ├── comment-resolution/
   │   └── findings.md
   ├── pr-management/
   │   └── findings.md
   ├── reviews/
   │   └── findings.md
   ├── credential-acquisition/
   │   └── findings.md
   ├── git-credential-management/
   │   └── findings.md
   ├── integration/
   │   └── findings.md
   ├── documentation/
   │   └── findings.md
   └── implementation/
       └── findings.md
   ```

### File Naming Convention

- Use lowercase with hyphens for directory names
- Name findings file as `findings.md` in each subtopic directory
- Optional: Create index file at subtopic level for navigation

### Content Organization

Each subtopic `findings.md` should:
1. Include a brief header explaining the subtopic
2. Present findings in numerical order by ID
3. Preserve all original metadata (status, source, keywords, verification notes)
4. Maintain code examples and curl patterns exactly as documented
5. Include cross-references to related findings in other subtopics

---

## Summary Statistics

### By Verification Status
- **VERIFIED**: 20 findings
- **PARTIALLY VERIFIED**: 4 findings
- **MANUAL VERIFICATION REQUIRED**: 2 findings
- **DISPROVEN**: 6 findings
- **Total**: 29 findings

### By Subtopic
- **Authentication**: 3 findings
- **Comment Resolution**: 7 findings
- **PR Management**: 2 findings
- **Reviews**: 2 findings
- **Credential Acquisition**: 4 findings
- **Git Credential Management**: 3 findings
- **Integration**: 4 findings
- **Documentation**: 1 finding
- **Implementation**: 3 findings

### Disproven Findings Distribution
- Authentication: 0
- Comment Resolution: 3 (FINDING-01, FINDING-13)
- PR Management: 0
- Reviews: 1 (FINDING-11)
- Credential Acquisition: 1 (FINDING-17)
- Git Credential Management: 0
- Integration: 2 (FINDING-25, FINDING-26)
- Documentation: 0
- Implementation: 0

---

## Next Steps

1. Use this map to systematically extract findings from source files
2. Create subtopic directories and findings.md files
3. Update central index to reference new subtopic structure
4. Verify extraction accuracy by spot-checking key findings
5. Update links and cross-references in verification document
6. Archive this extraction map in project documentation
