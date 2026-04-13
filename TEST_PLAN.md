# Test Plan: AI Problem Reporting & Inspection Skills

## Overview
This document outlines comprehensive testing for the new AI problem reporting and inspection skills introduced in the `feature/report-ai-problems` branch.

## Test Scope
- **Main Skills**: ai-problem-report, ai-problem-inspect-issue
- **Library Skills**: ai-problem-analyse, ai-problem-identify-violations, ai-problem-classify-causes, ai-problem-check-sub-issues
- **References**: ai-problem-taxonomy
- **Workflow**: inspect-ai-problem-issue.yml GitHub Actions workflow
- **Scripts**: extract_chat_log.py

---

## Test Environment Setup

### Prerequisites
- [ ] Clone/checkout feature/report-ai-problems branch
- [ ] Access to `minouris/ai-devops` repository with write permissions
- [ ] GitHub token with `issues:write` and `contents:read` scopes
- [ ] Copilot CLI installed and authenticated
- [ ] Python 3.8+ with json module available

### Test Data Preparation
- [ ] Create test GitHub issue with simulated AI problem description
- [ ] Prepare sample chat log in JSONL format for extract_chat_log.py testing
- [ ] Document test issue numbers for reference throughout tests

---

## Test Suite 1: Python Script Validation

### Test 1.1: extract_chat_log.py - Valid Input
**File**: `src/claude/skills/ai-problem-report/scripts/extract_chat_log.py`

```bash
# Create test JSONL file
cat > test_chat.jsonl << 'EOF'
{"message": {"role": "user", "content": "Hello"}}
{"message": {"role": "assistant", "content": [{"type": "text", "text": "Hi there"}]}}
EOF

# Run script
python3 src/claude/skills/ai-problem-report/scripts/extract_chat_log.py test_chat.jsonl
```

**Expected Output**:
- [ ] Prints `[user]: Hello`
- [ ] Prints `[assistant]: Hi there`
- [ ] Exits with code 0

### Test 1.2: extract_chat_log.py - Malformed JSON
**Setup**: Create JSONL with mixed valid/invalid lines

```bash
cat > test_malformed.jsonl << 'EOF'
{"message": {"role": "user", "content": "Valid"}}
{invalid json line}
{"message": {"role": "assistant", "content": "Another valid"}}
EOF

python3 src/claude/skills/ai-problem-report/scripts/extract_chat_log.py test_malformed.jsonl 2>error.log
```

**Expected Behavior**:
- [ ] Silently skips malformed line
- [ ] Processes valid lines
- [ ] No error output for malformed JSON (silent skip)
- [ ] Exits with code 0

### Test 1.3: extract_chat_log.py - Missing Arguments
```bash
python3 src/claude/skills/ai-problem-report/scripts/extract_chat_log.py 2>&1
```

**Expected Output**:
- [ ] Prints usage message to stderr
- [ ] Exits with code 1

---

## Test Suite 2: Skill References & Cross-Links Validation

### Test 2.1: All Reference Files Exist
**Verify each skill has all documented reference files**:

- ai-problem-report:
  - [ ] `references/gather-context.md`
  - [ ] `references/gather-incident.md`
  - [ ] `references/present-report.md`
  - [ ] `references/compose-issue.md`
  - [ ] `references/submit-issue.md`

- ai-problem-inspect-issue:
  - [ ] `references/fetch-issue.md`
  - [ ] `references/compose-findings.md`
  - [ ] `references/submit-findings.md`

- ai-problem-analyse:
  - [ ] `references/identify-violations.md`
  - [ ] `references/classify-causes.md`
  - [ ] `references/check-sub-issues.md`
  - [ ] `references/root_cause_definitions.md`

### Test 2.2: All Internal Links Are Valid
```bash
# Check for broken markdown links
grep -r "\[.*\](.*\.md)" src/claude/skills/ai-problem-* | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  link=$(echo "$line" | sed -n 's/.*\[\([^]]*\)\](\([^)]*\))/\2/p')
  # Verify link exists relative to file's directory
  echo "Checking: $file -> $link"
done
```

**Expected**: No broken links

### Test 2.3: All Skill References in Taxonomy
**File**: `src/claude/skills/ai-problem-taxonomy/SKILL.md`

- [ ] References ai-problem-report correctly
- [ ] References ai-problem-inspect-issue correctly
- [ ] References ai-problem-analyse correctly
- [ ] All label formats match root cause definitions

---

## Test Suite 3: Label Consistency Validation

### Test 3.1: Label Format Compliance
**Verify all label references use correct format**:

```bash
# Search for cause labels
grep -r "cause:" src/claude/skills/ai-problem-* --include="*.md" | grep -v "cause: " && echo "FAIL: Found cause label without space" || echo "PASS"

# Search for metadata labels  
grep -r "created-by:" src/claude/skills/ai-problem-* --include="*.md" | grep -v "created-by: " && echo "FAIL" || echo "PASS"
```

