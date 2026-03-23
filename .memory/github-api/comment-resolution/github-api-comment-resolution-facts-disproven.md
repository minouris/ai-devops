# GitHub API Comment Resolution - Disproven Findings

Archive of findings that have been verified as inaccurate or contradicted by official documentation.

---

### FINDING-2026-03-11-01 [DISPROVEN on 2026-03-11]

**Original Claim:** GitHub Pull Request review comments can be marked as resolved using the REST API through a PATCH request to the review comment endpoint. The mechanism involves a PATCH to `/repos/{owner}/{repo}/pulls/comments/{comment_id}` with a field to toggle the resolved state (likely `resolved: true` or `resolved: false`).

**Captured:** 2026-03-11 03:00
**Source:** https://docs.github.com/en/rest/pulls/comments (claimed)
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The official GitHub REST API OpenAPI specification (authoritative source) confirms that the PATCH endpoint `/repos/{owner}/{repo}/pulls/comments/{comment_id}` only accepts a `body` field for updating comment text. There is no `resolved` field available in the request body schema, and the comment object returned does not include any resolution-related fields (`resolved`, `isResolved`, `resolvedBy`, etc.).

Comment resolution in GitHub is exclusively handled at the review thread level through GraphQL mutations (`resolveReviewThread`, `unresolveReviewThread`), not through REST API PATCH operations on individual comments.

**Authoritative Evidence:**

1. GitHub REST API OpenAPI Specification endpoint definition shows only `body` field in PATCH request: https://raw.githubusercontent.com/github/rest-api-description/main/descriptions/api.github.com/dereferenced/api.github.com.deref.json (path: `/repos/{owner}/{repo}/pulls/comments/{comment_id}`, operation: `patch`, requestBody properties: `["body"]`)

2. Pull Request Review Comment response object properties do NOT include any resolution fields: `_links`, `author_association`, `body`, `body_html`, `body_text`, `commit_id`, `created_at`, `diff_hunk`, `html_url`, `id`, `in_reply_to_id`, `line`, `node_id`, `original_commit_id`, `original_line`, `original_position`, `original_start_line`, `path`, `position`, `pull_request_review_id`, `pull_request_url`, `reactions`, `side`, `start_line`, `start_side`, `subject_type`, `updated_at`, `url`, `user`

3. GitHub GraphQL API provides `resolveReviewThread` mutation as the official mechanism for comment thread resolution (verified via GitHub GraphQL schema queries)

**Related Finding:**

See FINDING-2026-03-11-04 for test evidence of failed REST PATCH attempts with resolution parameters.

---

### FINDING-2026-03-11-13 [DISPROVEN on 2026-03-11]

**Original Claim:** Pull request comments support replies via REST API POST endpoint with `in_reply_to_id` parameter. The endpoint is `/repos/OWNER/REPO/pulls/PULL_NUMBER/comments` and accepts JSON with `"in_reply_to_id": COMMENT_ID`. Comments structure includes `in_reply_to_id` field linking replies to parent comments. Comments can be updated via PATCH endpoint at `/repos/{owner}/{repo}/pulls/comments/{comment_id}` using PATCH for text updates.

**Captured:** 2026-03-11 05:45
**Source:** https://api.github.com response structure analysis
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains a critical parameter name error. The curl example provided in the finding uses the incorrect parameter name `"in_reply_to_id"` when the official GitHub REST API OpenAPI specification defines the correct parameter as `"in_reply_to"` (not `"in_reply_to_id"`).

This factual error makes the provided curl command code incorrect and would cause API calls using the exact example to fail with a parameter validation error. The correct parameter for replying to comments via the POST endpoint is `in_reply_to`, as documented in the official OpenAPI specification.

Additionally, whilst the OpenAPI schema defines `in_reply_to_id` as a response field in the pull-request-review-comment object, direct testing against the live GitHub API shows this field is consistently absent from actual API responses, creating a schema-reality mismatch.

**Authoritative Evidence:**

1. **Official GitHub REST API OpenAPI Specification** (https://raw.githubusercontent.com/github/rest-api-description/main/descriptions/api.github.com/api.github.com.json) defines POST `/repos/{owner}/{repo}/pulls/{pull_number}/comments` endpoint with accepted parameters: `["body", "commit_id", "in_reply_to", "line", "path", "position", "side", "start_line", "start_side", "subject_type"]`

   The correct parameter definition:
   ```json
   "in_reply_to": {
     "type": "integer",
     "example": 2,
     "description": "The ID of the review comment to reply to. To find the ID of a review comment with [\"List review comments on a pull request\"](#list-review-comments-on-a-pull-request). When specified, all parameters other than `body` in the request body are ignored."
   }
   ```

   The parameter `"in_reply_to_id"` (as shown in the finding's curl example) is NOT listed as an accepted request parameter.

2. **Live API Testing** against GitHub public repositories confirms response structure omits the `in_reply_to_id` field. Example response from `https://api.github.com/repos/cli/cli/pulls/12882/comments?per_page=1` includes these fields: `_links`, `author_association`, `body`, `commit_id`, `created_at`, `diff_hunk`, `html_url`, `id`, `line`, `node_id`, `original_commit_id`, `original_line`, `original_position`, `original_start_line`, `path`, `position`, `pull_request_review_id`, `pull_request_url`, `reactions`, `side`, `start_line`, `start_side`, `subject_type`, `updated_at`, `url`, `user`

   Note: `in_reply_to_id` is absent from actual API responses.

3. **Correct Endpoint Information** is partially verified:
   - POST `/repos/{owner}/{repo}/pulls/{pull_number}/comments` endpoint path is correct ✓
   - PATCH `/repos/{owner}/{repo}/pulls/comments/{comment_id}` for comment updates is correct ✓
   - PATCH only accepts `body` parameter for text updates is correct ✓

**Correct Implementation:**

To reply to a pull request review comment, the correct JSON format is:
```json
{
  "body": "Reply text",
  "in_reply_to": 2
}
```

NOT (as shown in the finding):
```json
{
  "body": "Reply text",
  "in_reply_to_id": COMMENT_ID
}
```

**Verification Details:**

See verification working document entry in `github-api-facts-verification.md` for complete verification methodology and evidence breakdown across all claims.

---
