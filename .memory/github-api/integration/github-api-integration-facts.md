# GitHub API Integration - Verified Findings

See also: [github-api-integration-facts-disproven.md](github-api-integration-facts-disproven.md)

---

### FINDING-2026-03-11-24 [VERIFIED on 2026-03-11]
**Captured:** 2026-03-11 07:55
**Source:** https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api
**Keywords:** api, authentication, curl, github, header, token
**Verified:** [VERIFIED on 2026-03-11 by GitHub REST API Official Documentation and Live API Testing]

**Note:** Curl examples and Bearer/token format information verified as accurate. However, see verification entry for important clarifications: (1) X-GitHub-Api-Version is OPTIONAL not required, (2) Bearer format is recommended but token format also supported (Bearer required only for JWT), (3) Basic auth unsupported for user/password (only for GitHub Apps/OAuth apps).

**Using Curl with GitHub REST API Authentication:**

GitHub REST API requires authentication via Authorisation header. Bearer and token formats are both supported.

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

**Authorisation Header Variations**:
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
