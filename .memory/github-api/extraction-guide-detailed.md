# GitHub API Findings Extraction Guide - Content Details

## Purpose
This document provides detailed content extraction specifications, showing exactly what needs to be extracted for each subtopic from the source files.

---

## Extraction Template

For each finding, extract the complete block from `### FINDING-...` header through the closing `---` separator.

**Source Location Pattern:**
```
### FINDING-2026-03-11-XX [STATUS on 2026-03-11]
...content...
---
```

---

## SUBTOPIC 1: Authentication

**Directory Path:** `.memory/github-api/authentication/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-06 [VERIFIED]
- **Line Range:** 90-110
- **Status:** VERIFIED
- **Keywords:** authentication, method, pat, token, oauth
- **Extract Instruction:** Lines 90-109 (stop before next `---` at line 110)
- **Content Size:** ~21 lines
- **Key Content:**
  - Five authentication methods overview
  - PAT v1 vs v2 distinction
  - GitHub App Tokens explanation
  - GITHUB_TOKEN for CI/CD
  - OAuth Apps mention
  - Basic auth (GHES only)
  - Authorization header format

#### FINDING-2026-03-11-07 [VERIFIED]
- **Line Range:** 111-130
- **Status:** VERIFIED
- **Keywords:** best-practice, credential, security, storage, token
- **Extract Instruction:** Lines 111-129 (stop before next `---` at line 130)
- **Content Size:** ~20 lines
- **Key Content:**
  - Choose appropriate method
  - Minimum permission principle
  - Storage and transmission guidelines
  - Secure access patterns
  - Breach remediation plan

#### FINDING-2026-03-11-08 [VERIFIED]
- **Line Range:** 131-146
- **Status:** VERIFIED
- **Keywords:** authentication, error, rate-limit, security
- **Extract Instruction:** Lines 131-145 (stop before next `---` at line 146)
- **Content Size:** ~15 lines
- **Key Content:**
  - Invalid credential response codes (401, 404, 403)
  - Failed login limits
  - Rate limiting differences
  - Security protection mechanisms

---

## SUBTOPIC 2: Comment Resolution

**Directory Path:** `.memory/github-api/comment-resolution/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-01 [DISPROVEN] - Reference Only
- **Line Range:** 3-12 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 7-35
- **Extract Instruction:** Copy lines 3-11 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

#### FINDING-2026-03-11-02 [VERIFIED]
- **Line Range:** 13-24
- **Status:** VERIFIED
- **Keywords:** api, comment, graphql, mutation, resolution
- **Extract Instruction:** Lines 13-23 (stop before next `---` at line 24)
- **Content Size:** ~11 lines
- **Key Content:**
  - GraphQL mutations (resolveReviewThread, unresolveReviewThread)
  - Thread-level resolution mechanism
  - Verification details

#### FINDING-2026-03-11-03 [VERIFIED]
- **Line Range:** 25-38
- **Status:** VERIFIED
- **Keywords:** api, comment, hypothesis, resolution, thread
- **Extract Instruction:** Lines 25-37 (stop before next `---` at line 38)
- **Content Size:** ~13 lines
- **Key Content:**
  - Comment resolution at thread level, not individual comment level
  - Thread grouping mechanism
  - isResolved field on PullRequestReviewThread
  - REST vs GraphQL distinction

#### FINDING-2026-03-11-04 [PARTIALLY VERIFIED]
- **Line Range:** 39-61
- **Status:** PARTIALLY VERIFIED
- **Keywords:** api, endpoint, error, failure, rest
- **Extract Instruction:** Lines 39-60 (stop before next `---` at line 61)
- **Content Size:** ~22 lines
- **Key Content:**
  - 404 error testing against live API
  - Bash curl example
  - Interpretation of 404 response
  - Verification notes

#### FINDING-2026-03-11-05 [VERIFIED]
- **Line Range:** 62-89
- **Status:** VERIFIED
- **Keywords:** api, graphql, mutation, resolution, thread
- **Extract Instruction:** Lines 62-88 (stop before next `---` at line 89)
- **Content Size:** ~27 lines
- **Key Content:**
  - Recommended solution with GraphQL
  - GraphQL mutation structure example
  - Thread ID usage
  - Parameter verification details

#### FINDING-2026-03-11-13 [DISPROVEN] - Reference Only
- **Line Range:** 228-237 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 77-141
- **Extract Instruction:** Copy lines 228-236 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

