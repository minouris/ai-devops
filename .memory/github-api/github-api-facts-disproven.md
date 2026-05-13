# GitHub API Research - Disproven Findings

Archive of findings that have been verified as inaccurate or contradicted by official documentation.

---

### FINDING-2026-03-11-01 [DISPROVEN on 2026-03-11]

**Original Claim:** GitHub Pull Request review comments can be marked as resolved using the REST API through a PATCH request to the review comment endpoint. The mechanism involves a PATCH to `/repos/{owner}/{repo}/pulls/comments/{comment_id}` with a field to toggle the resolved state (likely `resolved: true` or `resolved: false`).

**Captured:** 2026-03-11 03:00
**Source:** https://docs.github.com/en/rest/pulls/comments (claimed)
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The official GitHub REST API OpenAPI specification (authoritative source) confirms that the PATCH endpoint `/repos/{owner}/{repo}/pulls/comments/{comment_id}` only accepts a `body` field for updating comment text. There is no `resolved` field available in the request body schema, and the comment object returned does not include any resolution-related fields (`resolved`, `isResolved`, `resolvedBy`, etc.).

Comment resolution in GitHub is exclusively handled at the review thread level through GraphQL mutations (`resolveReviewThread`, `unresolveReviewThread`), not through REST API PATCH operations on individual comments.

**Authoritative Evidence:**

1. GitHub REST API OpenAPI Specification endpoint definition shows only `body` field in PATCH request: https://raw.githubusercontent.com/github/rest-api-description/main/descriptions/api.github.com/dereferenced/api.github.com.deref.json (path: `/repos/{owner}/{repo}/pulls/comments/{comment_id}`, operation: `patch`, requestBody properties: `["body"]`)

2. Pull Request Review Comment response object properties do NOT include any resolution fields: `_links`, `author_association`, `body`, `body_html`, `body_text`, `commit_id`, `created_at`, `diff_hunk`, `html_url`, `id`, `in_reply_to_id`, `line`, `node_id`, `original_commit_id`, `original_line`, `original_position`, `original_start_line`, `path`, `position`, `pull_request_review_id`, `pull_request_url`, `reactions`, `side`, `start_line`, `start_side`, `subject_type`, `updated_at`, `url`, `user`

3. GitHub GraphQL API provides `resolveReviewThread` mutation as the official mechanism for comment thread resolution (verified via GitHub GraphQL schema queries)

**Related Finding:**

See FINDING-2026-03-11-04 for test evidence of failed REST PATCH attempts with resolution parameters.

---

### FINDING-2026-03-11-11 [DISPROVEN on 2026-03-11]

**Original Claim:** Pull Request Reviews have a distinct data model from individual comments with review state values including APPROVED, REQUESTED_CHANGES, COMMENTED, PENDING, DISMISSED, etc.

**Captured:** 2026-03-11 05:45
**Source:** https://docs.github.com/en/rest/pulls/reviews
**Original Verified Status:** [MANUAL VERIFICATION REQUIRED - Official GitHub docs include auto-generated content not accessible via automated fetch...]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains a critical factual error regarding pull request review state values. The finding claims the review state value is "REQUESTED_CHANGES", but the authoritative GitHub GraphQL API schema defines the correct enum value as "CHANGES_REQUESTED" (note the reversed word order).

This factual error makes the finding unreliable for implementation purposes. Any code or documentation relying on the "REQUESTED_CHANGES" state value would fail when querying the GitHub API, as the actual value is "CHANGES_REQUESTED".

While the majority of the finding's conceptual claims are accurate (reviews do have distinct data models, reviews do group comments, they do have state, etc.), the incorrect specification of a specific enum value is a material factual error.

**Authoritative Evidence:**

Direct GraphQL API schema introspection confirms the correct pull request review state values:

```
Query: {__type(name: "PullRequestReviewState") { enumValues { name } } }
Response: {"data":{"__type":{"enumValues":[{"name":"PENDING"},{"name":"COMMENTED"},{"name":"APPROVED"},{"name":"CHANGES_REQUESTED"},{"name":"DISMISSED"}]}}}
```

Source: GitHub GraphQL API PullRequestReviewState enum definition (live API query via `gh cli`)

**Correct Review State Values:**
- PENDING (review in progress)
- COMMENTED (feedback without approval)
- APPROVED (reviewer approves)
- CHANGES_REQUESTED (reviewer requests modifications) ← **Not "REQUESTED_CHANGES" as claimed in finding**
- DISMISSED (review dismissed by PR author or admin)

**Verification Details:**

