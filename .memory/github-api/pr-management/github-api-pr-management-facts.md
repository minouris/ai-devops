# GitHub API PR Management - Verified Findings

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
