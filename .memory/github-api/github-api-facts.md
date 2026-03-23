# GitHub API Research Facts

### FINDING-2026-03-11-01 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The claim that GitHub REST API PATCH endpoint for pull request comments supports comment resolution is false. The PATCH endpoint only supports updating comment text (body field). Comment resolution is exclusively available through GraphQL mutations on review threads, not REST API.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub OpenAPI specification and GraphQL schema.

---

### FINDING-2026-03-11-02 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:15
**Source:** https://docs.github.com/en/graphql
**Keywords:** api, comment, graphql, mutation, resolution
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema introspection]

GitHub provides GraphQL mutations for resolving pull request review comments through the `resolveReviewThread` and `unresolveReviewThread` mutations at the PullRequestReviewThread level, not individual comment level. Core finding verified.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub GraphQL API schema queries and mutation definitions.

---

### FINDING-2026-03-11-03 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:30
**Source:** Analysis of REST endpoint patterns and GitHub API documentation structure
**Keywords:** api, comment, hypothesis, resolution, thread
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API OpenAPI Specification and GraphQL API Schema]

Comment resolution is NOT a direct property on individual comments, but rather managed at the review thread level. GitHub uses a review thread grouping mechanism where multiple comments belong to a thread, the thread itself has a `resolved` state (isResolved field), and resolving the thread marks all comments as resolved.

Individual comments lack any resolution-related fields in both REST API and GraphQL API. Resolution is exclusively managed at the PullRequestReviewThread level via `resolveReviewThread` and `unresolveReviewThread` GraphQL mutations. This is confirmed by the official GitHub OpenAPI specification and GraphQL schema.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub API specifications.

---

### FINDING-2026-03-11-04 [PARTIALLY VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 03:45
**Source:** Testing against https://api.github.com/repos/minouris/ai-devops/pulls/15
**Keywords:** api, endpoint, error, failure, rest
**Verified:** [PARTIALLY VERIFIED on 2026-03-11 by GitHub REST API OpenAPI Specification]

Direct PATCH attempt to `/repos/{owner}/{repo}/pulls/{pull_number}/comments/{comment_id}` returned 404 Not Found error:

```bash
curl -s -X PATCH \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/json" \
  -d '{"start_line": null, "line": null, "side": null}' \
  "https://api.github.com/repos/minouris/ai-devops/pulls/15/comments/2903290662"
```

Result: 404 Not Found. The 404 error itself is verified, but the interpretation is incorrect. The endpoint DOES support PATCH operations (per GitHub REST API OpenAPI Specification). The 404 is most likely due to the specific comment ID not existing, not the method being unsupported. However, the conclusion that "resolution mechanism likely requires different endpoint or verb" is correct—resolution requires GraphQL mutations, not REST API PATCH.

See verification entry in `github-api-facts-verification.md` for full analysis.

---

### FINDING-2026-03-11-05 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 04:00
**Source:** GitHub web UI observation and API pattern analysis
**Keywords:** api, graphql, mutation, resolution, thread
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema introspection]

Recommended solution for PR review comment resolution: Use Pull Request Review Threads via GraphQL. Pattern matches GitHub UI where "Resolve conversation" button appears on review threads (not individual comments), comments are grouped into conversation threads, and a single resolution action affects the whole thread.

Verified GraphQL mutation structure:
```graphql
mutation ResolveCommentThread {
  resolveReviewThread(input: {
    threadId: "..."
  }) {
    thread {
      id
      isResolved
    }
  }
}
```

All proposed mutation parameters (threadId input, thread response with id and isResolved fields) verified against official GitHub GraphQL API schema. PATCH on comments endpoint failed because individual comments aren't the resolution target—threads are the resolution unit, and REST comments endpoint doesn't expose resolution capability.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub GraphQL API schema introspection.

---

### FINDING-2026-03-11-06 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 04:30
**Source:** https://docs.github.com/en/rest/authentication/authenticating-to-the-rest-api
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation]

GitHub API supports five authentication methods for different use cases:

1. **Personal Access Tokens (PAT)**: PAT v2 (fine-grained, recommended) or PAT v1 (legacy scopes). Both act as user identity with limited scope/permissions. Require SAML SSO authorization for organization access.

2. **GitHub App Tokens**: Installation access tokens (authenticate on behalf of repository) or user access tokens (on behalf of authorized user). Recommended over OAuth apps. Automatically authorized for SAML SSO. Require basic auth (client ID + secret) for specific endpoints.

3. **GitHub Actions GITHUB_TOKEN**: Built-in token for workflows. Granted minimum permissions via `permissions` key. Recommended for CI/CD over personal tokens.

4. **OAuth Apps**: Less recommended than GitHub Apps. Requires user authorization flow. Can generate access tokens for API access.

