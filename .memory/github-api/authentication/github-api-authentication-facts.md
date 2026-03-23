# GitHub API Authentication - Facts

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
