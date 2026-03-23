# GitHub API Git Credential Management - Verified Findings

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

**Behaviour**:
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

**Behaviour**:
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
