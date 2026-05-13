# GitHub API Credential Acquisition - Verified Findings

See also: [github-api-credential-acquisition-facts-disproven.md](github-api-credential-acquisition-facts-disproven.md)

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
   - Resource owner: Select user or organisation
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

**Token Format**: Classic tokens grant access to all repositories within organisations user has access to. Fine-grained tokens provide more restrictive, security-focused permissions.

**CLI Usage**: Token used in place of password for Git operations over HTTPS. Can be cached to avoid repeated manual entry.

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
   - **Authorisation callback URL**: App's OAuth callback endpoint
4. Optional: Enable **Device Flow** for user authorisation
5. Click **Register application** to complete

**Constraints:**
- Cannot have multiple callback URLs (unlike GitHub Apps which can have multiple)
- Max 100 OAuth apps per user/organisation [VERIFICATION NOTE: Not found in official documentation - requires manual verification]
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
