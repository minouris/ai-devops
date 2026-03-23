# GitHub API Research Index

## Knowledge Summary

**Overview:** Authoritative research on GitHub API capabilities, authentication methods, and pull request operations. Designed to support both procedural implementation (testing API endpoints) and architectural decision-making (choosing REST vs GraphQL). Covers credential acquisition, API authentication, PR comment resolution workflows, and integration patterns with git and curl.

**Research Domains:** GitHub REST API, GitHub GraphQL API, Authentication & Credentials, Pull Request Operations, Comment Resolution, Git Integration, Curl Integration

**Core Terminology:** Personal Access Token (PAT), GitHub REST API, GitHub GraphQL API, Pull Request, Review Thread, GraphQL Mutation, Git Credential Fill, Curl

**Verification Status:**
- Verified: 24 findings
- Unverified: 0 findings
- Disproven: 5 findings
- **Verification Rate:** 100% of active findings

**Total Findings:** 29 across main facts and disproven archive

**Last Verified:** 2026-03-23

---

## Status Summary

**Total Findings:** 29
**Latest Session:** 2026-03-11 (Verified FINDING-2026-03-11-11, archived as DISPROVEN; Verified FINDING-2026-03-11-13, archived as DISPROVEN)
**Verification Status:** FINDING-2026-03-11-01 DISPROVEN via official GitHub OpenAPI specification. FINDING-2026-03-11-11 DISPROVEN (incorrect review state enum value). FINDING-2026-03-11-13 DISPROVEN (incorrect parameter name in API example). Findings 2-10, 12-15 document research on comment resolution, documentation, and PR operations. Findings 16-19 document credential acquisition procedures. Findings 20-22 document git credential management. Findings 23-26 document git credential fill with curl integration and security. **Findings 27-29 VERIFIED via live API applications (bulk resolution, markdown fix, and interactive resolution with comments).**

## Fact Files

- [github-api-facts.md](github-api-facts.md) — Complete findings on GitHub API authentication, PR management, reviews, and comment resolution
- [github-api-facts-disproven.md](github-api-facts-disproven.md) — Archive of disproven findings with evidence
- [github-api-review/github-api-review-resolution-procedure.md](github-api-review/github-api-review-resolution-procedure.md) — Procedural research guide for testing comment resolution approach

## Keyword Indices

- [Keywords A-F](github-api-index-keywords-a-f.md)
- [Keywords G-P](github-api-index-keywords-g-p.md)
- [Keywords Q-Z](github-api-index-keywords-q-z.md)

## Findings