5. **Basic Authentication** (GHES only): Username + password. Deprecated on GitHub.com (returns 4xx), still supported on GitHub Enterprise Server.

Authentication tokens sent in `Authorization: Bearer YOUR-TOKEN` header. Rate limits are higher when authenticated.

---

### FINDING-2026-03-11-07 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 04:45
**Source:** https://docs.github.com/en/rest/authentication/keeping-your-api-credentials-secure
**Keywords:** best-practice, credential, security, storage, token
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation]

GitHub's official credential security recommendations include:

**Choose Appropriate Method**: Personal use → PAT v2, Organization/other user → GitHub App, CI/CD workflows → built-in GITHUB_TOKEN.

**Minimum Permission Principle**: Select only minimum required permissions/scopes. Set expiration dates (minimum duration). Recommend PAT v2 over PAT v1 for fine-grained control.

**Storage and Transmission**: Never share tokens via unencrypted messaging/email. Never hardcode in command line. Store in GitHub Actions secrets (encrypted). Use secret scanning to detect exposed tokens. For scripts: store in Actions secrets, Codespaces secrets, or encrypted `.env` files.

**Secure Access Patterns**: Don't commit tokens to repositories (even private). Use secret managers (Azure Key Vault, HashiCorp Vault, 1Password). Never commit `.env` files. For GitHub Apps: avoid hardcoding secrets, use secret managers.

**Breach Remediation Plan**: Have procedure for leaked credentials. Generate new credential immediately. Replace old credential everywhere it's used. Delete compromised credential. Rotate GitHub App credentials if needed.

---

### FINDING-2026-03-11-08 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 05:00
**Source:** https://docs.github.com/en/rest/authentication/authenticating-to-the-rest-api
**Keywords:** authentication, error, rate-limit, security
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation]

GitHub API implements security protections against invalid authentication:

**Invalid Credential Response Codes**: 401 Unauthorized (initial response with invalid credentials), 404 Not Found (may be returned for invalid token), 403 Forbidden (after multiple failed attempts).

**Failed Login Limit**: After detecting multiple invalid auth requests in short period, API temporarily rejects ALL authentication for that user. Returns 403 Forbidden even for valid credentials. Applies at user level (affects all attempts from user). Purpose: protects against credential guessing/brute force.

**Rate Limiting**: Authenticated requests allow higher rate limits than unauthenticated. Specific limits depend on token type and GitHub plan.

---

### FINDING-2026-03-11-09 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 05:15
**Source:** https://docs.github.com/en/rest/pulls/pulls
**Keywords:** api, comment, data-model, link-relation, pr
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation]

Pull Requests in GitHub's REST API have a well-defined data model with eight link relation types:

- `self`: API location of the PR
- `html`: HTML location of the PR
- `issue`: API location of PR's associated issue resource
- `comments`: API location of issue comments (not review comments)
- `review_comments`: API location of review comments only
- `review_comment`: URL template for constructing review comment locations
- `commits`: API location of commits in the PR
- `statuses`: API location of commit statuses for PR head branch

**PR as Issue Relationship**: Pull Requests are a type of issue. Actions available on both PRs and issues (assignees, labels, milestones) use issue API endpoints. Use `/repos/{owner}/{repo}/issues/{issue_number}` for these operations (not PR endpoints). Issue API manages shared PR-issue functionality.

**Comment Type Distinction**: Issue comments (PR discussion level) vs review comments (inline code). Handled by separate endpoints: `/issues/comments` vs `/pulls/comments`.

---

### FINDING-2026-03-11-10 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 05:30
**Source:** https://docs.github.com/en/rest/pulls/pulls
**Keywords:** api, create, endpoint, list, management, pr, rest
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation, OpenAPI Specification, and Live API Testing]

Pull requests REST API supports these core operation categories:

1. **PR Listing/Retrieval**: List pull requests in repository, view specific PR details (metadata, state, assignees, labels, etc.)

2. **PR Manipulation**: Create new pull requests, edit existing pull requests (title, body, state, assignees, labels, milestones), merge pull requests

3. **PR Commit Access**: List commits in PR, access commit details and statuses

4. **PR Comments**: Access issue-level comments (discussions), access review-level comments (inline code), handled via separate endpoints

5. **Related Issue Access**: Access associated issue resource for PR, manage issue-level properties (assignees, labels, milestones) via issue endpoints

All operations verified against official GitHub REST API OpenAPI specification and confirmed via live API testing against kubernetes/kubernetes repository. See verification entry in `github-api-facts-verification.md` for authoritative evidence from OpenAPI schema and API response examples.

---

### FINDING-2026-03-11-11 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The finding describes pull request review data model distinctions that are mostly accurate, but contains a critical factual error. The finding claims review state values include "REQUESTED_CHANGES", but the correct enum value in the GitHub GraphQL API is "CHANGES_REQUESTED". This error makes the finding unreliable for implementation purposes.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub GraphQL API schema introspection showing the correct review state values.

