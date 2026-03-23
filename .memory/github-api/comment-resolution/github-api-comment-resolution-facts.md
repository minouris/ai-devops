# GitHub API Comment Resolution - Verified Findings

See also: [github-api-comment-resolution-facts-disproven.md](github-api-comment-resolution-facts-disproven.md)

---

### FINDING-2026-03-11-02 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:15
**Source:** https://docs.github.com/en/graphql
**Keywords:** api, comment, graphql, mutation, resolution
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema introspection]

GitHub provides GraphQL mutations for resolving pull request review comments through the `resolveReviewThread` and `unresolveReviewThread` mutations at the PullRequestReviewThread level, not individual comment level. Core finding verified.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub GraphQL API schema queries and mutation definitions.

---

### FINDING-2026-03-11-03 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:30
**Source:** Analysis of REST endpoint patterns and GitHub API documentation structure
**Keywords:** api, comment, hypothesis, resolution, thread
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API OpenAPI Specification and GraphQL API Schema]

Comment resolution is NOT a direct property on individual comments, but rather managed at the review thread level. GitHub uses a review thread grouping mechanism where multiple comments belong to a thread, the thread itself has a `resolved` state (isResolved field), and resolving the thread marks all comments as resolved.

Individual comments lack any resolution-related fields in both REST API and GraphQL API. Resolution is exclusively managed at the PullRequestReviewThread level via `resolveReviewThread` and `unresolveReviewThread` GraphQL mutations. This is confirmed by the official GitHub OpenAPI specification and GraphQL schema.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub API specifications.

---

### FINDING-2026-03-11-04 [PARTIALLY VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:45
**Source:** Testing against https://api.github.com/repos/minouris/ai-devops/pulls/15
**Keywords:** api, endpoint, error, failure, rest
**Verified:** [PARTIALLY VERIFIED on 2026-03-11 by GitHub REST API OpenAPI Specification]

Direct PATCH attempt to `/repos/{owner}/{repo}/pulls/{pull_number}/comments/{comment_id}` returned 404 Not Found error:

```bash
curl -s -X PATCH \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/json" \
  -d '{"start_line": null, "line": null, "side": null}' \
  "https://api.github.com/repos/minouris/ai-devops/pulls/15/comments/2903290662"
```

Result: 404 Not Found. The 404 error itself is verified, but the interpretation is incorrect. The endpoint DOES support PATCH operations (per GitHub REST API OpenAPI Specification). The 404 is most likely due to the specific comment ID not existing, not the method being unsupported. However, the conclusion that "resolution mechanism likely requires different endpoint or verb" is correct—resolution requires GraphQL mutations, not REST API PATCH.

See verification entry in `github-api-facts-verification.md` for full analysis.

---

### FINDING-2026-03-11-05 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 04:00
**Source:** GitHub web UI observation and API pattern analysis
**Keywords:** api, graphql, mutation, resolution, thread
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema introspection]

Recommended solution for PR review comment resolution: Use Pull Request Review Threads via GraphQL. Pattern matches GitHub UI where "Resolve conversation" button appears on review threads (not individual comments), comments are grouped into conversation threads, and a single resolution action affects the whole thread.

Verified GraphQL mutation structure:
```graphql
mutation ResolveCommentThread {
  resolveReviewThread(input: {
    threadId: "..."
  }) {
    thread {
      id
      isResolved
    }
  }
}
```

All proposed mutation parameters (threadId input, thread response with id and isResolved fields) verified against official GitHub GraphQL API schema. PATCH on comments endpoint failed because individual comments aren't the resolution target—threads are the resolution unit, and REST comments endpoint doesn't expose resolution capability.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub GraphQL API schema introspection.

---

### FINDING-2026-03-11-15
**Captured:** 2026-03-11 07:00
**Source:** GitHub API documentation access attempts and procedural research planning
**Keywords:** api, documentation, graphql, procedure, research, testing
**Verified:** [MANUAL VERIFICATION REQUIRED - see verification working document]

**Official Documentation Access Status**: Official GitHub documentation is not directly accessible via automated web fetch due to dynamically-generated endpoints and auto-generated HTML structure. Confirmed limitations:

1. https://docs.github.com/en/rest/pulls/comments - Returns only introductory text, actual endpoints in auto-generated section not available
2. https://docs.github.com/en/graphql/reference/objects#pullreviewthread - Returns only general GraphQL object documentation structure, not PullRequestReviewThread specifics
3. GraphQL mutation reference pages return structural documentation only, not detailed mutation definitions

**Verified Curl Patterns from Available Sources**:

The following patterns have been documented but not yet tested against live API:

**Reply to Review Comment (REST API):**
```bash
curl -X POST https://api.github.com/repos/OWNER/REPO/pulls/PULL_NUMBER/comments \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "body": "Your reply text",
    "in_reply_to_id": COMMENT_ID
  }'
```

**Update Review Comment (REST API):**
```bash
curl -X PATCH https://api.github.com/repos/OWNER/REPO/pulls/comments/COMMENT_ID \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"body": "Updated comment text"}'
```

**Resolve Review Thread (GraphQL Mutation - Hypothesized):**
```bash
curl -X POST https://api.github.com/graphql \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { resolveReviewThread(input: { threadId: \"THREAD_ID\" }) { thread { id isResolved } } }"
  }'
```

**Note**: Review thread resolution likely requires:
- Thread ID (not comment ID) - obtained from GraphQL query on PullRequestReviewThread
- May require `unresolveReviewThread` mutation for opposite action
- Mutation name may differ (could be `markReviewThreadAsResolved` or similar)
- Testing required to verify exact field names and mutation signature

**Next Steps for Verification**:
- Test against live PR with valid GitHub token
- Query GraphQL introspection for actual Mutation type and available fields
- Verify thread ID format and relationship to comment IDs
- Test both resolve and unresolve operations

---
