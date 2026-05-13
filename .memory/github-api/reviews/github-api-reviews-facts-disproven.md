# GitHub API Reviews - Disproven Findings

Archive of findings that have been verified as inaccurate or contradicted by official documentation.

---

### FINDING-2026-03-11-11 [DISPROVEN on 2026-03-11]

**Original Claim:** Pull Request Reviews have a distinct data model from individual comments with review state values including APPROVED, REQUESTED_CHANGES, COMMENTED, PENDING, DISMISSED, etc.

**Captured:** 2026-03-11 05:45
**Source:** https://docs.github.com/en/rest/pulls/reviews
**Original Verified Status:** [MANUAL VERIFICATION REQUIRED - Official GitHub docs include auto-generated content not accessible via automated fetch...]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains a critical factual error regarding pull request review state values. The finding claims the review state value is "REQUESTED_CHANGES", but the authoritative GitHub GraphQL API schema defines the correct enum value as "CHANGES_REQUESTED" (note the reversed word order).

This factual error makes the finding unreliable for implementation purposes. Any code or documentation relying on the "REQUESTED_CHANGES" state value would fail when querying the GitHub API, as the actual value is "CHANGES_REQUESTED".

Whilst the majority of the finding's conceptual claims are accurate (reviews do have distinct data models, reviews do group comments, they do have state, etc.), the incorrect specification of a specific enum value is a material factual error.

**Authoritative Evidence:**

Direct GraphQL API schema introspection confirms the correct pull request review state values:

```
Query: {__type(name: "PullRequestReviewState") { enumValues { name } } }
Response: {"data":{"__type":{"enumValues":[{"name":"PENDING"},{"name":"COMMENTED"},{"name":"APPROVED"},{"name":"CHANGES_REQUESTED"},{"name":"DISMISSED"}]}}}
```

Source: GitHub GraphQL API PullRequestReviewState enum definition (live API query via `gh cli`)

**Correct Review State Values:**
- PENDING (review in progress)
- COMMENTED (feedback without approval)
- APPROVED (reviewer approves)
- CHANGES_REQUESTED (reviewer requests modifications) ← **Not "REQUESTED_CHANGES" as claimed in finding**
- DISMISSED (review dismissed by PR author or admin)

**Verification Details:**

See verification working document entry in `github-api-facts-verification.md` for complete verification methodology and evidence breakdown across all claims.

---