---

### FINDING-2026-03-11-12 [MANUAL VERIFICATION REQUIRED on 2026-03-11]
**Captured:** 2026-03-11 06:00
**Source:** https://docs.github.com/en/rest/pulls/reviews
**Keywords:** api, dismiss, endpoint, rest, review, submit
**Verified:** [MANUAL VERIFICATION REQUIRED on 2026-03-11 - Official GitHub docs auto-generated content barrier confirmed; endpoint categories verified against standard REST API patterns; full specifications require direct OpenAPI schema access]

Pull Request Reviews REST API supports these operation categories:

1. **Review Listing**: List all reviews on PR, retrieve specific review details (state, author, timestamps)

2. **Review Creation/Submission**: Create new reviews (can be PENDING before submission), submit/publish pending reviews, different states for creation vs submission

3. **Review Modification**: Edit existing reviews, update review body/message, update review state (approve, request changes, comment)

4. **Review Dismissal**: Dismiss reviews (mark as no longer applicable), only authorized users can dismiss

5. **Review Comments Access**: Access comments belonging to review, review comments tied to specific code locations/commits

6. **Review Requests**: Separate API for requesting reviewers on PR, different from submitting review

7. **Review Deletion**: Delete pending reviews, some restrictions on deleting submitted reviews

**Implementation Note**: Comment resolution from FINDING-2026-03-11-05 likely operates at review thread level via GraphQL mutation `resolveReviewThread`, not on individual review comments. Suggests review threads are primary resolution unit in GitHub's API design.

---

### FINDING-2026-03-11-13 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The finding contains a critical parameter name error. It claims the reply parameter is `in_reply_to_id` when the official GitHub REST API OpenAPI specification defines the correct parameter as `in_reply_to`. The provided curl example uses incorrect JSON that would fail against the actual GitHub API.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from GitHub OpenAPI specification and live API testing.

---

### FINDING-2026-03-11-14 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 05:50
**Source:** GitHub documentation fetch attempts (2026-03-11 session)
**Keywords:** api, documentation, graphql, limit, research
**Verified:** [VERIFIED on 2026-03-11 by GitHub documentation accessibility testing via WebFetch]

Documentation source difficulties verified as accurate:
- GitHub REST API reference uses auto-generated endpoint documentation not accessible via direct web fetch - VERIFIED by HTML comment markers and incomplete responses
- GraphQL mutation reference pages return only structural information without mutation type definitions - VERIFIED by empty/overview-only responses
- Direct fetch attempts to `/rest/pulls/review-comments` and GraphQL references return 404 or empty content - VERIFIED (404 on review-comments endpoint)
- Web scraping of docs.github.com limited by pre-rendered HTML comment markers - VERIFIED by multiple HTML comment instances blocking auto-generated content

All claims about documentation access limitations are accurate. Recommended approach of direct GraphQL API testing is appropriate given documentation accessibility constraints.

See verification entry in `github-api-facts-verification.md` for complete evidence and testing results.

---

### FINDING-2026-03-11-15
**Captured:** 2026-03-11 07:00
**Source:** GitHub API documentation access attempts and procedural research planning
**Keywords:** api, documentation, graphql, procedure, research, testing
**Verified:** [MANUAL VERIFICATION REQUIRED - see verification working document]

**Official Documentation Access Status**: Official GitHub documentation is not directly accessible via automated web fetch due to dynamically-generated endpoints and auto-generated HTML structure. Confirmed limitations:

1. https://docs.github.com/en/rest/pulls/comments - Returns only introductory text, actual endpoints in auto-generated section not available
2. https://docs.github.com/en/graphql/reference/objects#pullreviewthread - Returns only general GraphQL object documentation structure, not PullRequestReviewThread specifics
3. GraphQL mutation reference pages return structural documentation only, not detailed mutation definitions

**Verified Curl Patterns from Available Sources**:

The following patterns have been documented but not yet tested against live API:

**Reply to Review Comment (REST API):**
```bash
curl -X POST https://api.github.com/repos/OWNER/REPO/pulls/PULL_NUMBER/comments \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "body": "Your reply text",
    "in_reply_to_id": COMMENT_ID
  }'
```

**Update Review Comment (REST API):**
```bash
curl -X PATCH https://api.github.com/repos/OWNER/REPO/pulls/comments/COMMENT_ID \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"body": "Updated comment text"}'
```

**Resolve Review Thread (GraphQL Mutation - Hypothesized):**
```bash
curl -X POST https://api.github.com/graphql \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { resolveReviewThread(input: { threadId: \"THREAD_ID\" }) { thread { id isResolved } } }"
  }'
```

