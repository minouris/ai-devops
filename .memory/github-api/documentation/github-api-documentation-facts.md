# GitHub API Documentation - Verified Findings

---

### FINDING-2026-03-11-14 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 05:50
**Source:** GitHub documentation fetch attempts (2026-03-11 session)
**Keywords:** api, documentation, graphql, limit, research
**Verified:** [VERIFIED on 2026-03-11 by GitHub documentation accessibility testing via WebFetch]

Documentation source difficulties verified as accurate:
- GitHub REST API reference uses auto-generated endpoint documentation not accessible via direct web fetch - VERIFIED by HTML comment markers and incomplete responses
- GraphQL mutation reference pages return only structural information without mutation type definitions - VERIFIED by empty/overview-only responses
- Direct fetch attempts to `/rest/pulls/review-comments` and GraphQL references return 404 or empty content - VERIFIED (404 on review-comments endpoint)
- Web scraping of docs.github.com limited by pre-rendered HTML comment markers - VERIFIED by multiple HTML comment instances blocking auto-generated content

All claims about documentation access limitations are accurate. Recommended approach of direct GraphQL API testing is appropriate given documentation accessibility constraints.

See verification entry in `github-api-facts-verification.md` for complete evidence and testing results.

---
