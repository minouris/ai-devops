# GitHub API Reviews - Verified Findings

See also: [github-api-reviews-facts-disproven.md](github-api-reviews-facts-disproven.md)

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
