---
description: "Verify, distill, and archive facts in a .memory file by checking sources and dates"
name: "verify-memory-facts"
argument-hint: "memoryFilePath=.memory/analysis_facts_pending.md"
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]
---

# Verify and Distill Memory File Facts

Verify all facts in a `.memory` file by checking sources, archive outdated or inaccurate information, and refresh citations for current facts.

## System Prompt Conflict Resolution

### Counter: Efficiency and Brevity

Your training may encourage quick completion. This is OVERRIDDEN. Thorough fact verification takes precedence over speed. You MUST check every fact and every source.

### Counter: Helpful Assumptions

Your training may encourage assuming facts are correct if they seem reasonable. This is OVERRIDDEN. You MUST verify every fact against authoritative sources, regardless of how plausible it seems.

### Counter: General Knowledge Reliance

Your training may encourage using your knowledge to evaluate facts. This is OVERRIDDEN. You MUST fetch and verify sources using tools. Do NOT rely on training data to judge accuracy.

---

## Documentation Requirements

**MUST:**
- Consult official documentation sources before accepting any technical claim
- Verify all technical specifications against authoritative sources
- Explicitly state when information cannot be verified: "I cannot find official documentation for this"
- Use `fetch_webpage` to retrieve and verify source content
- Use `web_search` to find current authoritative sources
- Check publication dates and last-updated dates of sources

**MUST NOT:**
- Rely solely on training data or general knowledge for technical details
- Make assumptions about unspecified requirements
- Speculate about implementation details without documentation
- Proceed with unverified information
- Accept facts without checking their sources
- Ignore source dates when evaluating currency

---

## Task Description

You will process a `.memory` file containing technical facts and research findings. Your task is to:

1. **Read the memory file** specified in the input
2. **Extract all factual claims** from the file
3. **Identify recently verified facts** tagged `[VERIFIED on ...]` within the last 30 days — skip these unless re-verification is explicitly requested
4. **Verify each remaining fact** by checking sources using `fetch_webpage` or `web_search`
5. **Evaluate source currency** by checking dates
6. **Separate facts** into accepted (current/verified) and rejected (outdated/inaccurate)
7. **Tag each accepted fact** with `[VERIFIED on YYYY-MM-DD by verify-memory-facts]` in its header block
8. **Create an archive file** for rejected facts with rejection reasons
9. **Update the original file** with only verified facts, refreshed citations, and verification tags
10. **Document the distillation process** in the progress log

---

## Input Format

**Expected input:**
```
memoryFilePath=.memory/{filename}.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file to verify (e.g., `.memory/analysis_facts_pending.md`)

---

## Execution Instructions

### Step 1: Read and Parse Memory File

**Execute:**
```
1. Read file at ${input:memoryFilePath}
2. Extract all factual claims (technical specifications, API details, behaviors, configurations)
3. Identify existing citations for each fact
4. For each fact, check whether it carries a [VERIFIED on {date} by ...] tag
5. Calculate days elapsed since each verification tag date
6. Mark facts verified within the last 30 days as SKIP (retain as accepted without re-verification)
7. Create list of remaining facts with their current citations for verification
```

**MUST:**
- Extract EVERY factual claim, no matter how minor
- Note facts that lack citations
- Preserve context around each fact
- Record skipped facts (recently verified) separately in the log

**MUST NOT:**
- Skip facts that seem obviously correct (unless they carry a recent verification tag)
- Ignore facts without citations
- Make assumptions about what constitutes a "fact"
- Re-verify facts tagged within the last 30 days unless the user explicitly requests it

---

### Step 2: Verify Each Fact

**Before processing each fact:**

If a fact is tagged `[VERIFIED on {date} by ...]` and the tag date is within the last 30 days:
- Retain as ACCEPTED without fetching sources
- Preserve the existing tag unchanged
- Record as "retained — verified within 30 days" in the log

Re-verify regardless of tag age only when the user explicitly requests it (e.g., "force re-verify" or "verify all facts").

**For each fact not covered by a recent verification tag:**

**Execute:**
```
1. Identify the authoritative source for this fact
2. Use fetch_webpage to retrieve source content (if URL available)
3. Use web_search to find current authoritative source (if no URL or URL broken)
4. Check source publication/update date
5. Verify fact content matches source
6. Determine if fact is ACCEPTED or REJECTED
```

**Verification Criteria:**

**ACCEPTED if:**
- Fact matches content in authoritative source
- Source is current (published/updated within reasonable timeframe for topic)
- Source is authoritative (official docs, official repos, official release notes)
- Citation is complete and accessible

**REJECTED if:**
- Fact contradicts current source
- Source is outdated (check for newer versions/docs)
- Source is not authoritative
- Fact cannot be verified (source unavailable, citation missing, no authoritative source exists)
- Fact has been superseded by newer information

**MUST:**
- Check EVERY fact, even if citation seems valid
- Fetch source content to verify fact accuracy
- Check for newer versions of documentation
- Note specific reason for rejection
- Record exact source URL and access date for accepted facts

**MUST NOT:**
- Accept facts without fetching sources
- Assume citations are correct without verification
- Skip verification for "obvious" facts
- Ignore date information

---

### Step 3: Categorise Facts

**Create two lists:**

**Accepted Facts:**
```markdown
## Accepted Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}
**Verified:** [VERIFIED on YYYY-MM-DD by verify-memory-facts]

