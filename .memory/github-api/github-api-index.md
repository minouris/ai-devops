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

## Findings

| Finding | Topic | Name | Terms |
|---------|-------|------|-------|
| [FINDING-2026-03-11-07](github-api-facts.md#finding-2026-03-11-07) | Authentication | Credential Security Best Practices | |
| [FINDING-2026-03-11-08](github-api-facts.md#finding-2026-03-11-08) | Authentication | Failed Login and Rate Limiting | |
| [FINDING-2026-03-11-06](github-api-facts.md#finding-2026-03-11-06) | Authentication | Token Types and Methods | |
| [FINDING-2026-03-11-04](github-api-facts.md#finding-2026-03-11-04) | Comment Resolution | Failed REST Endpoint Test | |
| [FINDING-2026-03-11-02](github-api-facts.md#finding-2026-03-11-02) | Comment Resolution | GraphQL Mutation | |
| [FINDING-2026-03-11-05](github-api-facts.md#finding-2026-03-11-05) | Comment Resolution | GraphQL Thread Resolution Solution | |
| [FINDING-2026-03-11-03](github-api-facts.md#finding-2026-03-11-03) | Comment Resolution | Resolution via Review Threads | |
| [FINDING-2026-03-11-01](github-api-facts-disproven.md#finding-2026-03-11-01) | Comment Resolution | REST Endpoint Pattern [DISPROVEN] | |
| [FINDING-2026-03-11-09](github-api-facts.md#finding-2026-03-11-09) | PR Management | PR Data Model and Link Relations | |
| [FINDING-2026-03-11-10](github-api-facts.md#finding-2026-03-11-10) | PR Management | PR REST API Operations | |
| [FINDING-2026-03-11-11](github-api-facts-disproven.md#finding-2026-03-11-11) | Reviews | Review Data Model [DISPROVEN] | |
| [FINDING-2026-03-11-12](github-api-facts.md#finding-2026-03-11-12) | Reviews | Review REST API Operations | |
| [FINDING-2026-03-11-13](github-api-facts-disproven.md#finding-2026-03-11-13) | Comment Resolution | REST Reply Endpoint [DISPROVEN] | |
| [FINDING-2026-03-11-14](github-api-facts.md#finding-2026-03-11-14) | Documentation | Documentation Accessibility Limitations | |
| [FINDING-2026-03-11-15](github-api-facts.md#finding-2026-03-11-15) | Comment Resolution | Curl Patterns for Comment Resolution | |
| [FINDING-2026-03-11-16](github-api-facts.md#finding-2026-03-11-16) | Credential Acquisition | Personal Access Token Creation | |
| [FINDING-2026-03-11-17](github-api-facts-disproven.md#finding-2026-03-11-17) | Credential Acquisition | GitHub App Registration [DISPROVEN] | |
| [FINDING-2026-03-11-18](github-api-facts.md#finding-2026-03-11-18) | Credential Acquisition | OAuth App Registration | |
| [FINDING-2026-03-11-19](github-api-facts.md#finding-2026-03-11-19) | Credential Acquisition | Credential Viewing and Documentation Gaps | |
| [FINDING-2026-03-11-20](github-api-facts.md#finding-2026-03-11-20) | Git Credential Management | Git Credential Fill Command | |
| [FINDING-2026-03-11-21](github-api-facts.md#finding-2026-03-11-21) | Git Credential Management | Credential Helper Configuration | |
| [FINDING-2026-03-11-22](github-api-facts.md#finding-2026-03-11-22) | Git Credential Management | Credential Approve and Reject | |
| [FINDING-2026-03-11-23](github-api-facts.md#finding-2026-03-11-23) | Integration | Git Credential Parsing in Scripts | |
| [FINDING-2026-03-11-24](github-api-facts.md#finding-2026-03-11-24) | Integration | Curl with GitHub REST API | |
| [FINDING-2026-03-11-25](github-api-facts.md#finding-2026-03-11-25) | Integration | Curl Environment Variables | |
| [FINDING-2026-03-11-26](github-api-facts.md#finding-2026-03-11-26) | Integration | Secure Credential Patterns | |
| [FINDING-2026-03-11-27](github-api-facts.md#finding-2026-03-11-27) | Implementation | Verified Review Thread Resolution | |
| [FINDING-2026-03-11-28](github-api-facts.md#finding-2026-03-11-28) | Implementation | Bulk Resolution of Addressed Threads | |
| [FINDING-2026-03-11-29](github-api-facts.md#finding-2026-03-11-29) | Implementation | Interactive Thread Resolution with Comments | |