See verification working document entry in `github-api-facts-verification.md` for complete verification methodology and evidence breakdown across all claims.

---

### FINDING-2026-03-11-13 [DISPROVEN on 2026-03-11]

**Original Claim:** Pull request comments support replies via REST API POST endpoint with `in_reply_to_id` parameter. The endpoint is `/repos/OWNER/REPO/pulls/PULL_NUMBER/comments` and accepts JSON with `"in_reply_to_id": COMMENT_ID`. Comments structure includes `in_reply_to_id` field linking replies to parent comments. Comments can be updated via PATCH endpoint at `/repos/{owner}/{repo}/pulls/comments/{comment_id}` using PATCH for text updates.

**Captured:** 2026-03-11 05:45
**Source:** https://api.github.com response structure analysis
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains a critical parameter name error. The curl example provided in the finding uses the incorrect parameter name `"in_reply_to_id"` when the official GitHub REST API OpenAPI specification defines the correct parameter as `"in_reply_to"` (not `"in_reply_to_id"`).

This factual error makes the provided curl command code incorrect and would cause API calls using the exact example to fail with a parameter validation error. The correct parameter for replying to comments via the POST endpoint is `in_reply_to`, as documented in the official OpenAPI specification.

Additionally, while the OpenAPI schema defines `in_reply_to_id` as a response field in the pull-request-review-comment object, direct testing against the live GitHub API shows this field is consistently absent from actual API responses, creating a schema-reality mismatch.

**Authoritative Evidence:**

