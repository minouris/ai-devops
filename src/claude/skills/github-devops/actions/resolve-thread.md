# Action: Resolve a Review Thread

Mark a review thread as resolved. This operation uses the GraphQL API to execute a mutation that resolves a specific review thread.

## Parameters Required

You must obtain these parameters from the user:
- `thread_id`: GraphQL node ID of the review thread (format: `PRRT_...`)

## Verification Steps

Before proceeding to execute the script, you must:
1. Verify the thread ID is provided and in the correct format (starts with `PRRT_`)
2. Inform the user that resolving a thread marks all comments in the thread as addressed

## Important Detail

According to FINDING-2026-03-11-05, review threads (not individual comments) are the resolution unit in GitHub. When you resolve a thread, all comments within that thread are marked as resolved.

## Execution

Execute the resolve-review-thread script (FINDING-2026-03-11-05 verified mutation structure, FINDING-2026-03-11-27 verified working example):

```bash
${CLAUDE_SKILL_DIR}/scripts/resolve-review-thread.sh "$thread_id"
```

Where:
- `$thread_id`: User-provided GraphQL thread ID

## Compliance Gate: Verify Response

After executing the script, you must verify the response before accepting the operation as successful.

**If the script exit code is NOT 0:**
- Report the error message from the script
- Stop execution immediately
- Do not proceed to reporting success

**If the script exit code is 0:**
- Parse the JSON response
- Verify the response contains a `data` field
- Verify `data.resolveReviewThread` exists
- Verify `data.resolveReviewThread.thread` exists
- Verify `data.resolveReviewThread.thread.isResolved` is `true`

If any verification fails:
- Report the compliance gate failure
- Stop execution
- Do not accept the operation as complete

## Report Results

If all compliance gates pass, report success including:
- Thread ID (from `data.resolveReviewThread.thread.id` field)
- Resolution status: "Resolved"
- Confirmation that all comments in the thread are now marked as addressed

## Constraints

**MUST:**
- Use only the resolve-review-thread.sh script
- Verify response structure and `isResolved` field before reporting success
- Confirm the thread ID matches the resolved thread

**MUST NOT:**
- Retry the operation if it fails
- Assume the thread is resolved without verifying the response
- Resolve multiple threads without explicit user confirmation for each
