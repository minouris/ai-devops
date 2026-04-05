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
- Specify UUIDs without directory path or .md extension
- Example: `[a1b2c3d4-e5f6-4g7h-8i9j-0k1l2m3n4o5p, b2c3d4e5-f6g7-4h8i-9j0k-1l2m3n4o5p6q]`

**`sources`**
- Type: Array of strings
- References to source files in the `sources/` directory containing source text and verification details
- Specify UUIDs without directory path or .md extension
- Example: `[a1b2c3d4-e5f6-4g7h-8i9j-0k1l2m3n4o5p, b2c3d4e5-f6g7-4h8i-9j0k-1l2m3n4o5p6q]`

**`related`**
- Type: Array of strings
- References to related finding files in the `findings/` directory
- Specify UUIDs without directory path or .md extension
- Example: `[c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r]`

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
  - a1b2c3d4-e5f6-4g7h-8i9j-0k1l2m3n4o5p
  - b2c3d4e5-f6g7-4h8i-9j0k-1l2m3n4o5p6q
sources:
  - c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r
  - d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s
related:
  - e5f6g7h8-i9j0-4k1l-2m3n-4o5p6q7r8s9t
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

You MUST create a Conclusions section with an H2 heading and numbered conclusions:

```markdown
## Conclusions

<numbered conclusions comprising finding, with source links to external information>
```

You MUST create a Citations section with an H2 heading. Each conclusion may be supported by one or more citations. Include the conclusion text, link directly to the citation in the source file (using UUID and anchor), and the supporting text from that source.

Source files may contain multiple citations. Link to specific citations within the source using markdown anchors.

Example:
```markdown
## Citations

- Conclusion "Rate limits are enforced per endpoint, not globally across the API" supported by [c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r#citation-1](../sources/c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r.md#citation-1), "Each endpoint has distinct rate limit thresholds", and [d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s#citation-2](../sources/d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s.md#citation-2), "Rate limits are calculated independently per endpoint; there is no account-wide global limit"
- Conclusion "Authentication status determines the rate limit" supported by [d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s#citation-3](../sources/d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s.md#citation-3), "Authenticated requests receive 5000 requests per hour; unauthenticated requests receive 60"
- Conclusion "Clients should implement exponential backoff" supported by [f5g6h7i8-j9k0-4l1m-2n3o-4p5q6r7s8t9u#citation-1](../sources/f5g6h7i8-j9k0-4l1m-2n3o-4p5q6r7s8t9u.md#citation-1), "Use exponential backoff strategy when receiving 429 responses"
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

## Citations

- Conclusion "Rate limits are enforced per endpoint, not globally across the API" supported by [c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r](../sources/c3d4e5f6-g7h8-4i9j-0k1l-2m3n4o5p6q7r.md), "Each endpoint has distinct rate limit thresholds", and [d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s](../sources/d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s.md), "Rate limits are calculated independently per endpoint; there is no account-wide global limit"
- Conclusion "Authentication status determines the rate limit" supported by [d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s](../sources/d4e5f6g7-h8i9-4j0k-1l2m-3n4o5p6q7r8s.md), "Authenticated requests receive 5000 requests per hour; unauthenticated requests receive 60"
- Conclusion "Clients should implement exponential backoff" supported by [f5g6h7i8-j9k0-4l1m-2n3o-4p5q6r7s8t9u](../sources/f5g6h7i8-j9k0-4l1m-2n3o-4p5q6r7s8t9u.md), "Use exponential backoff strategy when receiving 429 responses"
```

---