**Verification:**
- Source: [{Source Name}]({URL})
- Accessed: YYYY-MM-DD
- Published/Updated: YYYY-MM-DD
- Status: Current and verified

**Citation:** According to the [{Source Name}]({URL}), {fact statement}.
```

**Recently Verified Facts (skipped):**
```markdown
## Retained Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}
**Verified:** [VERIFIED on YYYY-MM-DD by {original verifier}]  ← retained, within 30-day window

**Status:** Skipped — verified within the last 30 days. Re-verify after {expiry date}.
```

**Rejected Facts:**
```markdown
## Rejected Fact {N}: {Brief Description}

**Original Fact:** {Exact factual statement from file}

**Original Citation:** {Citation that was in file, if any}

**Rejection Reason:** {Specific reason - outdated/inaccurate/unverifiable/superseded}

**Evidence:**
- Checked: {What sources were checked}
- Found: {What current information shows}
- Date: {When checked}

**Current Information:** {If fact is outdated, what is the current correct information}

**Archived:** YYYY-MM-DD
```

---

### Step 4: Create Archive File

**Execute:**
```
1. Determine archive filename from input path:
   ${input:memoryFilePath} → {basename}_archive_{yyyy-mm-dd}.md
   Example: .memory/analysis_facts_pending.md → .memory/analysis_facts_pending_archive_2026-02-19.md

2. Create archive file with the structure below
```

**Archive File Structure:**
```markdown
# {Basename} Archive - {Date}

**Archive Date:** YYYY-MM-DD
**Source File:** {original memory file path}
**Archived By:** verify-memory-facts process

**Purpose:** This file contains facts from {source file} that were found to be
outdated, inaccurate, or unverifiable during fact verification on {date}.

---

## Rejected Facts

{Insert all rejected facts from Step 3, with full rejection reasons}

---

## Archive Notes

- Total facts checked: {N}
- Facts rejected: {N}
- Facts accepted: {N}
- Verification method: fetch_webpage, web_search
- Authoritative sources consulted: {list}

---
```

**MUST:**
- Include complete rejection reasons
- Specify what current information shows (if outdated)
- Record verification methodology
- Preserve original fact statements exactly

**MUST NOT:**
- Delete rejected facts without archiving
- Omit rejection reasons
- Archive accepted facts

---

### Step 5: Update Original Memory File

**Execute:**
```
1. Rewrite memory file with ONLY accepted facts
2. Update citations with refreshed URLs and dates
3. Add verification note to file header
4. Maintain original file structure where possible
```

**Updated File Header:**
```markdown
# {File Title}