#### FINDING-2026-03-11-15 [MANUAL VERIFICATION]
- **Line Range:** 256-314
- **Status:** MANUAL VERIFICATION REQUIRED
- **Keywords:** api, documentation, graphql, procedure, research
- **Extract Instruction:** Lines 256-313 (stop before next `---` at line 314)
- **Content Size:** ~58 lines
- **Key Content:**
  - Official documentation access status
  - Verified curl patterns (not yet tested)
  - Reply to review comment pattern
  - Update review comment pattern
  - Resolve review thread hypothesized pattern
  - Note about potential variations
  - Next steps for verification

---

## SUBTOPIC 3: PR Management

**Directory Path:** `.memory/github-api/pr-management/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-09 [VERIFIED]
- **Line Range:** 147-169
- **Status:** VERIFIED
- **Keywords:** api, comment, data-model, link-relation, pr
- **Extract Instruction:** Lines 147-168 (stop before next `---` at line 169)
- **Content Size:** ~22 lines
- **Key Content:**
  - PR REST API data model overview
  - Eight link relation types with descriptions
  - PR-issue relationship explanation
  - Comment type distinction (issue vs review comments)

#### FINDING-2026-03-11-10 [VERIFIED]
- **Line Range:** 170-191
- **Status:** VERIFIED
- **Keywords:** api, create, endpoint, list, management, pr, rest
- **Extract Instruction:** Lines 170-190 (stop before next `---` at line 191)
- **Content Size:** ~21 lines
- **Key Content:**
  - Five PR operation categories
  - Listing/retrieval operations
  - Manipulation operations
  - Commit access
  - Comments handling
  - Related issue access
  - Verification details

---

## SUBTOPIC 4: Reviews

**Directory Path:** `.memory/github-api/reviews/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-11 [DISPROVEN] - Reference Only
- **Line Range:** 192-201 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 36-76
- **Extract Instruction:** Copy lines 192-200 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

#### FINDING-2026-03-11-12 [MANUAL VERIFICATION]
- **Line Range:** 202-227
- **Status:** MANUAL VERIFICATION REQUIRED
- **Keywords:** api, dismiss, endpoint, rest, review, submit
- **Extract Instruction:** Lines 202-226 (stop before next `---` at line 227)
- **Content Size:** ~25 lines
- **Key Content:**
  - Seven PR review operation categories
  - Review listing operations
  - Review creation/submission operations
  - Review modification operations
  - Review dismissal operations
  - Review comments access
  - Review requests API
  - Review deletion operations
  - Implementation note about GraphQL resolution

---

## SUBTOPIC 5: Credential Acquisition

**Directory Path:** `.memory/github-api/credential-acquisition/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-16 [PARTIALLY VERIFIED]
- **Line Range:** 315-352
- **Status:** PARTIALLY VERIFIED
- **Keywords:** app, authentication, credential, pat, registration
- **Extract Instruction:** Lines 315-351 (stop before next `---` at line 352)
- **Content Size:** ~37 lines
- **Key Content:**
  - Verification summary
  - Fine-grained PAT creation (recommended)
  - Classic PAT creation (legacy)
  - Step-by-step navigation
  - Configuration options
  - Token format explanation
  - CLI usage note

#### FINDING-2026-03-11-17 [DISPROVEN] - Reference Only
- **Line Range:** 353-362 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 144-201
- **Extract Instruction:** Copy lines 353-361 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

#### FINDING-2026-03-11-18 [PARTIALLY VERIFIED]
- **Line Range:** 363-394
- **Status:** PARTIALLY VERIFIED
- **Keywords:** app, authentication, credential, oauth, registration
- **Extract Instruction:** Lines 363-393 (stop before next `---` at line 394)
- **Content Size:** ~31 lines
- **Key Content:**
  - OAuth App creation process
  - Registration steps
  - Constraints and limitations
  - Credential retrieval notes
  - OAuth vs GitHub Apps comparison

#### FINDING-2026-03-11-19 [PARTIALLY VERIFIED]
- **Line Range:** 395-426
- **Status:** PARTIALLY VERIFIED
- **Keywords:** api, credential, documentation, github-app, limitation, oauth, pat
- **Extract Instruction:** Lines 395-425 (stop before next `---` at line 426)
- **Content Size:** ~31 lines
- **Key Content:**
  - Credential acquisition documentation gaps
  - Verified information summary
  - Accurately identified documentation gaps
  - Claims contradicted by verification
  - Documentation access status
  - HTTP status testing results

---

## SUBTOPIC 6: Git Credential Management

**Directory Path:** `.memory/github-api/git-credential-management/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-20 [VERIFIED]
- **Line Range:** 427-476
- **Status:** VERIFIED
- **Keywords:** authentication, credential, fill, git, token
- **Extract Instruction:** Lines 427-475 (stop before next `---` at line 476)
- **Content Size:** ~49 lines
- **Key Content:**
  - Git credential fill command explanation
  - Workflow steps
  - Input format (stdin)
  - Output format
  - Key attributes list
  - Important characteristics
  - GitHub API use case