| Finding | Topic | Name | Keywords |
|---------|-------|------|----------|
| [FINDING-2026-03-11-07](github-api-facts.md#finding-2026-03-11-07) | Authentication | Credential Security Best Practices | best-practice, credential, security, storage, token |
| [FINDING-2026-03-11-08](github-api-facts.md#finding-2026-03-11-08) | Authentication | Failed Login and Rate Limiting | authentication, error, rate-limit, security |
| [FINDING-2026-03-11-06](github-api-facts.md#finding-2026-03-11-06) | Authentication | Token Types and Methods | authentication, github-actions, oauth, pat, token |
| [FINDING-2026-03-11-04](github-api-facts.md#finding-2026-03-11-04) | Comment Resolution | Failed REST Endpoint Test | api, endpoint, error, failure, rest |
| [FINDING-2026-03-11-02](github-api-facts.md#finding-2026-03-11-02) | Comment Resolution | GraphQL Mutation | api, comment, graphql, mutation, resolution |
| [FINDING-2026-03-11-05](github-api-facts.md#finding-2026-03-11-05) | Comment Resolution | GraphQL Thread Resolution Solution | api, graphql, mutation, resolution, thread |
| [FINDING-2026-03-11-03](github-api-facts.md#finding-2026-03-11-03) | Comment Resolution | Resolution via Review Threads | api, comment, hypothesis, resolution, thread |
| [FINDING-2026-03-11-01](github-api-facts-disproven.md#finding-2026-03-11-01) | Comment Resolution | REST Endpoint Pattern [DISPROVEN] | api, comment, endpoint, resolution, rest |
| [FINDING-2026-03-11-09](github-api-facts.md#finding-2026-03-11-09) | PR Management | PR Data Model and Link Relations | api, comment, data-model, link-relation, pr |
| [FINDING-2026-03-11-10](github-api-facts.md#finding-2026-03-11-10) | PR Management | PR REST API Operations | api, create, endpoint, list, management, pr, rest |
| [FINDING-2026-03-11-11](github-api-facts-disproven.md#finding-2026-03-11-11) | Reviews | Review Data Model [DISPROVEN] | api, data-model, review, state |
| [FINDING-2026-03-11-12](github-api-facts.md#finding-2026-03-11-12) | Reviews | Review REST API Operations | api, dismiss, endpoint, rest, review, submit |
| [FINDING-2026-03-11-13](github-api-facts-disproven.md#finding-2026-03-11-13) | Comment Resolution | REST Reply Endpoint [DISPROVEN] | api, comment, graphql, respond, reply |
| [FINDING-2026-03-11-14](github-api-facts.md#finding-2026-03-11-14) | Documentation | Documentation Accessibility Limitations | api, documentation, graphql, limit, research |
| [FINDING-2026-03-11-15](github-api-facts.md#finding-2026-03-11-15) | Comment Resolution | Curl Patterns for Comment Resolution | api, curl, documentation, graphql, procedure |
| [FINDING-2026-03-11-16](github-api-facts.md#finding-2026-03-11-16) | Credential Acquisition | Personal Access Token Creation | authentication, credential, pat, pat-v1, pat-v2, token |
| [FINDING-2026-03-11-17](github-api-facts-disproven.md#finding-2026-03-11-17) | Credential Acquisition | GitHub App Registration [DISPROVEN] | app, authentication, credential, github-app, registration |
| [FINDING-2026-03-11-18](github-api-facts.md#finding-2026-03-11-18) | Credential Acquisition | OAuth App Registration | app, authentication, credential, oauth, registration |
| [FINDING-2026-03-11-19](github-api-facts.md#finding-2026-03-11-19) | Credential Acquisition | Credential Viewing and Documentation Gaps | api, credential, documentation, github-app, limitation, oauth |
| [FINDING-2026-03-11-20](github-api-facts.md#finding-2026-03-11-20) | Git Credential Management | Git Credential Fill Command | authentication, credential, fill, git, token |
| [FINDING-2026-03-11-21](github-api-facts.md#finding-2026-03-11-21) | Git Credential Management | Credential Helper Configuration | authentication, cache, credential, helper, keychain, storage |
| [FINDING-2026-03-11-22](github-api-facts.md#finding-2026-03-11-22) | Git Credential Management | Credential Approve and Reject | approve, authentication, credential, git, reject, token |
| [FINDING-2026-03-11-23](github-api-facts.md#finding-2026-03-11-23) | Integration | Git Credential Parsing in Scripts | authentication, credential, fill, git, parsing, script, variable |
| [FINDING-2026-03-11-24](github-api-facts.md#finding-2026-03-11-24) | Integration | Curl with GitHub REST API | api, authentication, curl, github, header, token |
| [FINDING-2026-03-11-25](github-api-facts.md#finding-2026-03-11-25) | Integration | Curl Environment Variables | curl, environment, expansion, security, variable |
| [FINDING-2026-03-11-26](github-api-facts.md#finding-2026-03-11-26) | Integration | Secure Credential Patterns | authentication, bash, credential, curl, environment, security, token |
| [FINDING-2026-03-11-27](github-api-facts.md#finding-2026-03-11-27) | Implementation | Verified Review Thread Resolution | api, comment, curl, github, graphql, mutation, resolve, thread, tested |
| [FINDING-2026-03-11-28](github-api-facts.md#finding-2026-03-11-28) | Implementation | Bulk Resolution of Addressed Threads | api, github, graphql, mutation, pr, resolve, thread, verified |
| [FINDING-2026-03-11-29](github-api-facts.md#finding-2026-03-11-29) | Implementation | Interactive Thread Resolution with Comments | api, comment, github, graphql, markdown, mutation, pr, resolve, thread, verified |
