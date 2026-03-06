# Edge Cases

Handling special situations during fact verification.

---

## Fact Has Recent Verification Tag (within 30 days)

- Retain as accepted without fetching sources
- Preserve tag unchanged
- Log as "retained — verified within 30-day window"
- Re-verify only if the user explicitly requests it

---

## Fact Has Expired Verification Tag (older than 30 days)

- Treat as unverified
- Verify fully and replace the tag with a new `[VERIFIED on {date} by {source-url}] ([details]({verification-working-file}#finding-id))`
- If verification fails, move to archive

---

## Source Is Unavailable (404, connection error)

- Use WebSearch to find current location
- If not found after search, mark as REJECTED with reason: "Source unavailable, could not verify"

---

## Fact Has No Citation

- Use WebSearch to find authoritative source
- If found and verified, mark ACCEPTED with new citation
- If not found, mark REJECTED with reason: "Unverifiable, no authoritative source found"

---

## Source Is Outdated but Fact Is Still Correct

- Search for current documentation using WebSearch
- If current docs confirm fact, mark ACCEPTED with updated citation
- If current docs contradict or omit fact, mark REJECTED

---

## Multiple Sources Conflict

- Use highest authority source
- Mark as REJECTED if official sources conflict, with reason: "Conflicting information in official sources"