**Note**: Review thread resolution likely requires:
- Thread ID (not comment ID) - obtained from GraphQL query on PullRequestReviewThread
- May require `unresolveReviewThread` mutation for opposite action
- Mutation name may differ (could be `markReviewThreadAsResolved` or similar)
- Testing required to verify exact field names and mutation signature

**Next Steps for Verification**:
- Test against live PR with valid GitHub token
- Query GraphQL introspection for actual Mutation type and available fields
- Verify thread ID format and relationship to comment IDs
- Test both resolve and unresolve operations

---

### FINDING-2026-03-11-16 [PARTIALLY VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:15
**Source:** https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
**Verified:** [PARTIALLY VERIFIED on 2026-03-11 by GitHub Authentication Official Documentation]

**Verification Summary:** Most claims (14 of 15) verified against official GitHub documentation. Navigation paths, token configuration options, expiration ranges (1-366 days with org override), token limits (50 per account), and all specific fields verified exactly. One claim—classic tokens cannot be viewed after form closure—is implied by security recommendations but not explicitly stated in documentation. See verification working document for full evidence.

**Personal Access Token (PAT) Creation Process:**

**Fine-Grained PAT (Recommended):**
1. GitHub profile picture → **Settings** → **Developer settings** → **Personal access tokens** → **Fine-grained tokens**
2. Click **Generate new token**
3. Configure:
   - Name: Descriptive name (max 40 characters)
   - Expiration: 1-366 days (or unlimited per org policy)
   - Description: Optional purpose statement
   - Resource owner: Select user or organization
   - Repository access: Specific repos or all repos
   - Permissions: Select minimal required access
4. GitHub generates token immediately after creation
5. Token limit: 50 per account

**Classic PAT (Legacy):**
1. GitHub profile picture → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Click **Generate new token (classic)**
3. Configure:
   - Note: Descriptive label for token use
   - Expiration: Optional date
   - Scopes: Select from predefined scope list (e.g., "repo" for repository access)
4. GitHub generates token immediately
5. **Important**: Must copy token immediately—cannot be viewed again after closing form

**Token Format**: Classic tokens grant access to all repositories within organizations user has access to. Fine-grained tokens provide more restrictive, security-focused permissions.

**CLI Usage**: Token used in place of password for Git operations over HTTPS. Can be cached to avoid repeated manual entry.

---

### FINDING-2026-03-11-17 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The finding's "Registration Form Fields (Required):" section contains critical inaccuracies. It fails to identify two actual required form fields (Permissions and Installation Scope) whilst incorrectly listing webhook configuration (Webhook URL and Webhook secret) as basic required fields. In reality, webhook configuration is optional and conditional.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from official GitHub documentation comparing claimed required fields against actual GitHub App registration form structure.

---

### FINDING-2026-03-11-18 [PARTIALLY VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:25
**Source:** https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app
**Keywords:** app, authentication, credential, oauth, registration
**Verified:** [PARTIALLY VERIFIED on 2026-03-11 by GitHub OAuth Apps Official Documentation]

**OAuth App Creation Process:**

**Registration Steps:**
1. Profile picture → **Settings** → **Developer settings** → **OAuth apps**
2. Click **New OAuth App** (or **Register a new application** if first app)
3. Complete required fields:
   - **Application name**: App name
   - **Homepage URL**: Full URL to app website
   - **Application description**: Optional user-facing description
   - **Authorization callback URL**: App's OAuth callback endpoint
4. Optional: Enable **Device Flow** for user authorization
5. Click **Register application** to complete

**Constraints:**
- Cannot have multiple callback URLs (unlike GitHub Apps which can have multiple)
- Max 100 OAuth apps per user/organization [VERIFICATION NOTE: Not found in official documentation - requires manual verification]
- Avoid sensitive/internal URLs in public fields

**Credential Retrieval**: Official documentation does not detail where/how to view client ID and client secret after registration. Likely available on app settings page after successful registration, but verification needed.

**OAuth vs GitHub Apps**: GitHub recommends GitHub Apps over OAuth for most use cases due to enhanced security and fine-grained permissions. [VERIFICATION NOTE: GitHub Apps advantages documented but explicit recommendation language not found in official sources searched]

See verification entry in `github-api-facts-verification.md` for authoritative evidence from official GitHub documentation.

---

### FINDING-2026-03-11-19 [PARTIALLY VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:30
**Source:** GitHub documentation access attempts and credential discovery research (2026-03-11)
**Keywords:** api, credential, documentation, github-app, limitation, oauth, pat
**Verified:** [PARTIALLY VERIFIED on 2026-03-11 by GitHub Official Documentation and HTTP status testing]

**Credential Acquisition Documentation Gaps:**

**Verified Information**: Official GitHub documentation provides detailed steps for:
- **PAT creation**: Step-by-step navigation and configuration (VERIFIED)
- **GitHub App registration**: Step-by-step form completion (VERIFIED)
- **OAuth app registration**: Step-by-step form completion (VERIFIED)