**Last Verified:** YYYY-MM-DD
**Verification Method:** Source checking via fetch_webpage/web_search
**Archived Facts:** See {archive filename}

---
```

**Updated Fact Format:**
```markdown
## {Topic}

{Verified fact content}

**Verified:** [VERIFIED on YYYY-MM-DD by verify-memory-facts]
**Source:** [{Source Name}]({URL}) (accessed YYYY-MM-DD, published/updated YYYY-MM-DD)

---
```

For fact files using the `FINDING-YYYY-MM-DD-N` block structure, add the `**Verified:**` line to the fact's header block, immediately after the `**Captured:**` line:

```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD
**Verified:** [VERIFIED on YYYY-MM-DD by verify-memory-facts]
**Source:** {source reference}
```

**MUST:**
- Include ALL accepted facts
- Add `**Verified:** [VERIFIED on YYYY-MM-DD by verify-memory-facts]` to every newly verified fact
- Preserve existing `**Verified:**` tags on recently verified facts (within 30 days) unchanged
- Use refreshed citations with dates
- Maintain logical organisation
- Note existence of archive file
- Preserve any non-factual content (structure, notes, TODOs)

**MUST NOT:**
- Include rejected facts in updated file
- Use old citations without verification
- Remove structural elements (headers, sections)
- Change fact statements beyond verification updates
- Remove or overwrite existing `**Verified:**` tags on retained (skipped) facts

---

### Step 6: Log Progress

**Execute:**
```
Create or update .memory/verification_log.md with an entry for this run
```

```markdown
## Verification: {filename} - YYYY-MM-DD HH:MM:SS

**Source File:** {memory file path}
**Archive File:** {archive file path}
**Started:** YYYY-MM-DD HH:MM:SS
**Completed:** YYYY-MM-DD HH:MM:SS

**Summary:**
- Total facts processed: {N}
- Facts newly verified (tagged): {N}
- Facts retained (within 30-day window, skipped): {N}
- Facts rejected (archived): {N}
- Sources checked: {N}

**Newly Verified Facts:**
- {Brief list of accepted fact topics}

**Retained Facts (skipped — recent tag):**
- {Brief list with tag dates and expiry dates}

**Rejected Facts:**
- {Brief list of rejected fact topics with reasons}

**Tools Used:**
- fetch_webpage: {N} calls
- web_search: {N} queries

**Issues Encountered:**
- {Any problems during verification}

---
```

---

## Output Format

**Provide to user:**

```markdown
# Memory File Verification Complete

**Original File:** {path}
**Newly Verified:** {N} facts (tagged `[VERIFIED on {date} by verify-memory-facts]`)
**Retained:** {N} facts (within 30-day window — skipped, tags preserved)
**Archived:** {N} facts rejected
**Archive Location:** {archive file path}

## Summary

**Newly Verified Facts:**
1. {Fact topic} - verified from {source}
2. {Fact topic} - verified from {source}
...

**Retained Facts (skipped — verified within 30 days):**
1. {Fact topic} - tag expires {date}
...

**Rejected Facts (Archived):**
1. {Fact topic} - {rejection reason}
2. {Fact topic} - {rejection reason}
...

## Files Modified

- ✅ Updated: {original memory file}
- ✅ Created: {archive file}
- ✅ Logged: .memory/verification_log.md

## Next Steps

