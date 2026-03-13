# Action: Fetch Comments on a Pull Request

Retrieve all review comments on a specific pull request. This operation uses the REST API to fetch inline code review comments.

## Parameters Required

You must obtain these parameters from the user:
- `pr_number`: Pull request number

## Verification Steps

Before proceeding to execute the script, you must:
1. Verify the PR number is a positive integer
2. Confirm the user wants to retrieve review comments (not issue comments)

## Execution

Execute the fetch-thread-comments script (FINDING-2026-03-11-27 Step 1 verified REST API pattern):

```bash
${CLAUDE_SKILL_DIR}/scripts/fetch-thread-comments.sh "$OWNER" "$REPO" "$pr_number"
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
- Verify the response is a valid JSON array (it may be empty)
- For each comment in the array:
  - Verify the comment contains `id` field (comment ID)
  - Verify the comment contains `body` field (comment text)
  - Verify the comment contains `user` field with `login` field

If response is not valid JSON:
- Report the compliance gate failure
- Stop execution

## Report Results

If all compliance gates pass:

**If comments exist:**
- For each comment, report:
  - Comment ID (from `id` field)
  - Author (from `user.login` field)
  - Posted date (from `created_at` field)
  - Comment excerpt (first 100 characters of `body`)

**If no comments exist:**
- Report that the pull request has no review comments

## Constraints

**MUST:**
- Use only the fetch-thread-comments.sh script
- Verify response structure before reporting results
- Handle empty comment lists gracefully

**MUST NOT:**
- Retry the operation if it fails
- Assume comment structure without parsing the response
- Modify or delete comments
