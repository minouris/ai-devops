# GitHub API Credential Acquisition - Disproven Findings

Archive of findings that have been verified as inaccurate or contradicted by official documentation.

---

### FINDING-2026-03-11-17 [DISPROVEN on 2026-03-11]

**Original Claim:** Registration Form Fields (Required) section lists GitHub App name (max 34 characters), Homepage URL, Webhook URL, and Webhook secret as the primary required fields during GitHub App registration.

**Captured:** 2026-03-11 07:20
**Source:** https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app
**Original Verified Status:** [NOT YET VERIFIED]
**Verification Result:** DISPROVEN on 2026-03-11

**Why Disproven:**

The finding's "Registration Form Fields (Required):" section contains significant inaccuracies. It fails to identify two actual required form fields (Permissions and Installation Scope) whilst incorrectly listing webhook configuration (Webhook URL and Webhook secret) as basic required fields. In reality, webhook configuration is optional and conditional.

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

> "Optional Fields: 1. Description – Users see this at installation. 2. Callback URL (up to 10 URLs) – Redirect after user authorisation. 3. Expire user authorisation tokens – Checkbox (deselect to prevent expiration). 4. Request user authorisation (OAuth) during installation – Checkbox. 5. Enable Device Flow – Checkbox. 6. Setup URL – Redirect after installation; ignored if OAuth selected. 7. Redirect on update – Checkbox to redirect on repository changes. 8. Active – Checkbox controlling webhook receipt. 9. **Webhook URL (if Active selected)** – 'URL that GitHub should send webhook events to'. 10. **Webhook secret (if Active selected)** – 'Secret token to secure your webhooks'. 11. SSL verification (if webhook URL entered) – Enable/disable toggle. 12. Subscribe to events (if Active selected) – Select specific webhook events."

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
