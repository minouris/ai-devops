# Fetch and Validate Issue

Retrieve the issue and confirm it qualifies for inspection. **You MUST complete every step in this flow before continuing to analysis flows.**

## Step 1: Fetch the Issue

Execute this command:

```
gh issue view $ARGS \
  --repo minouris/ai-devops \
  --json number,title,body,labels,comments,url
```

Record:
- Issue number
- Title
- Body text
- Current labels (as array)
- Existing comments (as array)  
- URL

## Step 2: Qualification Checks

**STOP AND EXIT IF ANY OF THESE ARE TRUE:**

1. Issue has label `created-by: ai-problem-report` — no inspection needed
2. Issue has NO `cause:` label — not an AI problem issue
3. Issue has label `inspected-by: ai-problem-inspect-issue` — already inspected

**If any of the above are true, stop here. Do not continue.**

**If NONE of the above are true, proceed to Step 3.**

**Proceed requires:**
- Issue has at least one `cause:` label
- Issue lacks `created-by: ai-problem-report`
- No previous analysis comment exists

## Step 3: Extract Incident Description

From the issue body, identify and record:

1. **What was being attempted** — the task or operation described
2. **What the AI did wrong** — the specific action, output, or claim identified as wrong
3. **Why it was a violation** — how this contradicts rules, instructions, or expectations
4. **Any skill context** — if a skill is named in the issue

Record these four elements. You will pass them as context to the next flows.

## Step 4: Invoke Analysis Flows

You MUST now invoke the library skills in this exact order:

1. **Call `skill(ai-problem-identify-violations)`** — pass the incident context from Step 3
   - Wait for results
   - Record all violations identified

2. **Call `skill(ai-problem-classify-causes)`** — pass the violations from the previous call
   - Wait for results
   - Record all classified root causes

3. **Call `skill(ai-problem-check-sub-issues)`** — pass the root causes from the previous call
   - Wait for results
   - Record sub-issues and their bodies

**CRITICAL:** Do not skip any library skill invocations. Each step depends on the output of the previous step.

## Step 5: Compose Findings

Read [compose-findings.md](compose-findings.md) and follow all steps.

## Step 6: Submit Results

Read [submit-findings.md](submit-findings.md) and follow all steps.
