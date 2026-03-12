# Action: Respond to a Review Comment

Add a reply to an existing review comment on a pull request. This operation uses the REST API to create a threaded reply to a specific comment.

## Parameters Required

You must obtain these parameters from the user:
- `pr_number`: Pull request number
- `comment_id`: ID of the comment to reply to
- `reply_text`: Text of the reply

## Verification Steps

Before proceeding to execute the script, you must:
1. Verify the PR number is a positive integer
2. Verify the comment ID is a positive integer
3. Verify the reply text is not empty
4. Confirm the comment exists on the pull request (optional verification)

## Execution

Execute the respond-to-comment script (FINDING-2026-03-11-13 verified parameter: use `in_reply_to` not `in_reply_to_id`):

```bash
${CLAUDE_SKILL_DIR}/scripts/respond-to-comment.sh "$OWNER" "$REPO" "$pr_number" "$comment_id" "$reply_text"
```

Where:
- `$OWNER`: Extracted from `$REPO` configuration (owner component)
- `$REPO`: Extracted from `$REPO` configuration (repository name component)
- `$pr_number`: User-provided pull request number
- `$comment_id`: User-provided comment ID
- `$reply_text`: User-provided reply text

## Compliance Gate: Verify Response

After executing the script, you must verify the response before accepting the operation as successful.

**If the script exit code is NOT 0:**
- Report the error message from the script
- Stop execution immediately
- Do not proceed to reporting success

**If the script exit code is 0:**
- Parse the JSON response
- Verify the response contains an `id` field (new comment ID)
- Verify the response contains a `body` field matching the reply text
- Verify the response contains an `in_reply_to_id` field with value matching the original comment ID

If any verification fails:
- Report the compliance gate failure
- Stop execution

## Report Results

If all compliance gates pass, report success including:
- New comment ID (from `id` field)
- Author (from `user.login` field)
- Posted date (from `created_at` field)
- Reply text

## Constraints

**MUST:**
- Use only the respond-to-comment.sh script
- Verify response structure before reporting success
- Confirm the reply is correctly threaded to the original comment

**MUST NOT:**
- Retry the operation if it fails
- Edit or delete the reply after creation
- Modify the reply text in the response