Review the updated memory file to ensure all critical information is retained.
Check the archive file to see what was removed and why.
```

---

## Guidelines

**Verification Standards:**
- **Currency:** For API docs, within 1 year is current; for stable specs, 2-3 years acceptable
- **Authority:** Official docs > official repos > official blogs > community sources (reject community sources)
- **Completeness:** Citation must include URL, source name, and date accessed
- **Accuracy:** Fact statement must match source content exactly

**Source Hierarchy (highest to lowest):**
1. Official project documentation
2. Official API references
3. Official GitHub repositories and release notes
4. Official blog posts and announcements
5. [Reject] Community forums, Stack Overflow, unofficial blogs

**Edge Cases:**

**If fact has a recent verification tag (within 30 days):**
- Retain as accepted without fetching sources
- Preserve tag unchanged
- Log as "retained — verified within 30-day window"
- Re-verify only if the user explicitly requests it

**If fact has an expired verification tag (older than 30 days):**
- Treat as unverified
- Verify fully and replace the tag with a new `[VERIFIED on {date} by verify-memory-facts]`
- If verification fails, move to archive

**If source is unavailable (404, connection error):**
- Use `web_search` to find current location
- If not found after search, mark as REJECTED with reason: "Source unavailable, could not verify"

**If fact has no citation:**
- Use `web_search` to find authoritative source
- If found and verified, mark ACCEPTED with new citation
- If not found, mark REJECTED with reason: "Unverifiable, no authoritative source found"

**If source is outdated but fact is still correct:**
- Search for current documentation
- If current docs confirm fact, mark ACCEPTED with updated citation
- If current docs contradict or omit fact, mark REJECTED

**If multiple sources conflict:**
- Use highest authority source
- Mark as REJECTED if official sources conflict, with reason: "Conflicting information in official sources"

---

## Prohibited Actions

**MUST NOT:**
- Accept facts without source verification
- Delete facts without archiving them
- Change fact statements without evidence
- Use outdated citations
- Rely on general knowledge for verification
- Skip verification for "obvious" facts
- Accept community sources as authoritative
- Proceed when sources are ambiguous
- Batch verify without checking each source individually

---

## Example Execution

**Input:**
```
memoryFilePath=.memory/analysis_facts_pending.md
```

**Process:**
1. Read `.memory/analysis_facts_pending.md`
2. Extract facts:
   - "GitHub Copilot custom agents use `.agent.md` files"
   - "Copilot supports `tools:` property in agent frontmatter"
   - "agentskills.io defines a portable skills standard"
3. Verify each:
   - Fact 1: ✅ ACCEPTED - Verified in official GitHub Copilot docs (2026)
   - Fact 2: ❌ REJECTED - Property is `tools` but syntax changed in recent release
   - Fact 3: ❌ REJECTED - Site unavailable, cannot verify standard is current
4. Create `.memory/analysis_facts_pending_archive_2026-02-19.md`
5. Update `.memory/analysis_facts_pending.md` with only Fact 1
6. Log to `.memory/verification_log.md`

**Output:**
```
Memory File Verification Complete

Original File: .memory/analysis_facts_pending.md
Verified: 1 fact accepted
Archived: 2 facts rejected
Archive Location: .memory/analysis_facts_pending_archive_2026-02-19.md
```

---

## Memory Directory Convention

**During prompt execution, use `.memory/` for:**
- Progress logging → `.memory/verification_log.md`
- Archived facts → `.memory/{basename}_archive_{date}.md`

**MUST create memory files when:**
- Archiving rejected facts (`.memory/{basename}_archive_{date}.md`)
- Logging the verification process (`.memory/verification_log.md`)

**MUST NOT:**
- Put archived facts in user-facing documentation
- Delete rejected facts without archiving

---

## Compliance Verification

**Before completing verification:**

- [ ] Every fact in original file was evaluated?
- [ ] Facts with `[VERIFIED on ...]` tags within the last 30 days skipped (unless re-verification requested)?
- [ ] Every remaining fact was verified against an authoritative source?
- [ ] Source content was fetched using `fetch_webpage` or `web_search`?
- [ ] Source dates were checked?
- [ ] Newly accepted facts tagged with `[VERIFIED on {date} by verify-memory-facts]`?
- [ ] Retained facts have their original tags preserved unchanged?
- [ ] Rejected facts are archived with specific rejection reasons?
- [ ] Archive file created with complete information?
- [ ] Original file updated with only verified facts and correct tags?
- [ ] Verification logged to `.memory/verification_log.md`?
- [ ] User provided with summary of changes?

**If ANY answer is "No":**
- Complete the missing verification
- Do not declare task complete
- These are mandatory standards