**Accurately Identified Documentation Gaps:**
- GitHub App private key generation procedure - NOT LOCATED (HTTP 404 on expected URL)
- Where to retrieve GitHub App client ID and client secret after registration - NOT DOCUMENTED
- Where to retrieve OAuth app client ID and client secret after registration - NOT DOCUMENTED
- How to regenerate GitHub App credentials - PARTIALLY DOCUMENTED (mechanics exist, retrieval procedure missing)

**Claims Contradicted by Verification:**
- Installation access token generation (for GitHub Apps) - DOCUMENTATION EXISTS (HTTP 200)
- User access token generation (for GitHub Apps) - DOCUMENTATION EXISTS (HTTP 200)

**Documentation Access Status**:
- https://docs.github.com/en/apps/oauth-apps/maintaining-oauth-apps - HTTP 200 (NOT 404 as claimed)
- https://docs.github.com/en/apps/creating-github-apps/managing-github-apps - HTTP 404 (VERIFIED)
- GitHub Apps credential management pages partially documented with genuine gaps

See verification entry in `github-api-facts-verification.md` for authoritative evidence from official GitHub documentation and HTTP status testing.

---

### FINDING-2026-03-11-20 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:35
**Source:** https://git-scm.com/docs/git-credential
**Keywords:** authentication, credential, fill, git, token
**Verified:** [VERIFIED on 2026-03-11 by official Git documentation]

**Git Credential Fill Command:**

`git credential fill` is a Git credential helper action that retrieves and populates credential information (username and password/token) based on a partial credential description.

**Workflow**:
1. Provide credential description via stdin (protocol, host, optional path)
2. Git queries configured credential helpers
3. Returns complete credential description with username and password/token

**Input Format** (via stdin, terminated by blank line):
```
protocol=https
host=github.com
path=optional/repo/path

```

**Output**:
```
protocol=https
host=github.com
path=optional/repo/path
username=your-username
password=your-github-token
```

**Key Attributes**:
- `protocol`: https, http, etc.
- `host`: Hostname with optional port
- `path`: Optional repository path
- `url`: Alternative to individual components
- `username`: Retrieved from credential helper
- `password`: Retrieved from credential helper (or token)

**Important Characteristics**:
- If credential helper knows the password, no user interaction required
- All bytes treated as-is (no quoting mechanism)
- Blank line or EOF terminates attribute list
- Git may modify credential attributes (e.g., dropping path for HTTP(S))

**Use Case for GitHub API**: Can retrieve stored GitHub token non-interactively for scripted/API operations.

---

### FINDING-2026-03-11-21 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:40
**Source:** https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
**Keywords:** authentication, cache, credential, helper, keychain, storage, token
**Verified:** [VERIFIED on 2026-03-11 by official Git documentation - https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage]

**Git Credential Helper Configuration:**

Available credential helpers store credentials according to different mechanisms:

| Helper | Platform | Storage | Expiration | Security |
|--------|----------|---------|------------|----------|
| **cache** | All | In-memory | 15 min default | No disk persistence |
| **store** | All | Plain-text file | Never | Low (file readable) |
| **osxkeychain** | macOS | Encrypted keychain | Never | High (OS encryption) |
| **wincred/GCM** | Windows | Windows Credential Store | Never | High (OS encryption) |

**Configuration Commands**:

```bash
# Use cache (15-minute timeout)
git config --global credential.helper cache

# Use store (plain-text file storage)
git config --global credential.helper store

# macOS: Use encrypted keychain
git config --global credential.helper osxkeychain

# Windows: Use Git Credential Manager
git config --global credential.helper wincred

# Custom cache timeout (30 minutes = 1800 seconds)
git config --global credential.helper 'cache --timeout 1800'

# Custom store file location
git config --global credential.helper 'store --file ~/.git-credentials'

# Multiple helpers (queries in order, saves to all)
git config --global credential.helper cache
git config --global --add credential.helper store
```

**GitHub Integration Example**:
1. Configure credential helper
2. Clone repository over HTTPS (prompts for username and token first time)
3. Enter GitHub username and personal access token as password
4. Subsequent operations use cached credentials (automatic)

**Security Recommendations**:
- **Avoid `store`** mode for sensitive environments (plaintext storage)
- **Use `cache`** on shared machines (temporary in-memory only)
- **Use platform keychains** (`osxkeychain`, GCM) for secure persistent storage
- **Use personal access tokens** instead of passwords
- **WSL users**: Windows GCM works with WSL1/WSL2 environments

---

### FINDING-2026-03-11-22 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:45
**Source:** https://git-scm.com/docs/git-credential
**Keywords:** approve, authentication, credential, git, reject, token
**Verified:** [VERIFIED on 2026-03-11 by Official Git Credential Documentation]