- [ ] All `cause:` labels have space after colon
- [ ] All `created-by:` labels use `ai-problem-report` or `ai-problem-inspect-issue` (never old names)
- [ ] All `inspected-by:` labels use `ai-problem-inspect-issue`

### Test 3.2: Root Cause Definitions
**File**: `src/claude/skills/ai-problem-analyse/references/root_cause_definitions.md`

- [ ] Contains verbose definitions for: hallucination, dishonesty, amnesia, overeagerness, context-poisoning
- [ ] Each definition includes: trigger conditions, manifestation patterns, contributing factors
- [ ] Cross-cause analysis section present
- [ ] All definitions > 50 lines (sufficient detail)

---

## Test Suite 4: Workflow Automation Testing

### Test 4.1: Workflow File Syntax
```bash
# Validate YAML/workflow syntax
python3 -m yaml /workspaces/ai-devops/.github/workflows/inspect-ai-problem-issue.yml
```

- [ ] File parses without errors
- [ ] Permissions section correct: `issues: write`
- [ ] Event triggers: `opened` and `labeled`

### Test 4.2: Workflow Condition Logic
**File**: `.github/workflows/inspect-ai-problem-issue.yml` lines 14-18

```yaml
if: |
  contains(join(github.event.issue.labels.*.name, ','), 'cause:') &&
  !contains(join(github.event.issue.labels.*.name, ','), 'created-by: ai-problem-report') &&
  !contains(join(github.event.issue.labels.*.name, ','), 'created-by: ai-problem-inspect-issue') &&
  !contains(join(github.event.issue.labels.*.name, ','), 'inspected-by: ai-problem-inspect-issue')
```

- [ ] All `contains()` calls use consistent `join()` format
- [ ] No mixing of array and joined string formats
- [ ] All label names match taxonomy

### Test 4.3: Workflow Environment Setup
- [ ] `COPILOT_GITHUB_TOKEN` set to `secrets.PERSONAL_ACCESS_TOKEN`
- [ ] `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` points to `/src/claude`
- [ ] `GH_TOKEN` set to `secrets.GITHUB_TOKEN` (not PAT)

---

## Test Suite 5: Manual Skill Invocation Testing

### Test 5.1: ai-problem-report Skill Flow
**Test Scenario**: Report a simulated AI hallucination issue

```bash
# Invoke the skill with test context
copilot -p "/ai-problem-report" --no-ask-user
```

**Expected Steps** (verify in documented flow):
1. [ ] Gathers incident context from user
2. [ ] Identifies violations using ai-problem-identify-violations
3. [ ] Classifies root causes using ai-problem-classify-causes
4. [ ] Checks for sub-issue duplicates using ai-problem-check-sub-issues
5. [ ] Composes issue with all findings
6. [ ] Presents for user confirmation
7. [ ] Submits with correct labels

**Expected Output**:
- [ ] Creates new GitHub issue in minouris/ai-devops
- [ ] Issue has `cause:` label(s)
- [ ] Issue has `created-by: ai-problem-report` label
- [ ] Issue contains violation details and root cause analysis

### Test 5.2: ai-problem-inspect-issue Skill Flow
**Test Scenario**: Inspect an existing issue with cause: label

```bash
# Create test issue first
gh issue create --repo minouris/ai-devops \
  --title "Test AI Problem" \
  --body "Test issue with AI problem" \
  --label "cause: hallucination"

# Get issue number
ISSUE_NUM=$(gh issue list --repo minouris/ai-devops --search "Test AI Problem" --json number -q '.[0].number')

# Invoke inspection skill
copilot -p "/ai-problem-inspect-issue $ISSUE_NUM" --no-ask-user
```

**Expected Steps**:
1. [ ] Fetches issue from GitHub
2. [ ] Validates qualification (has cause: label, not created by ai-problem-report)
3. [ ] Identifies violations specific to issue
4. [ ] Classifies additional root causes
5. [ ] Checks for related sub-issues
6. [ ] Composes findings comment
7. [ ] Submits findings and labels

**Expected Output**:
- [ ] Comment added to issue with findings
- [ ] Additional `cause:` labels applied if new causes identified
- [ ] `inspected-by: ai-problem-inspect-issue` label applied
- [ ] Sub-issues created or linked where applicable

### Test 5.3: Library Skills - Isolation Testing
**Test** each library skill can be invoked independently:

```bash
# ai-problem-identify-violations
copilot -p "/ai-problem-identify-violations" --no-ask-user

# ai-problem-classify-causes  
copilot -p "/ai-problem-classify-causes" --no-ask-user

# ai-problem-check-sub-issues
copilot -p "/ai-problem-check-sub-issues" --no-ask-user
```

