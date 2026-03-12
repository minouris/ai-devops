# Action: Fetch Review Threads for a Pull Request

Retrieve all review threads for a specific pull request. This operation uses the GraphQL API to query review threads and their resolution status.

## Parameters Required

You must obtain these parameters from the user:
- `pr_number`: Pull request number

## Verification Steps

Before proceeding to execute the script, you must:
1. Verify the PR number is a positive integer
2. Confirm the PR exists on the repository

## Execution

Execute the fetch-review-threads script (FINDING-2026-03-11-27 verified GraphQL query pattern):

```bash
${CLAUDE_SKILL_DIR}/scripts/fetch-review-threads.sh "$OWNER" "$REPO" "$pr_number"
```

Where:
- `$OWNER`: Extracted from `$REPO` configuration (owner component)
- `$REPO`: Extracted from `$REPO` configuration (repository name component)
- `$pr_number`: User-provided pull request number

## Compliance Gate: Verify Response

After executing the script, you must verify the response before accepting the operation as successful.

**If the script exit code is NOT 0:**
- Report the error message from the script
- Stop execution immediately
- Do not proceed to reporting results

**If the script exit code is 0:**
- Parse the JSON response
- Verify the response contains a `data` field
- Verify `data.repository.pullRequest` exists
- Verify `data.repository.pullRequest.reviewThreads.nodes` is an array

If any verification fails:
- Report the compliance gate failure
- Stop execution
- Do not proceed to reporting results

## Report Results

If all compliance gates pass, and review threads are found:
- For each thread in `reviewThreads.nodes`:
  - Report thread ID (from `id` field)
  - Report resolution status (from `isResolved` field - `true` or `false`)
  - Report comment count in thread (length of `comments.nodes` array)

If no review threads exist:
- Report that the pull request has no review threads

## Constraints

**MUST:**
- Use only the fetch-review-threads.sh script
- Verify response structure before reporting results
- Parse and report thread IDs and resolution statuses

**MUST NOT:**
- Retry the operation if it fails
- Assume thread structure without parsing the response
- Modify or update thread status
