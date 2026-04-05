# 5.1 Finding Structure Specification

## Table of Contents

- [5.1.1 Overview](#5-1-1-overview)
  - [5.1.1.1 Purpose](#5-1-1-1-purpose)
  - [5.1.1.2 Format](#5-1-1-2-format)
- [5.1.2 Frontmatter Fields](#5-1-2-frontmatter-fields)
  - [5.1.2.1 Required Fields](#5-1-2-1-required-fields)
  - [5.1.2.2 Optional Fields](#5-1-2-2-optional-fields)
  - [5.1.2.3 Field Constraints](#5-1-2-3-field-constraints)
- [5.1.3 Body Structure](#5-1-3-body-structure)
  - [5.1.3.1 Metadata Fields](#5-1-3-1-metadata-fields)
  - [5.1.3.2 Content Sections](#5-1-3-2-content-sections)
- [5.1.4 Validation Rules](#5-1-4-validation-rules)
  - [5.1.4.1 Finding Identifiers](#5-1-4-1-finding-identifiers)
  - [5.1.4.1 Date and Time Format](#5-1-4-2-date-and-time-format)
  - [5.1.4.3 Verification Status Values](#5-1-4-3-verification-status-values)
- [5.1.5 Complete Example](#5-1-5-complete-example)
  - [5.1.5.1 Example: Research Finding](#5-1-5-1-example-research-finding)
  - [5.1.5.2 Example: Observation with Clarification](#5-1-5-2-example-observation-with-clarification)

---

## 5.1.1 Overview

[↑ Back to Top](#table-of-contents)

### 5.1.1.1 Purpose

Findings capture research discoveries, observations, theories, hypotheses, and dead ends during systematic investigation. Each finding is a discrete unit of knowledge recorded with full provenance (source, timestamp, verification status).

[↑ Back to Top](#table-of-contents)

### 5.1.1.2 Format

Findings use Markdown with YAML frontmatter. The structure separates metadata (frontmatter) from content (body).

**Structure:**
```
---
[YAML frontmatter with metadata]
---

### FINDING-YYYY-MM-DD-N

**Captured:** YYYY-MM-DD HH:MM
**Source:** [citation]
**Verified:** [verification status]

[Finding description content]
```

[↑ Back to Top](#table-of-contents)

---

## 5.1.2 Frontmatter Fields

[↑ Back to Top](#table-of-contents)

### 5.1.2.1 Required Fields

**`name`**
- Type: String
- Description: Short display name for the finding (distinct from the FINDING-YYYY-MM-DD-N identifier)
- Example: `Research API Rate Limits`
- Constraint: Maximum 100 characters, descriptive prose (not just identifier)

**`finding_id`**
- Type: String
- Description: Unique identifier assigned by fact-capture flow
- Format: `FINDING-YYYY-MM-DD-N` where N is sequence number for that date
- Example: `FINDING-2026-04-04-1`
- Constraint: Must match pattern `FINDING-\d{4}-\d{2}-\d{2}-\d+`

**`captured_date`**
- Type: String
- Description: Date and time when finding was recorded
- Format: `YYYY-MM-DD HH:MM` (24-hour time, UTC)
- Example: `2026-04-04 10:15`

**`topic`**
- Type: String
- Description: Research topic slug (e.g., topic-name from `.memory/topic-name/`)
- Example: `github-api`
- Constraint: Lowercase alphanumeric and hyphens only

**`source`**
- Type: String
- Description: Citation to authoritative source where finding originated
- Options: URL, file path, documentation reference, or "User observation"
- Example: `https://docs.github.com/en/rest/guides/rate-limiting`

[↑ Back to Top](#table-of-contents)

### 5.1.2.2 Optional Fields

**`subtopic`**
- Type: String
- Description: Categorical grouping within topic if finding belongs to a specific subtopic
- Example: `authentication`
- Constraint: Used only if finding is recorded to subtopic-specific fact file

**`clarifies`**
- Type: String
- Description: FINDING-YYYY-MM-DD-N identifier of the finding this clarifies or refines
- Example: `FINDING-2026-04-04-3`
- Constraint: References must exist in the same fact file
- Use: When new information affects or refines an existing finding

**`type`**
- Type: String
- Description: Category of finding content
- Options: `fact`, `observation`, `theory`, `hypothesis`, `dead-end`, `note`
- Example: `observation`

**`keywords`**
- Type: Array of strings
- Description: Semantic keywords for discovery and cross-reference
- Example: `[api, rate-limiting, authentication]`

[↑ Back to Top](#table-of-contents)

### 5.1.2.3 Field Constraints

**Frontmatter Validation:**
- All fields MUST be valid YAML
- String values with special characters MUST be quoted
- List values use YAML array syntax
- No duplicate field names
- Fields are case-sensitive

**Example Valid Frontmatter:**
```yaml
---
name: Research API Rate Limits
finding_id: FINDING-2026-04-04-1
captured_date: 2026-04-04 10:15
topic: github-api
subtopic: authentication
source: https://docs.github.com/en/rest/guides/rate-limiting
type: observation
keywords: [api, rate-limiting, authentication]
---
```

[↑ Back to Top](#table-of-contents)

---

## 5.1.3 Body Structure

[↑ Back to Top](#table-of-contents)

### 5.1.3.1 Metadata Fields

**H3 Heading: Finding Identifier**

The body begins with an H3 heading containing the finding identifier:
```markdown
### FINDING-YYYY-MM-DD-N
```

**Captured Timestamp**

```markdown
**Captured:** YYYY-MM-DD HH:MM
```

Format: 24-hour UTC time, matching `captured_date` in frontmatter.

**Source Citation**

```markdown
**Source:** [official-name](url) or [file-path] or User observation
```

Format: Markdown link to authoritative source, or "User observation" if not externally sourced.

**Verification Status**

```markdown
**Verified:** [NOT YET VERIFIED - requires verification workflow]
```

or after verification:

```markdown
**Verified:** [VERIFIED on YYYY-MM-DD by https://source-url]
```

or if disproven:

```markdown
**Verified:** [REJECTED on YYYY-MM-DD: reason for rejection]
```

**Optional: Clarification Reference**

If this finding clarifies an existing finding:
```markdown
**Clarifies:** FINDING-YYYY-MM-DD-M
```

[↑ Back to Top](#table-of-contents)

### 5.1.3.2 Content Sections

**Finding Description (Required)**

One to three sentences describing the fact, observation, theory, hypothesis, or note. This is the core content of the finding.

Example:
```markdown
The GitHub REST API enforces rate limits per endpoint. Authentication status
and request type determine the specific limit applied. Standard authentication
allows 60 requests per hour; authenticated requests allow up to 5,000 per hour.
```

**Optional Context**

Following the core description, additional paragraphs may provide:
- Implications of the finding
- Relationship to other findings
- Open questions or uncertainties
- Hypotheses about causes

Example:
```markdown
This rate limiting affects batch operations significantly. Automated systems
should implement exponential backoff to handle 429 (rate limit) responses.
Question: Are rate limits per API token or per IP address for unauthenticated requests?
```

[↑ Back to Top](#table-of-contents)

---

## 5.1.4 Validation Rules

[↑ Back to Top](#table-of-contents)

### 5.1.4.1 Finding Identifiers

**Format:** `FINDING-YYYY-MM-DD-N`

- `YYYY`: Four-digit year
- `MM`: Two-digit month (01-12)
- `DD`: Two-digit day (01-31)
- `N`: Sequence number starting at 1 for each date

**Examples:**
- `FINDING-2026-04-04-1` (first finding recorded 2026-04-04)
- `FINDING-2026-04-04-2` (second finding recorded 2026-04-04)
- `FINDING-2026-04-05-1` (first finding recorded 2026-04-05)

**Validation Regex:**
```regex
FINDING-\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])-\d+
```

[↑ Back to Top](#table-of-contents)

### 5.1.4.2 Date and Time Format

**Date:** `YYYY-MM-DD` (ISO 8601)
**Time:** `HH:MM` (24-hour format, UTC)
**Combined:** `YYYY-MM-DD HH:MM`

Examples:
- `2026-04-04 10:15` ✓ Correct
- `2026-4-4 10:15` ✗ Wrong (single-digit month/day)
- `2026-04-04 22:30` ✓ Correct (10:30 PM)
- `2026-04-04 14:00` ✓ Correct (2:00 PM)

[↑ Back to Top](#table-of-contents)

### 5.1.4.3 Verification Status Values

**Initial Status (during research):**
```
[NOT YET VERIFIED - requires verification workflow]
```

**After Successful Verification:**
```
[VERIFIED on YYYY-MM-DD by https://source-url]
```

Examples:
- `[VERIFIED on 2026-04-05 by https://docs.github.com/en/rest]`
- `[VERIFIED on 2026-04-04 by docs/project/README.md]`

**If Disproven:**
```
[REJECTED on YYYY-MM-DD: reason for rejection]
```

Examples:
- `[REJECTED on 2026-04-05: Endpoint deprecated as of API v3]`
- `[REJECTED on 2026-04-04: User correction - value is 100 not 60]`

**If Unverifiable:**
```
[NOT YET VERIFIED - unable to verify against current sources]
```

[↑ Back to Top](#table-of-contents)

---

## 5.1.5 Complete Example

[↑ Back to Top](#table-of-contents)

### 5.1.5.1 Example: Research Finding

```markdown
---
name: GitHub REST API Rate Limiting
finding_id: FINDING-2026-04-04-1
captured_date: 2026-04-04 10:15
topic: github-api
subtopic: rate-limiting
source: https://docs.github.com/en/rest/guides/rate-limiting
type: observation
keywords: [api, rate-limiting, authentication, github]
---

### FINDING-2026-04-04-1

**Captured:** 2026-04-04 10:15
**Source:** [GitHub REST API Rate Limiting Documentation](https://docs.github.com/en/rest/guides/rate-limiting)
**Verified:** [NOT YET VERIFIED - requires verification workflow]

The GitHub REST API enforces rate limits per endpoint, with limits varying by
authentication status and request type. Unauthenticated requests are limited to
60 per hour; authenticated requests are limited to 5,000 per hour.

Rate limits are tracked using either the request origin IP address
(unauthenticated) or the authenticated user's API token (authenticated). The
API returns rate limit information in response headers: `X-RateLimit-Limit`,
`X-RateLimit-Remaining`, and `X-RateLimit-Reset`.
```

[↑ Back to Top](#table-of-contents)

### 5.1.5.2 Example: Observation with Clarification

```markdown
---
name: API Rate Limit Reset Timing
finding_id: FINDING-2026-04-04-3
captured_date: 2026-04-04 10:45
topic: github-api
subtopic: rate-limiting
source: https://docs.github.com/en/rest/guides/rate-limiting
type: observation
clarifies: FINDING-2026-04-04-1
keywords: [api, rate-limiting, reset-timing]
---

### FINDING-2026-04-04-3

**Captured:** 2026-04-04 10:45
**Source:** [GitHub REST API Rate Limiting Documentation](https://docs.github.com/en/rest/guides/rate-limiting)
**Verified:** [NOT YET VERIFIED - requires verification workflow]
**Clarifies:** FINDING-2026-04-04-1

The `X-RateLimit-Reset` header provides the Unix timestamp (seconds since epoch)
when the rate limit window resets. This is essential for implementing exponential
backoff strategies in client applications.

The rate limit window resets on a per-endpoint basis, not globally. This means
different endpoints may have different reset times depending on when requests
were made to each endpoint.
```

[↑ Back to Top](#table-of-contents)

---