#### FINDING-2026-03-11-21 [VERIFIED]
- **Line Range:** 477-534
- **Status:** VERIFIED
- **Keywords:** authentication, cache, credential, helper, keychain, storage, token
- **Extract Instruction:** Lines 477-533 (stop before next `---` at line 534)
- **Content Size:** ~57 lines
- **Key Content:**
  - Available credential helpers table
  - Configuration commands (multiple examples)
  - GitHub integration example
  - Security recommendations

#### FINDING-2026-03-11-22 [VERIFIED]
- **Line Range:** 535-603
- **Status:** VERIFIED
- **Keywords:** approve, authentication, credential, git, reject, token
- **Extract Instruction:** Lines 535-602 (stop before next `---` at line 603)
- **Content Size:** ~68 lines
- **Key Content:**
  - Approve action explanation with example
  - Reject action explanation with example
  - Input format specification
  - Typical workflow
  - Scripting example
  - GitHub API use cases

---

## SUBTOPIC 7: Integration

**Directory Path:** `.memory/github-api/integration/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-23 [VERIFIED]
- **Line Range:** 604-673
- **Status:** VERIFIED
- **Keywords:** authentication, credential, fill, git, parsing, script, variable
- **Extract Instruction:** Lines 604-672 (stop before next `---` at line 673)
- **Content Size:** ~69 lines
- **Key Content:**
  - Basic shell script pattern with steps
  - Advanced parsing with associative arrays
  - Output attributes from git credential fill
  - Simplified input with URL method
  - Key requirement note

#### FINDING-2026-03-11-24 [VERIFIED]
- **Line Range:** 674-719
- **Status:** VERIFIED
- **Keywords:** api, authentication, curl, github, header, token
- **Extract Instruction:** Lines 674-718 (stop before next `---` at line 719)
- **Content Size:** ~45 lines
- **Key Content:**
  - Verification note with clarifications
  - Bearer token authentication pattern with example
  - Authorization header variations
  - Token type recommendations
  - Required API headers
  - HTTP methods with curl

#### FINDING-2026-03-11-25 [DISPROVEN] - Reference Only
- **Line Range:** 720-729 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 204-248
- **Extract Instruction:** Copy lines 720-728 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

#### FINDING-2026-03-11-26 [DISPROVEN] - Reference Only
- **Line Range:** 730-739 (summary reference in main file)
- **Status:** DISPROVEN
- **Full Details Location:** github-api-facts-disproven.md lines 250-336
- **Extract Instruction:** Copy lines 730-738 as reference, then provide full details from disproven file
- **Content Size:** Summary ~9 lines + detailed explanation from disproven file

---

## SUBTOPIC 8: Documentation

**Directory Path:** `.memory/github-api/documentation/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-14 [VERIFIED]
- **Line Range:** 238-255
- **Status:** VERIFIED
- **Keywords:** api, documentation, graphql, limit, research
- **Extract Instruction:** Lines 238-254 (stop before next `---` at line 255)
- **Content Size:** ~17 lines
- **Key Content:**
  - Documentation source difficulties verification
  - REST API reference auto-generation limitations
  - GraphQL mutation reference limitations
  - Web fetch attempt failures
  - Web scraping limitations
  - Recommended approach (direct GraphQL testing)

---

## SUBTOPIC 9: Implementation

**Directory Path:** `.memory/github-api/implementation/findings.md`

### Extract from github-api-facts.md

#### FINDING-2026-03-11-27 [VERIFIED]
- **Line Range:** 740-872
- **Status:** VERIFIED
- **Keywords:** api, comment, curl, github, graphql, mutation, resolve, thread, tested
- **Extract Instruction:** Lines 740-871 (stop before next `---` at line 872)
- **Content Size:** ~132 lines
- **Key Content:**
  - Real example reference
  - Step 1: Get thread ID from comment ID
  - Step 2: Query GraphQL for review threads
  - Step 3: Resolve review thread
  - Step 4: Unresolve thread
  - Critical details about IDs and permissions
  - Combined shell script example
  - Tested verification