- [ ] Each skill responds to invocation (even if just showing it's library-only)
- [ ] Proper documentation accessible

---

## Test Suite 6: Integration End-to-End Testing

### Test 6.1: Full Workflow: Report + Auto-Inspect
**Scenario**: Report issue → GitHub workflow auto-inspects

1. [ ] Invoke ai-problem-report to create new issue with `cause: <X>` label
2. [ ] Verify issue created successfully
3. [ ] Wait for inspect-ai-problem-issue workflow to trigger (30 seconds - 2 minutes)
4. [ ] Verify workflow runs without errors
5. [ ] Verify findings comment posted to issue
6. [ ] Verify `inspected-by: ai-problem-inspect-issue` label applied

### Test 6.2: Manual Inspect on Existing Issue
1. [ ] Create issue with `cause:` label manually (via gh or UI)
2. [ ] Invoke ai-problem-inspect-issue manually for that issue
3. [ ] Verify structured findings added
4. [ ] Verify labels applied correctly

### Test 6.3: Idempotency Test
**Scenario**: Run inspect-issue skill twice on same issue

1. [ ] Invoke ai-problem-inspect-issue on test issue (first run)
2. [ ] Verify comment and labels applied
3. [ ] Invoke ai-problem-inspect-issue again on same issue (second run)
4. [ ] Verify:
   - [ ] No duplicate comments added
   - [ ] `inspected-by: ai-problem-inspect-issue` label prevents re-processing
   - [ ] Skill recognizes issue already analyzed

---

## Test Suite 7: Memory & Documentation References

### Test 7.1: Memory Index Links
**Files**: `.memory/github-devops-workflow-actions/github-devops-workflow-actions-index.md`

```bash
# Verify all links reference actual files
grep -oP '\./[^/]+/[^/]+\.md' .memory/github-devops-workflow-actions/github-devops-workflow-actions-index.md | sort -u | while read link; do
  test -f ".memory/github-devops-workflow-actions/$link" || echo "BROKEN: $link"
done
```

- [ ] No broken links
- [ ] All referenced fact files exist:
  - `workflow-execution/workflow-execution-facts.md`
  - `issue-handling/issue-handling-facts.md`
  - `caching/caching-facts.md`
  - `copilot-cli/copilot-cli-facts.md`
  - `github-cli/github-cli-facts.md`
  - `runner-environment/runner-environment-facts.md`

### Test 7.2: Knowledge Base Integration
**File**: `.memory/knowledge-base-index.md`

- [ ] Index references new skills appropriately
- [ ] Structure is consistent with existing entries

---

## Test Suite 8: Error Handling & Edge Cases

### Test 8.1: Invalid Issue Number
```bash
copilot -p "/ai-problem-inspect-issue 999999" --no-ask-user
```

- [ ] Skill handles gracefully
- [ ] Clear error message provided

### Test 8.2: Issue Without cause: Label
```bash
# Create issue without cause label
gh issue create --repo minouris/ai-devops --title "No cause" --body "Test"

# Try to inspect
ISSUE_NUM=$(...)
copilot -p "/ai-problem-inspect-issue $ISSUE_NUM" --no-ask-user
```

- [ ] Skill correctly identifies issue doesn't qualify
- [ ] Skill exits with appropriate message

### Test 8.3: Issue Already Inspected
```bash
# Create issue, inspect once, then try again
# (Verify inspected-by label prevents re-run)
```

- [ ] Skill recognizes `inspected-by: ai-problem-inspect-issue` label
- [ ] Terminates appropriately on idempotency check

---

## Test Success Criteria

All tests passing = Ready to merge

- **Critical (Must Pass)**: All Test Suites 1, 2, 3, 4
- **Important (Should Pass)**: Test Suites 5, 6
- **Nice-to-Have (Can Pass Later)**: Test Suite 7, 8

---

## Known Limitations & Future Testing

- [ ] Workflow automation testing requires actual GitHub Actions run (cannot fully simulate locally)
- [ ] Copilot CLI testing requires valid authentication and custom instructions
- [ ] Full end-to-end requires creating test issues in real repository

---

## Test Execution Checklist

- [ ] Set up test environment
- [ ] Run Python script tests (Suite 1)
- [ ] Validate references (Suites 2, 3)
- [ ] Verify workflow syntax (Suite 4)
- [ ] Manual skill testing (Suite 5)
- [ ] Integration testing (Suite 6)
- [ ] Documentation validation (Suite 7)
- [ ] Error case verification (Suite 8)
- [ ] Document results and any issues found
- [ ] Create follow-up issues if needed
- [ ] Approve for merge when all critical tests pass
