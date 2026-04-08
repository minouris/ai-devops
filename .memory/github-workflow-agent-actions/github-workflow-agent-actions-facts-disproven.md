# GitHub Workflow Agent Actions - Disproven Findings

---

## FINDING-2026-04-07-1 (DISPROVEN)

**Originally Captured:** 2026-04-07

**Disproven:** 2026-04-08

**Original Source:** [anthropics/claude-code-action repo](https://github.com/anthropics/claude-code-action)

**Contradicting Evidence:** User clarification: research should cite GitHub's official documentation on workflows and actions, not external projects

~~The `anthropics/claude-code-action@v1` GitHub Action can execute Claude prompts as automated workflow steps. Basic workflow structure requires: 1. A `.github/workflows/` YAML file with trigger events, 2. Job permissions, 3. Checkout step, 4. The action step with `prompt` input, 5. Optional `claude_args` input. The action supports multiple authentication methods.~~

**Reason for Disproof:** Source is external project documentation, not GitHub's official documentation on workflows and actions. Must use authoritative GitHub sources.

---

## FINDING-2026-04-07-2 (DISPROVEN)

**Originally Captured:** 2026-04-07

**Disproven:** 2026-04-08

**Original Source:** [Claude Code Skills documentation](https://code.claude.com/docs/en/skills); [GitHub Actions workflow examples](https://github.com/anthropics/claude-code-action/blob/main/docs/solutions.md)

**Contradicting Evidence:** User clarification: must cite GitHub's official documentation, not external projects

~~Claude Code skills are automatically available in GitHub Actions workflows. Skills are invoked via the `prompt` input by directly specifying the skill name or describing the task in natural language.~~

**Reason for Disproof:** Source is external project documentation. Must use GitHub's official documentation.

---

## FINDING-2026-04-07-3 (DISPROVEN)

**Originally Captured:** 2026-04-07

**Disproven:** 2026-04-08

**Original Source:** [anthropics/claude-code-action action.yml](https://github.com/anthropics/claude-code-action/blob/main/action.yml); [Claude Code GitHub Actions documentation](https://code.claude.com/docs/en/github-actions)

**Contradicting Evidence:** User clarification: must use GitHub's official documentation

~~The action accepts inputs: prompt, api_key/anthropic_api_key, claude_args, model, max_tokens, settings. Permissions required: contents, issues, pull-requests, id-token.~~

**Reason for Disproof:** Source is external project. Must cite GitHub's authoritative sources on workflows and actions.

---

## FINDING-2026-04-07-4 (DISPROVEN)

**Originally Captured:** 2026-04-07

**Disproven:** 2026-04-08

**Original Source:** [anthropics/claude-code-action docs/usage.md](https://github.com/anthropics/claude-code-action/blob/main/docs/usage.md); [GitHub Actions — Using OpenID Connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)

**Contradicting Evidence:** User clarification: primary sources should be GitHub's official documentation

~~The action supports authentication via Anthropic API key, cloud providers (AWS Bedrock, Google Vertex AI, Azure), and GitHub Copilot via OIDC.~~

**Reason for Disproof:** Primary source is external project. GitHub's official documentation should be the authoritative reference.

---

## FINDING-2026-04-07-5 (DISPROVEN)

**Originally Captured:** 2026-04-07

**Disproven:** 2026-04-08

**Original Source:** [anthropics/claude-code-action docs/solutions.md](https://github.com/anthropics/claude-code-action/blob/main/docs/solutions.md)

**Contradicting Evidence:** User clarification: must cite GitHub's official sources

~~A basic workflow requires: .github/workflows YAML file, job permissions, checkout step, and action step with prompt input.~~

**Reason for Disproof:** Source is external project documentation. Must use GitHub's official workflow and action documentation.

---

## FINDING-2026-04-07-6 (DISPROVEN)

**Originally Captured:** 2026-04-08

**Disproven:** 2026-04-08

**Original Source:** `.github/workflows/inspect-ai-problem-issue.yml` (erroneous reference implementation)

**Contradicting Evidence:** User clarification: the yml file was created in error and should not be used as reference

~~Project's inspect-ai-problem-issue workflow demonstrates running a Claude skill as a GitHub Actions workflow with labeled trigger, permissions, checkout, and anthropics/claude-code-action invocation.~~

**Reason for Disproof:** References erroneous project file. Cannot be used as reference implementation.

---
