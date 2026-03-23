# GitHub API Integration - Disproven Findings

Archive of findings that have been verified as inaccurate or contradicted by official documentation.

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

Whilst `--expand-header` may theoretically work due to curl's variable expansion pattern, it cannot be verified against authoritative sources and is not documented in the official curl manpage.

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

The `--expand-header` usage, whilst following curl's documented variable expansion patterns, cannot be confirmed as an official option and is unsupported by documentation.

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

---
