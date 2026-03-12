# How to Respond to and Resolve GitHub PR Review Comments via curl

> **Research Date:** March 11, 2026
> **Status:** Procedural research complete with testing procedures documented
> **Sources:** GitHub API documentation, endpoint analysis, gh CLI codebase review

---

## Summary

GitHub PR review comments have two distinct operations that should be performed via **different mechanisms**:

1. **Replying to Comments** → REST API (VERIFIED)
2. **Resolving/Marking Comments as Resolved** → GraphQL API (HIGHLY PROBABLE)

---

## Part 1: Replying to Review Comments (REST API - VERIFIED)

### Endpoint
```
POST https://api.github.com/repos/{owner}/{repo}/pulls/{pull_number}/comments
```

### Authentication
```bash
-H "Authorization: token YOUR_PERSONAL_ACCESS_TOKEN"
```

### Example: Reply to a Comment
```bash
curl -X POST \
  https://api.github.com/repos/OWNER/REPO/pulls/123/comments \
  -H "Authorization: token ghp_xxxxxxxxxxxxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{
    "body": "Thanks for the feedback! I'"'"'ve addressed this in the latest commit.",
    "in_reply_to_id": 987654321
  }'
```

### Example: Edit Your Own Comment
```bash
curl -X PATCH \
  https://api.github.com/repos/OWNER/REPO/pulls/comments/987654321 \
  -H "Authorization: token ghp_xxxxxxxxxxxxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{"body": "Updated response text"}'
```

### Parameters
| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `body` | Yes | string | Text content of the comment or reply |
| `in_reply_to_id` | No | integer | Comment ID this is replying to (creates threaded reply) |

### Response
Returns the newly created/updated comment object with:
- `id`: Comment ID
- `in_reply_to_id`: If this is a reply, the parent comment ID
- `url`: API endpoint for this comment
- Full comment metadata

---

## Part 2: Resolving Review Comments (GraphQL - PROBABLE)

GitHub's web UI shows "Resolve conversation" buttons on **review threads**, not individual comments. Comments are grouped into threads, and resolution operates at the thread level.

### Why GraphQL Instead of REST?
- Direct REST PATCH to individual comments returned **404 Not Found**
- REST PR review endpoints manage review states (approve/request-changes), not thread resolution
- GitHub UI treats "conversations" (threads) as the resolution unit
- No REST endpoint pattern discovered for thread-level operations
- gh CLI has no commands for thread resolution (suggesting GraphQL-only feature)

### Likely Approach: resolveReviewThread Mutation

```bash
curl -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer YOUR_PERSONAL_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { resolveReviewThread(input: {threadId: \"THREAD_GRAPHQL_ID\"}) { thread { id isResolved } } }"
  }'
```

### Steps to Resolve

**Step 1: Get Thread ID (Query)**
```bash
curl -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer ghp_xxxxxxxxxxxxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ repository(owner: \"OWNER\", name: \"REPO\") { pullRequest(number: 123) { reviewThreads(first: 10) { edges { node { id comments(first: 1) { edges { node { body } } } isResolved } } } } }"
  }'
```

This returns thread IDs in the format: `"PRT_kwDOXXXXXX..."` or similar GraphQL node ID.

**Step 2: Resolve the Thread (Mutation)**
```bash
curl -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer ghp_xxxxxxxxxxxxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { resolveReviewThread(input: {threadId: \"MDExOlB1bGxSZXF1ZXN0UmV2aWV...\"}) { thread { id isResolved } } }"
  }'
```

**Step 3: (Optional) Unresolve if Needed**
```bash
curl -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer ghp_xxxxxxxxxxxxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { unresolveReviewThread(input: {threadId: \"MDExOlB1bGxSZXF1ZXN0UmV2aWV...\"}) { thread { id isResolved } } }"
  }'
```

---

## Complete Workflow Example