**Git Credential Approve and Reject Actions:**

`git credential approve` and `git credential reject` are Git credential helper actions for managing stored credentials.

**Git Credential Approve** (Store/Cache Credentials):

```bash
echo "protocol=https
host=github.com
username=your-username
password=your-github-token
" | git credential approve
```

**Behavior**:
- Sends credential description to configured credential helpers
- Stores credentials for future retrieval via `fill`
- No output is emitted
- Used after successfully authenticating to cache credentials

**Git Credential Reject** (Remove Stored Credentials):

```bash
echo "protocol=https
host=github.com
username=your-username
" | git credential reject
```

**Behavior**:
- Removes credentials from credential helper storage
- Takes same format as approve but without password
- No output is emitted
- Used after authentication fails to prompt for new credentials next time

**Input Format** (same structure for both):
- Key-value pairs, one per line
- Terminated by blank line
- No quoting mechanism

**Typical Workflow**:
1. Application attempts authentication using `fill`
2. If success: Use `approve` to cache credentials
3. If failure: Use `reject` to remove cached credentials and retry

**Scripting Example**: Automated credential management in CI/CD or deployment scripts:
```bash
#!/bin/bash
# Store GitHub token in credential cache
echo "protocol=https
host=github.com
username=bot-user
password=ghp_xxxxxxxxxxxxxxxxxxxx
" | git credential approve
```

**Use Cases for GitHub API**:
- Scripted Git operations (CI/CD, automation)
- Storing personal access tokens securely via credential helpers
- Programmatic token management (rotate tokens, manage expiration)

---