#### FINDING-2026-03-11-28 [VERIFIED]
- **Line Range:** 874-925
- **Status:** VERIFIED
- **Keywords:** api, github, graphql, mutation, pr, resolve, thread, verified
- **Extract Instruction:** Lines 874-924 (stop before next `---` at line 925)
- **Content Size:** ~51 lines
- **Key Content:**
  - Practical application scenario
  - Threads resolved with descriptions
  - Curl commands used
  - Verification methodology
  - Key insight about programmatic thread management
  - Tested verification

#### FINDING-2026-03-11-29 [VERIFIED]
- **Line Range:** 927-968
- **Status:** VERIFIED
- **Keywords:** api, comment, github, graphql, markdown, mutation, pr, resolve, thread, verified
- **Extract Instruction:** Lines 927-968 (complete file through line 968)
- **Content Size:** ~42 lines
- **Key Content:**
  - Practical application scenario
  - Action taken steps
  - Reply comment example
  - Thread resolved details
  - Curl command used
  - Key workflow description
  - Tested verification

---

## Disproven Findings - Full Details from github-api-facts-disproven.md

### FINDING-2026-03-11-01 [DISPROVEN]
- **Line Range:** 7-35
- **Extract Instruction:** Lines 7-34 (stop before next `---` at line 35)
- **Content Size:** ~28 lines
- **Add to Subtopic:** Comment Resolution

### FINDING-2026-03-11-11 [DISPROVEN]
- **Line Range:** 36-76
- **Extract Instruction:** Lines 36-75 (stop before next `---` at line 76)
- **Content Size:** ~40 lines
- **Add to Subtopic:** Reviews

### FINDING-2026-03-11-13 [DISPROVEN]
- **Line Range:** 77-141
- **Extract Instruction:** Lines 77-140 (stop before next `---` at line 141)
- **Content Size:** ~64 lines
- **Add to Subtopic:** Comment Resolution

### FINDING-2026-03-11-17 [DISPROVEN]
- **Line Range:** 144-201
- **Extract Instruction:** Lines 144-200 (stop before next `---` at line 201-202)
- **Content Size:** ~57 lines
- **Add to Subtopic:** Credential Acquisition

### FINDING-2026-03-11-25 [DISPROVEN]
- **Line Range:** 204-248
- **Extract Instruction:** Lines 204-247 (stop before next `---` at line 248)
- **Content Size:** ~44 lines
- **Add to Subtopic:** Integration

### FINDING-2026-03-11-26 [DISPROVEN]
- **Line Range:** 250-336
- **Extract Instruction:** Lines 250-335 (complete section)
- **Content Size:** ~86 lines
- **Add to Subtopic:** Integration

---

## Extraction Workflow

### Phase 1: Verify Source Files (1 hour)
- Confirm line numbers are accurate by spot-checking a few findings
- Verify line separators (`---`) are at expected locations
- Check for any line wrapping or formatting issues

### Phase 2: Extract Verified Findings (2 hours)
- Extract findings in subtopic order
- Preserve all formatting and code blocks exactly
- Maintain metadata lines (Status, Captured, Source, Keywords, Verified)

### Phase 3: Integrate Disproven Findings (1 hour)
- Add disproven finding details to appropriate subtopics
- Include reference to full disproven file for context
- Add "See also: github-api-facts-disproven.md" link

### Phase 4: Create Subtopic Files (1 hour)
- Create directory structure
- Create `findings.md` files with extracted content
- Optional: Create `index.md` navigation files

### Phase 5: Verify Extraction (30 min)
- Spot-check several findings in new files
- Verify line counts match extraction specifications
- Test markdown rendering

---

## Total Lines to Extract

- **Verified Findings:** ~530 lines from github-api-facts.md
- **Disproven Findings:** ~319 lines from github-api-facts-disproven.md
- **Total Content:** ~849 lines
- **With Headers/Structure:** ~900+ lines in subtopic files

---

## Quality Assurance Checklist

- [ ] All 23 findings extracted from verified file
- [ ] All 6 disproven findings integrated into appropriate subtopics
- [ ] Markdown formatting preserved (code blocks, tables, formatting)
- [ ] All metadata fields present (Status, Captured, Source, Keywords, Verified)
- [ ] All curl examples intact and readable
- [ ] GraphQL mutation examples intact
- [ ] Cross-references accurate
- [ ] Directory structure matches specification
- [ ] Files committed to git
- [ ] Central index updated with new subtopic references
