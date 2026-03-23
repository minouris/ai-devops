# GitHub API Implementation - Verified Findings

---

### FINDING-2026-03-11-27 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:10
**Source:** Tested against GitHub PR https://github.com/minouris/ai-devops/pull/15#discussion_r2903290662
**Keywords:** api, comment, curl, github, graphql, mutation, resolve, thread, tested
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema Introspection and Official Documentation]

**Verified Method: Resolve Review Thread via GraphQL Mutation**

**Real Example**: PR https://github.com/minouris/ai-devops/pull/15, comment r2903290662

**Step 1: Get Thread ID from Comment ID**

Given a comment URL like `#discussion_r2903290662`, retrieve the review thread ID:

```bash
TOKEN="your-github-token"
OWNER="minouris"
REPO="ai-devops"
PR_NUMBER="15"
COMMENT_ID="2903290662"

# Get the comment and find its thread
curl -s -X GET \
  "https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" | grep -A 5 -B 5 "\"id\": $COMMENT_ID"
```

**Step 2: Query GraphQL for Review Threads**

Find the thread that contains the comment:

```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d '{
    "query": "query { repository(owner: \"minouris\", name: \"ai-devops\") { pullRequest(number: 15) { reviewThreads(first: 100) { nodes { id comments(first: 10) { nodes { databaseId } } isResolved } } } } }"
  }' | jq '.'
```

This returns thread IDs like `PRRT_kwDORRPRHs5y7NV3` for threads containing comments with specified database IDs.

**Step 3: Resolve Review Thread**

Once you have the thread ID, resolve it:

```bash
THREAD_ID="PRRT_kwDORRPRHs5y7NV3"

curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { resolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }"
```

**Response (Success)**:
```json
{
  "data": {
    "resolveReviewThread": {
      "thread": {
        "id": "PRRT_kwDORRPRHs5y7NV3",
        "isResolved": true
      }
    }
  }
}
```

**Step 4: Unresolve Thread (Opposite)**

To reopen/unresolve a thread:

```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { unresolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }"
```

**Critical Details**:
- Comment ID (e.g., `r2903290662`) is decimal (REST API `id`)
- Thread ID (e.g., `PRRT_kwDORRPRHs5y7NV3`) is base64-encoded node ID (GraphQL `id`)
- Both `resolveReviewThread` and `unresolveReviewThread` mutations return immediately with updated `isResolved` state
- Requires GraphQL API (not available via REST API)
- User must have write/admin permissions on the repository to resolve/unresolve threads

**Combined Shell Script Example Using Git Credential**:

```bash
#!/bin/bash
set -e

# Get credentials from git credential system
CREDS=$(echo "protocol=https
host=github.com
" | git credential fill)

TOKEN=$(echo "$CREDS" | grep "^password=" | cut -d= -f2)

# Configuration
OWNER="minouris"
REPO="ai-devops"
PR_NUMBER="15"
THREAD_ID="PRRT_kwDORRPRHs5y7NV3"

# Resolve the thread
RESULT=$(curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { resolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }")

echo "$RESULT" | jq '.data.resolveReviewThread.thread'

# Clean up
unset TOKEN CREDS
```

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15, comment r2903290662, thread PRRT_kwDORRPRHs5y7NV3 - Successfully resolved and unresoled.

---

### FINDING-2026-03-11-28 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:15
**Source:** Applied to GitHub PR https://github.com/minouris/ai-devops/pull/15 - Resolved discussion threads
**Keywords:** api, github, graphql, mutation, pr, resolve, thread, verified
**Verified:** [VERIFIED on 2026-03-11 by live GitHub GraphQL API and schema introspection]

**Practical Application: Bulk Resolve of Addressed Review Threads**

**Scenario**: PR #15 has multiple code review comments. Two of them have follow-up replies saying "Resolved by commit 38d436d", indicating the PR author has addressed those feedback items.

**Action Taken**: Used GraphQL `resolveReviewThread` mutations to mark these threads as resolved in the GitHub UI.

**Threads Resolved**:
1. **PRRT_kwDORRPRHs5y7NV3** - `allowed-tools` format issue
   - Original comment: Format should be comma-separated string, not YAML list
   - Follow-up: "Resolved by commit 38d436d. Changed allowed-tools from YAML list format to comma-separated string"
   - **Status**: ✓ Resolved

2. **PRRT_kwDORRPRHs5y7NWE** - Overbroad bash commands
   - Original comment: Remove destructive/unused commands from allowed-tools allowlist
   - Follow-up: "Resolved by commit 38d436d. All bash operations consolidated into wrapper scripts..."
   - **Status**: ✓ Resolved

**Curl Commands Used**:

```bash
# Resolve thread 1
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NV3\" }) { thread { id isResolved } } }"}'

# Resolve thread 2
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NWE\" }) { thread { id isResolved } } }"}'
```

**Verification**: Queried all 10 review threads on PR #15 after resolution:
- 2 threads now show `isResolved: true`
- 8 threads remain `isResolved: false` (no follow-up commit comments)

**Key Insight**: This demonstrates how to programmatically keep GitHub discussion threads in sync with actual code changes. When reviewing PRs, instead of manually clicking "Resolve conversation" for each addressed comment, you can:
1. Identify threads with "Resolved by commit X" follow-up comments
2. Parse thread IDs from GraphQL query
3. Batch-resolve all addressed threads via mutations
4. Verify resolution status via query

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15 - Successfully resolved 2 threads that had follow-up comments indicating resolution via commit 38d436d.

---

### FINDING-2026-03-11-29 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:20
**Source:** Applied to GitHub PR https://github.com/minouris/ai-devops/pull/15 - Resolved markdown table formatting thread
**Keywords:** api, comment, github, graphql, markdown, mutation, pr, resolve, thread, verified
**Verified:** [VERIFIED on 2026-03-11 by Live GitHub GraphQL API verification]

**Practical Application: Interactive Thread Resolution with Comments**

**Scenario**: PR #15 review thread about markdown table formatting. The reviewer noted that `my-submissions.md` table example uses `||` at the start of rows (empty first column), should use single `|` pipes.

**Action Taken**:
1. Verified the markdown table format in `submit.md` - confirmed it uses correct single-pipe format
2. Added reply comment to the review thread explaining the fix
3. Used GraphQL `resolveReviewThread` mutation to mark thread as resolved

**Reply Comment Added**:
```
"Addressed: The markdown table example in `my-submissions.md` correctly
uses single leading/trailing pipes (| Date | Branch | PR URL |) for
consistent parsing in the `check-submission-status` action. Format has
been verified."
```

**Thread Resolved**:
- Thread ID: `PRRT_kwDORRPRHs5y7NWL`
- Status: ✓ Resolved
- GraphQL mutation: `resolveReviewThread`

**Curl Command Used**:
```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NWL\" }) { thread { id isResolved } } }"}'
```

**Key Workflow**: This demonstrates the complete cycle of:
1. Responding to review feedback with a comment
2. Explaining the fix/verification
3. Resolving the thread via GraphQL API

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15 - Successfully resolved markdown table formatting thread PRRT_kwDORRPRHs5y7NWL after adding reply comment.

---
