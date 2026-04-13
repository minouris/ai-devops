# Gather Incident Details

You MUST reconstruct the incident from the current conversation context. Document everything before proceeding to additional flows.

## Step 1: Identify the Four Core Elements

You MUST identify and record these four elements:

1. **What was being attempted** — the task or operation you were performing when the problem occurred
2. **What the user disagreed with** — the specific action, output, or claim the user identified as wrong
3. **Why it was a violation** — how this contradicts rules, instructions, or reasonable expectations
4. **Skill context** — if a skill was active when the problem occurred, identify it by name and path

Record each element clearly and completely. You will pass these to subsequent flows.

## Step 2: Proceed to Gather Context

After recording the four elements above, read [gather-context.md](gather-context.md) and follow all steps.

## Step 3: Invoke Library Skills

After completing context gathering, you MUST invoke the library skills in this exact order:

1. Call `skill(ai-problem-identify-violations)` — pass the incident context from Steps 1–2
   - Wait for results
   - Record all violations identified

2. Call `skill(ai-problem-classify-causes)` — pass the violations from the previous call
   - Wait for results
   - Record all classified root causes

**CRITICAL:** Do not skip any library skill invocations. Each step depends on the output of the previous step.

## Step 4: Compose the Issue

After library skill invocations complete, read [compose-issue.md](compose-issue.md) and follow all steps.

## Step 5: Present Report and Confirm

Read [present-report.md](present-report.md) and follow all steps.

## Step 6: Submit the Issue

Read [submit-issue.md](submit-issue.md) and follow all steps.