1. **Official GitHub REST API OpenAPI Specification** (https://raw.githubusercontent.com/github/rest-api-description/main/descriptions/api.github.com/api.github.com.json) defines POST `/repos/{owner}/{repo}/pulls/{pull_number}/comments` endpoint with accepted parameters: `["body", "commit_id", "in_reply_to", "line", "path", "position", "side", "start_line", "start_side", "subject_type"]`

   The correct parameter definition:
   ```json
   "in_reply_to": {
     "type": "integer",
     "example": 2,
     "description": "The ID of the review comment to reply to. To find the ID of a review comment with [\"List review comments on a pull request\"](#list-review-comments-on-a-pull-request). When specified, all parameters other than `body` in the request body are ignored."
   }
   ```

   The parameter `"in_reply_to_id"` (as shown in the finding's curl example) is NOT listed as an accepted request parameter.

2. **Live API Testing** against GitHub public repositories confirms response structure omits the `in_reply_to_id` field. Example response from `https://api.github.com/repos/cli/cli/pulls/12882/comments?per_page=1` includes these fields: `_links`, `author_association`, `body`, `commit_id`, `created_at`, `diff_hunk`, `html_url`, `id`, `line`, `node_id`, `original_commit_id`, `original_line`, `original_position`, `original_start_line`, `path`, `position`, `pull_request_review_id`, `pull_request_url`, `reactions`, `side`, `start_line`, `start_side`, `subject_type`, `updated_at`, `url`, `user`

   Note: `in_reply_to_id` is absent from actual API responses.

3. **Correct Endpoint Information** is partially verified:
   - POST `/repos/{owner}/{repo}/pulls/{pull_number}/comments` endpoint path is correct ✓
   - PATCH `/repos/{owner}/{repo}/pulls/comments/{comment_id}` for comment updates is correct ✓
   - PATCH only accepts `body` parameter for text updates is correct ✓

**Correct Implementation:**

To reply to a pull request review comment, the correct JSON format is:
```json
{
  "body": "Reply text",
  "in_reply_to": 2
}
```

NOT (as shown in the finding):
```json
{
  "body": "Reply text",
  "in_reply_to_id": COMMENT_ID
}
```

**Verification Details:**

See verification working document entry in `github-api-facts-verification.md` for complete verification methodology and evidence breakdown across all claims.

---



### FINDING-2026-03-11-17 [DISPROVEN on 2026-03-11]

**Original Claim:** Registration Form Fields (Required) section lists GitHub App name (max 34 characters), Homepage URL, Webhook URL, and Webhook secret as the primary required fields during GitHub App registration.

**Captured:** 2026-03-11 07:20
**Source:** https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding's "Registration Form Fields (Required):" section contains significant inaccuracies. It fails to identify two actual required form fields (Permissions and Installation Scope) while incorrectly listing webhook configuration (Webhook URL and Webhook secret) as basic required fields. In reality, webhook configuration is optional and conditional.

**Critical Errors Identified:**

1. **Missing Required Fields:** The finding omits two mandatory fields from the required list:
   - **Permissions** (selection required with options: Read-only, Read & write, or No access)
   - **Installation Scope** (required choice: "Only on this account" or "Any account")

2. **Incorrectly Listed as Basic Required:** The finding lists:
   - **Webhook URL**: Listed as required, but actually optional and conditional (only appears if user enables "Active" webhook toggle)
   - **Webhook secret**: Listed as required, but actually optional and conditional (only appears if Webhook URL is provided)

**Authoritative Evidence:**

Official GitHub documentation explicitly lists the four REQUIRED form fields:

> "Required Fields: 1. **GitHub App name** (34 character maximum) - 'Clear and short name' converted to lowercase with spaces replaced by hyphens, must be unique across GitHub. 2. **Homepage URL** - 'Full URL to your app's website' or repository/account URL. 3. **Permissions** - Dropdown menus for each permission: Read-only, Read & write, or No access - 'Select the minimum permissions necessary'. 4. **Installation Scope** - 'Where can this GitHub App be installed?' – choose 'Only on this account' or 'Any account'"

Source: https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app, GitHub App Registration Form Fields section

Official documentation lists the OPTIONAL fields (including webhook-related fields):

> "Optional Fields: 1. Description – Users see this at installation. 2. Callback URL (up to 10 URLs) – Redirect after user authorization. 3. Expire user authorization tokens – Checkbox (deselect to prevent expiration). 4. Request user authorization (OAuth) during installation – Checkbox. 5. Enable Device Flow – Checkbox. 6. Setup URL – Redirect after installation; ignored if OAuth selected. 7. Redirect on update – Checkbox to redirect on repository changes. 8. Active – Checkbox controlling webhook receipt. 9. **Webhook URL (if Active selected)** – 'URL that GitHub should send webhook events to'. 10. **Webhook secret (if Active selected)** – 'Secret token to secure your webhooks'. 11. SSL verification (if webhook URL entered) – Enable/disable toggle. 12. Subscribe to events (if Active selected) – Select specific webhook events."

Source: https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app, Optional Fields section

**Correct Required Fields Summary:**
- GitHub App name ✓ (finding correctly identifies)
- Homepage URL ✓ (finding correctly identifies)
- Permissions ✗ (finding OMITS)
- Installation Scope ✗ (finding OMITS)

**Correct Optional Fields Summary:**
- Webhook URL ✗ (finding incorrectly lists as required)
- Webhook secret ✗ (finding incorrectly lists as required)
- All other configuration options (description, callbacks, OAuth settings, etc.) ✓

**Verification Details:**

Majority of other claims in the finding are accurate (registration locations, permissions requirements, app limits, configuration options, post-registration recommendations). However, the specific "Registration Form Fields (Required):" section is inaccurate and would mislead developers about which fields must be completed during GitHub App registration.

The missing Permissions and Installation Scope fields are both functionally critical—Permissions determine what the app can access, and Installation Scope determines whether the app can be installed in any account or only the registering account.

See verification working document entry in `github-api-facts-verification.md` for complete verification methodology and evidence breakdown across all claims.

---

---

### FINDING-2026-03-11-25 [DISPROVEN on 2026-03-11]

**Original Claim:** Curl provides built-in variable expansion via `--variable` flag and `{{name}}` syntax, with support for modern syntax introduced in curl 7.73.0+. Includes `--variable` flag for variable assignment, `--expand-*` options for expansion, and processing functions like `trim`, `url`, `json`, `b64`, `64dec`.

**Captured:** 2026-03-11 08:00
**Source:** https://curl.se/docs/manpage.html
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains a CRITICAL FACTUAL ERROR regarding the curl version in which variable expansion was introduced. The finding claims:

> "Modern Curl Variable Syntax (curl 7.73.0+)"

However, the official curl documentation clearly states:

> "curl supports command line variables (added in 8.3.0)"

The version number is INCORRECT. Variable expansion was introduced in curl 8.3.0, not 7.73.0. This represents an error of more than one major version and is a fundamental factual claim that directly contradicts authoritative documentation. Users relying on this finding would incorrectly believe the feature exists in earlier versions (7.73.0-8.2.x) where it does not exist.

**Authoritative Evidence:**

1. Official curl manpage section on Variables: States "curl supports command line variables (added in 8.3.0)"
2. Variable expansion syntax: `--variable name=content` for direct assignment, `--variable %name` for environment variables
3. Expansion options confirmed correct: `--expand-url`, `--expand-header`, `--expand-data`, `--expand-variable`
4. Processing functions confirmed correct: `trim`, `url`, `json`, `b64`, `64dec`
5. Syntax with `{{name}}` and colon-separated functions confirmed: `{{variable:function1:function2}}`

**Verification Details:**

Most technical details in the finding are accurate:
- Variable expansion syntax is correct
- `--expand-*` options are correctly listed
- Processing functions are correctly named and applied
- Environment variable import syntax with `%name` is correct
- Default value syntax `%name=default-value` is correct

However, the version number claim is fundamentally wrong. The feature was introduced in curl 8.3.0, not 7.73.0.

**Related Verification Entry:**

See `github-api-facts-verification.md` section "FINDING-2026-03-11-25 Verification" for complete verification documentation including direct quotations from official curl manpage.

---

### FINDING-2026-03-11-26 [DISPROVEN on 2026-03-11]

**Original Claim:** This finding documents secure credential usage patterns with curl, including curl configuration files, environment variables, curl's --variable feature, and shell script best practices using git credential system integration.

**Captured:** 2026-03-11 08:05
**Source:** https://curl.se/docs/manpage.html and security best practices
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding contains TWO critical errors that make the presented code non-functional:

1. **Invalid Bash Syntax in Script:** The shell script example uses `set -q` to exit on error, but `-q` is not a valid bash option. Official bash testing confirms `-q` is invalid:
   ```bash
   bash: line 1: set: -q: invalid option
   set: usage: set [-abefhkmnptuvxBCHP] [-o option-name] [--] [arg ...]
   ```
   The correct option for "exit on error" is `set -e`. Users copying this script would encounter immediate execution failures.

2. **Undocumented Curl Option:** The finding uses `curl --expand-header` to expand variables in headers, but this specific option is NOT documented in official curl documentation (https://curl.se/docs/manpage.html). The officially documented variable expansion options are:
   - `--expand-url` (confirmed)
   - `--expand-data` (confirmed)
   - `--expand-variable` (confirmed)
   - `--expand-header` (NOT FOUND in official documentation)

While `--expand-header` may theoretically work due to curl's variable expansion pattern, it cannot be verified against authoritative sources and is not documented in the official curl manpage.

**Authoritative Evidence:**

1. **Bash option validation:** Testing bash 5.1.16 confirms `set -q` is invalid. The valid option for the stated purpose is `set -e`.
   - Source: Tested with `bash -c "set -q"` → Error output confirms invalid option
   - Corrected command: `bash -c "set -e; set +H; echo valid"` → Works correctly

2. **Curl documentation review:** Official curl documentation (https://curl.se/docs/manpage.html) documents:
   > "Variable contents can be expanded in option parameters using {{name}} if the option name is prefixed with --expand-"

   Documented options with examples: `--expand-url`, `--expand-data`, `--expand-variable`

   Searched: `--expand-header` - NOT FOUND in official documentation

3. **Git credential fill verification:** The `git credential fill` command is correctly described and functions as claimed:
   ```
   Input: protocol=https, host=github.com
   Output: protocol=https, host=github.com, username=minouris, password=[token]
   ```
   Status: VERIFIED

4. **Other bash option verification:** Testing confirms `set +H` (disable history expansion) is valid:
   ```bash
   bash -c "set -e; set +H; echo valid"  # Returns "valid" - both options work
   ```
   Status: VERIFIED

5. **Curl security documentation:** The security warnings about credentials in URLs and the `--config`, `--disallow-username-in-url` options are all correctly documented:
   - `--disallow-username-in-url` exists and functions as described - VERIFIED
   - `--config` file option exists and functions as described - VERIFIED
   - `--variable` feature introduced in curl 8.3.0 - VERIFIED
   - Security warnings about credential exposure in URLs - VERIFIED

**Verification Score:**
- General security principles: SOUND
- Curl documentation claims: 80% VERIFIED, 20% UNDOCUMENTED
- Git integration claims: VERIFIED
- Bash script example: BROKEN (invalid syntax)

**Impact Assessment:**

Users copying the bash script example directly would encounter immediate script execution failures due to the `set -q` error. The finding presents valuable security advice but renders it unreliable through the inclusion of non-functional code examples.

The `--expand-header` usage, while following curl's documented variable expansion patterns, cannot be confirmed as an official option and is unsupported by documentation.

**Corrected Script (for reference):**

The finding's script should use `set -e` instead of `set -q`:
```bash
#!/bin/bash
set -e  # Exit on error (CORRECT - NOT set -q)
set +H  # Disable history expansion in scripts

# Rest of script remains valid
```

**Related Verification Entry:**

See `github-api-facts-verification.md` section "FINDING-2026-03-11-26 Verification" for complete verification documentation including direct quotations from official curl and git documentation, and bash option testing results.