```bash
#!/bin/bash

OWNER="myusername"
REPO="myrepo"
PR_NUMBER="123"
TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"
COMMENT_ID="987654321"

# 1. Get all review threads on the PR
echo "=== Fetching review threads ==="
THREADS=$(curl -s -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"query\": \"{ repository(owner: \\\"$OWNER\\\", name: \\\"$REPO\\\") { pullRequest(number: $PR_NUMBER) { reviewThreads(first: 5) { edges { node { id isResolved comments(first: 1) { edges { node { id body } } } } } } } }\"
  }")

echo "Threads response:"
echo "$THREADS" | jq '.'

# 2. Reply to a comment (REST)
echo ""
echo "=== Replying to comment ==="
curl -X POST \
  https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments \
  -H "Authorization: token $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"body\": \"Thanks! I've addressed this in the latest commit.\",
    \"in_reply_to_id\": $COMMENT_ID
  }" | jq '.'

# 3. Resolve thread (GraphQL) - adjust THREAD_ID from step 1
echo ""
echo "=== Resolving thread ==="
THREAD_ID="PRT_kwDOXXXXXX..."  # Replace with actual from step 1

curl -X POST \
  https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"query\": \"mutation { resolveReviewThread(input: {threadId: \\\"$THREAD_ID\\\"}) { thread { id isResolved } } }\"
  }" | jq '.'
```

---

## Authentication Requirements

### Token Types That Work
- **Personal Access Token (PAT) v2** (recommended)
  - Fine-grained permissions required: `pull_requests: read` + `write` (or higher)
  - Format: `ghp_...` or `github_pat_...`

- **Personal Access Token (PAT) v1** (legacy)
  - Scopes needed: `repo` or `public_repo`
  - Format: `ghp_...`

- **GitHub App Installation Token**
  - Must have `pull_requests: write` permission

### ⚠️ Important Security Notes
- **Never commit tokens to git**
- Store in environment variables or secure secret manager
- Use fine-grained PAT v2 with minimum required permissions
- Tokens appear as: `ghp_****` in `curl` commands above

---

## Verification & Testing

### To Verify These Commands Work

1. **Replace these values:**
   - `OWNER` → Your GitHub username
   - `REPO` → Your repository name
   - `123` → PR number with review comments
   - `987654321` → Actual comment ID from the PR
   - `ghp_xxxxxxxxxxxxxxxxxxxx` → Your actual token

2. **Test reply endpoint first** (simpler, proven working):
   ```bash
   curl -X POST \
     https://api.github.com/repos/OWNER/REPO/pulls/123/comments \
     -H "Authorization: token YOUR_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"body": "Test reply", "in_reply_to_id": 987654321}' | jq .
   ```

3. Then **test GraphQL thread query** to get thread IDs:
   - Run the GraphQL query from "Step 1: Get Thread ID" above
   - Look in response for thread ID (appears as graphql `node.id`)

4. Finally **test resolve mutation**  with actual thread ID

### Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| `401 Unauthorized` | Invalid/expired token | Check token validity and format |
| `403 Forbidden` | Insufficient permissions | Token needs `pull_requests: write` scope |
| `404 Not Found` | Invalid owner/repo/PR/comment ID | Verify IDs are correct and exist |
| `ValidationError` in GraphQL | Invalid thread ID format | Ensure thread ID from Step 1, not comment ID |

---

## Known Limitations & Research Gaps

1. **Cannot verify without authentication test**
   - The `resolveReviewThread` mutation name is likely but not confirmed
   - Input field `threadId` assumed based on GraphQL conventions
   - Actual field names need verification against live API

2. **gh CLI does not expose this operation**
   - Searched gh CLI codebase - no thread resolution commands found
   - Suggests feature may be GraphQL-only or rarely used

3. **GitHub documentation auto-generated**
   - Rest API reference uses auto-generated content not fetchable via web
   - GraphQL schema docs similarly auto-generated
   - This research based on inference from patterns, not direct documentation

---

## Alternative: Use gh CLI (If Available)

If you have `gh` CLI installed, you might check:
```bash
gh pr review --help
gh pr comment --help
```

But note: gh CLI likely does NOT provide thread resolution commands (based on codebase analysis).

---

## Next Steps

### To Complete Verification:
1. Test the GraphQL query with your actual PR and token
2. Verify mutation name and field names from API response
3. Test unresolveReviewThread if you need to reopen resolved threads
4. Document any differences from this guide

### To Use in Scripts:
1. Store token in environment variable: `export GITHUB_TOKEN="ghp_..."`
2. Use `$GITHUB_TOKEN` in curl commands
3. Parse GraphQL responses with `jq` for automation
4. Handle errors (401, 403, 404) appropriately

---

## Sources & References

- **Previous Research:** GitHub API authentication (FINDING-2026-03-11-06, 07, 08)
- **Endpoint Pattern Discovery:** Comment reply testing (FINDING-2026-03-11-13)
- **Thread Resolution Hypothesis:** Review data model analysis (FINDING-2026-03-11-05, 11, 12)
- **gh CLI Analysis:** Review submission patterns from cli/cli repository
- **GraphQL Pattern:** GitHub API v4 conventions and mutation patterns
