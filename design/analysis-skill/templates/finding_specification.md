# Finding Structure Specification

**When you implement finding capture, use this specification to understand what you MUST create when recording a finding.**

This specification assumes a folder structure where findings are stored in a `findings/` directory, terms are stored in a `terms/` directory, and sources are stored in a `sources/` directory.

---

## Frontmatter Requirements

When you create a finding file, you MUST include a YAML frontmatter block with the following fields:

### Required Fields

**`name`**
- Type: String
- Short descriptive name for the finding
- Example: `Research API Rate Limits`

**`summary`**
- Type: String
- One sentence summary
- Example: `GitHub REST API enforces rate limits based on authentication status`

**`description`**
- Type: String
- Three sentence description
- Example: `The API limits requests per hour. Unauthenticated requests are limited more strictly than authenticated ones. Different endpoints may have different limits.`

**`type`**
- Type: String
- Options: `research`, `analysis`, `exploration`
- Example: `research`

**`support`**
- Type: String
- Options: `internal`, `external`
- Example: `external`

**`verification-status`**
- Type: String
- Options: `verified`, `unverified`, `disproved`, `expired`
- Example: `unverified`

**`verification-date`**
- Type: String
- Format: `YYYY-MM-DD HH:MM`
- Example: `2026-04-04 10:15`

### Optional Fields

**`terms`**
- Type: Array of strings
- References to term files in the `terms/` directory
- Specify filenames without directory path
- Example: `[api.md, rate-limiting.md]`

**`sources`**
- Type: Array of strings
- References to source files in the `sources/` directory containing source text and verification details
- Specify filenames without directory path
- Example: `[github-rest-api-docs.md, rate-limiting-guide.md]`

**`related`**
- Type: Array of strings
- References to related finding files in the `findings/` directory
- Specify filenames without directory path
- Example: `[finding-authentication.md]`

### Frontmatter Format

You MUST format frontmatter as valid YAML. Example:

```yaml
---
name: GitHub REST API Rate Limiting
summary: GitHub REST API enforces rate limits based on authentication status
description: The API limits requests per hour depending on whether the request is authenticated. Unauthenticated requests are limited more strictly than authenticated ones. Different endpoints may have different limits and reset times.
type: research
support: external
verification-status: unverified
verification-date: 2026-04-04 10:15
terms:
  - api.md
  - rate-limiting.md
sources:
  - github-rest-api-docs.md
  - rate-limiting-guide.md
related:
  - finding-authentication.md
---
```

---

## Body Requirements

When you create a finding file, you MUST structure the body as follows:

### H1 Heading

You MUST create an H1 heading:

```markdown
# Finding: <name>
```

### Summary Section

You MUST create a Summary section with an H2 heading and the one sentence summary:

```markdown
## Summary

<one sentence summary>
```

### Description Section

You MUST create a Description section with an H2 heading and the three sentence description:

```markdown
## Description

<three sentence description>
```

### Conditional Sections

Depending on the finding type, you MAY include additional sections:

**For research queries:**
```markdown
## Conclusions

<numbered conclusions comprising finding, with source links to external information>

## Citations

<citations supporting conclusions from external documentation>
```

**For procedural queries:**
```markdown
## Steps

<numbered steps to perform action requested by "How do I..." query, with source links to external documentation>

## Proofs

<verification or test results proving the procedure works>
```

### Complete Example

```markdown
# Finding: GitHub REST API Rate Limiting

## Summary

GitHub REST API enforces rate limits based on authentication status.

## Description

The API limits requests per hour depending on whether the request is authenticated.
Unauthenticated requests are limited more strictly than authenticated ones.
Different endpoints may have different limits and reset times.

## Conclusions

1. Rate limits are enforced per endpoint, not globally across the API
2. Authentication status determines the rate limit applied
3. Clients should implement exponential backoff to handle rate limit responses
```

---