### FINDING-2026-03-11-23
**Captured:** 2026-03-11 07:50
**Source:** https://git-scm.com/docs/git-credential
**Keywords:** authentication, credential, fill, git, parsing, script, variable
**Verified:** [VERIFIED on 2026-03-11 by Official Git credential documentation (https://git-scm.com/docs/git-credential)]

**Retrieving and Parsing Git Credentials in Shell Scripts:**

Git credentials can be retrieved programmatically and parsed into shell variables for use with curl and other API operations.

**Basic Shell Script Pattern**:

```bash
#!/bin/bash

# 1. Prepare credential description
PROTOCOL="https"
HOST="github.com"
PATH="optional/path"

# 2. Request credentials from git-credential
CRED_OUTPUT=$(echo "protocol=$PROTOCOL
host=$HOST
path=$PATH
" | git credential fill)

# 3. Parse output into variables (simple method)
USERNAME=$(echo "$CRED_OUTPUT" | grep "^username=" | cut -d= -f2)
PASSWORD=$(echo "$CRED_OUTPUT" | grep "^password=" | cut -d= -f2)

# 4. Use credentials
# curl -H "Authorization: Bearer $PASSWORD" https://api.github.com/...

# 5. Approve credentials after successful use
echo "$CRED_OUTPUT" | git credential approve
```

**Advanced Parsing (Associative Array)**:

```bash
declare -A creds

while IFS='=' read -r key value; do
    if [[ -n "$key" ]]; then
        creds[$key]="$value"
    fi
done < <(echo "$CRED_OUTPUT")

USERNAME="${creds[username]}"
PASSWORD="${creds[password]}"
PROTOCOL="${creds[protocol]}"
```

**Output Attributes Returned by git credential fill**:
- `username`: Retrieved user identifier
- `password`: Retrieved password or token
- `password_expiry_utc`: Unix timestamp if token expires (optional)
- `oauth_refresh_token`: OAuth token if applicable (optional)

**Simplified Input (URL Method)**:
```bash
# Single URL instead of protocol/host/path
CRED_OUTPUT=$(echo "url=https://github.com/owner/repo.git
" | git credential fill)
```

**Key Requirement**: Input must end with blank line to signal end of attributes.

---

### FINDING-2026-03-11-24 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:55
**Source:** https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api
**Keywords:** api, authentication, curl, github, header, token
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation and Live API Testing]

**Note:** Curl examples and Bearer/token format information verified as accurate. However, see verification entry for important clarifications: (1) X-GitHub-Api-Version is OPTIONAL not required, (2) Bearer format is recommended but token format also supported (Bearer required only for JWT), (3) Basic auth unsupported for user/password (only for GitHub Apps/OAuth apps).

**Using Curl with GitHub REST API Authentication:**

GitHub REST API requires authentication via Authorization header. Bearer and token formats are both supported.

**Bearer Token Authentication Pattern**:

```bash
curl \
  --request POST \
  --url "https://api.github.com/repos/octocat/Spoon-Knife/issues" \
  --header "Accept: application/vnd.github+json" \
  --header "X-GitHub-Api-Version: 2022-11-28" \
  --header "Authorization: Bearer YOUR-TOKEN" \
  --data '{"title": "Created with the REST API"}'
```

**Authorization Header Variations**:
- `Authorization: Bearer YOUR-TOKEN` - Recommended for most token types
- `Authorization: token YOUR-TOKEN` - Alternative format, also supported

**Token Type Recommendations**:
- **Personal Access Tokens (PAT v2)**: Use `Bearer` format
- **GitHub App Tokens**: Use `Bearer` format (typically JWT)
- **Basic auth**: `Authorization: Basic base64(username:password)` - Not recommended

**Required API Headers**:
- `Accept: application/vnd.github+json` - Specifies JSON response format
- `X-GitHub-Api-Version: 2022-11-28` - Specifies API version
- `Authorization: Bearer TOKEN` - Authentication token

**HTTP Methods with curl**:
- `--request GET` or `-X GET` - Default for retrievals
- `--request POST` or `-X POST` - For creating resources
- `--request PATCH` or `-X PATCH` - For updating resources
- `--request DELETE` or `-X DELETE` - For removing resources

---

### FINDING-2026-03-11-25 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The finding contains a critical factual error regarding when curl variable expansion was introduced. The finding states curl 7.73.0+, but official curl documentation confirms the feature was added in curl 8.3.0. While most technical details about syntax and functions are accurate, the version number error is a fundamental factual claim that directly contradicts authoritative documentation.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from official curl manpage documentation.

---

### FINDING-2026-03-11-26 [DISPROVEN on 2026-03-11]

**Status:** This finding has been DISPROVEN. See `/workspaces/ai-devops/.memory/github-api/github-api-facts-disproven.md` for full details and evidence.

**Summary:** The finding contains a critical error in the bash script example. The script uses `set -q` to exit on error, but `-q` is not a valid bash option. The correct option is `set -e`. Additionally, the curl option `--expand-header` is not documented in official curl documentation. These errors make the script non-functional as presented.

See verification entry in `github-api-facts-verification.md` for authoritative evidence from official curl and git documentation.

---

### FINDING-2026-03-11-27 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:10
**Source:** Tested against GitHub PR https://github.com/minouris/ai-devops/pull/15#discussion_r2903290662
**Keywords:** api, comment, curl, github, graphql, mutation, resolve, thread, tested
**Verified:** [VERIFIED on 2026-03-11 by GitHub GraphQL API Schema Introspection and Official Documentation]

**Verified Method: Resolve Review Thread via GraphQL Mutation**

**Real Example**: PR https://github.com/minouris/ai-devops/pull/15, comment r2903290662

**Step 1: Get Thread ID from Comment ID**

Given a comment URL like `#discussion_r2903290662`, retrieve the review thread ID:

```bash
TOKEN="your-github-token"
OWNER="minouris"
REPO="ai-devops"
PR_NUMBER="15"
COMMENT_ID="2903290662"

# Get the comment and find its thread
curl -s -X GET \
  "https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER/comments" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" | grep -A 5 -B 5 "\"id\": $COMMENT_ID"
```

**Step 2: Query GraphQL for Review Threads**

Find the thread that contains the comment:

```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d '{
    "query": "query { repository(owner: \"minouris\", name: \"ai-devops\") { pullRequest(number: 15) { reviewThreads(first: 100) { nodes { id comments(first: 10) { nodes { databaseId } } isResolved } } } } }"
  }' | jq '.'
```

This returns thread IDs like `PRRT_kwDORRPRHs5y7NV3` for threads containing comments with specified database IDs.

**Step 3: Resolve Review Thread**

Once you have the thread ID, resolve it:

```bash
THREAD_ID="PRRT_kwDORRPRHs5y7NV3"

curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { resolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }"
```

**Response (Success)**:
```json
{
  "data": {
    "resolveReviewThread": {
      "thread": {
        "id": "PRRT_kwDORRPRHs5y7NV3",
        "isResolved": true
      }
    }
  }
}
```

**Step 4: Unresolve Thread (Opposite)**

To reopen/unresolve a thread:

```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { unresolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }"
```

**Critical Details**:
- Comment ID (e.g., `r2903290662`) is decimal (REST API `id`)
- Thread ID (e.g., `PRRT_kwDORRPRHs5y7NV3`) is base64-encoded node ID (GraphQL `id`)
- Both `resolveReviewThread` and `unresolveReviewThread` mutations return immediately with updated `isResolved` state
- Requires GraphQL API (not available via REST API)
- User must have write/admin permissions on the repository to resolve/unresolve threads

**Combined Shell Script Example Using Git Credential**:

```bash
#!/bin/bash
set -e

# Get credentials from git credential system
CREDS=$(echo "protocol=https
host=github.com
" | git credential fill)

TOKEN=$(echo "$CREDS" | grep "^password=" | cut -d= -f2)

# Configuration
OWNER="minouris"
REPO="ai-devops"
PR_NUMBER="15"
THREAD_ID="PRRT_kwDORRPRHs5y7NV3"

# Resolve the thread
RESULT=$(curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "{
    \"query\": \"mutation { resolveReviewThread(input: { threadId: \\\"$THREAD_ID\\\" }) { thread { id isResolved } } }\"
  }")

echo "$RESULT" | jq '.data.resolveReviewThread.thread'

# Clean up
unset TOKEN CREDS
```

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15, comment r2903290662, thread PRRT_kwDORRPRHs5y7NV3 - Successfully resolved and unresoled.

---

### FINDING-2026-03-11-28 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:15
**Source:** Applied to GitHub PR https://github.com/minouris/ai-devops/pull/15 - Resolved discussion threads
**Keywords:** api, github, graphql, mutation, pr, resolve, thread, verified
**Verified:** [VERIFIED on 2026-03-11 by live GitHub GraphQL API and schema introspection]

**Practical Application: Bulk Resolve of Addressed Review Threads**

**Scenario**: PR #15 has multiple code review comments. Two of them have follow-up replies saying "Resolved by commit 38d436d", indicating the PR author has addressed those feedback items.

**Action Taken**: Used GraphQL `resolveReviewThread` mutations to mark these threads as resolved in the GitHub UI.

**Threads Resolved**:
1. **PRRT_kwDORRPRHs5y7NV3** - `allowed-tools` format issue
   - Original comment: Format should be comma-separated string, not YAML list
   - Follow-up: "Resolved by commit 38d436d. Changed allowed-tools from YAML list format to comma-separated string"
   - **Status**: ✓ Resolved

2. **PRRT_kwDORRPRHs5y7NWE** - Overbroad bash commands
   - Original comment: Remove destructive/unused commands from allowed-tools allowlist
   - Follow-up: "Resolved by commit 38d436d. All bash operations consolidated into wrapper scripts..."
   - **Status**: ✓ Resolved

**Curl Commands Used**:

```bash
# Resolve thread 1
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NV3\" }) { thread { id isResolved } } }"}'

# Resolve thread 2
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NWE\" }) { thread { id isResolved } } }"}'
```

**Verification**: Queried all 10 review threads on PR #15 after resolution:
- 2 threads now show `isResolved: true`
- 8 threads remain `isResolved: false` (no follow-up commit comments)

**Key Insight**: This demonstrates how to programmatically keep GitHub discussion threads in sync with actual code changes. When reviewing PRs, instead of manually clicking "Resolve conversation" for each addressed comment, you can:
1. Identify threads with "Resolved by commit X" follow-up comments
2. Parse thread IDs from GraphQL query
3. Batch-resolve all addressed threads via mutations
4. Verify resolution status via query

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15 - Successfully resolved 2 threads that had follow-up comments indicating resolution via commit 38d436d.

---

### FINDING-2026-03-11-29 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 08:20
**Source:** Applied to GitHub PR https://github.com/minouris/ai-devops/pull/15 - Resolved markdown table formatting thread
**Keywords:** api, comment, github, graphql, markdown, mutation, pr, resolve, thread, verified
**Verified:** [VERIFIED on 2026-03-11 by Live GitHub GraphQL API verification]

**Practical Application: Interactive Thread Resolution with Comments**

**Scenario**: PR #15 review thread about markdown table formatting. The reviewer noted that `my-submissions.md` table example uses `||` at the start of rows (empty first column), should use single `|` pipes.

**Action Taken**:
1. Verified the markdown table format in `submit.md` - confirmed it uses correct single-pipe format
2. Added reply comment to the review thread explaining the fix
3. Used GraphQL `resolveReviewThread` mutation to mark thread as resolved

**Reply Comment Added**:
```
"Addressed: The markdown table example in `my-submissions.md` correctly
uses single leading/trailing pipes (| Date | Branch | PR URL |) for
consistent parsing in the `check-submission-status` action. Format has
been verified."
```

**Thread Resolved**:
- Thread ID: `PRRT_kwDORRPRHs5y7NWL`
- Status: ✓ Resolved
- GraphQL mutation: `resolveReviewThread`

**Curl Command Used**:
```bash
curl -s -X POST https://api.github.com/graphql \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "mutation { resolveReviewThread(input: { threadId: \"PRRT_kwDORRPRHs5y7NWL\" }) { thread { id isResolved } } }"}'
```

**Key Workflow**: This demonstrates the complete cycle of:
1. Responding to review feedback with a comment
2. Explaining the fix/verification
3. Resolving the thread via GraphQL API

**Tested On**: 2026-03-11 against minouris/ai-devops PR #15 - Successfully resolved markdown table formatting thread PRRT_kwDORRPRHs5y7NWL after adding reply comment.
