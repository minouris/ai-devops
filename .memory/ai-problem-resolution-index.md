# AI-DevOps Analysis Index

**Last Updated:** 2026-02-20 (session 4 — solutions history catalog created)

**Note:** Starting 2026-02-20, fact files include bi-directional cross-references:
- ai-problem-resolution-problems-facts.md → maps each problem to root causes
- ai-problem-resolution-root-causes-facts.md → maps each root cause to problems it drives

---

## Domain-Specific Fact Files

### AI Programming Problems
- [ai-devops-ai-programming-problems-facts.md](ai-devops-ai-programming-problems-facts.md) - Problems encountered using AI tools across spafw37, prompt-driven-development, claude-code-container, nightingale-truenas, simbox projects
  - Last updated: 2026-02-17 14:25
  - Facts: 5 verified (context overflow, monolithic plans, automatic loading waste, system instruction override, compiled format security)

### AI Management Problems
- [ai-problem-resolution-problems-facts.md](ai-problem-resolution-problems-facts.md) - 7 core AI management problems identified from GitHub issues and commits
  - Last updated: 2026-02-19
  - Cross-reference section maps each problem to root causes in ai-problem-resolution-root-causes-facts.md
  - Includes: 5 endemic problems (instruction non-compliance, system override, policy failure, context overflow, loading inefficiency) + 2 evolving-solutions problems (plan structure, workflow friction)
  - Disproven archive: [ai-problem-resolution-problems-facts-disproven.md](ai-problem-resolution-problems-facts-disproven.md)

### AI Root Causes
- [ai-problem-resolution-root-causes-facts.md](ai-problem-resolution-root-causes-facts.md) - Behavioural patterns addressed by policies in archived instruction files
  - Last updated: 2026-02-20
  - Covers: Hallucination, Dishonesty, Amnesia, Overeagerness + unified root cause + training culprit
  - **CLARIFICATION-2026-02-20-01:** Dishonesty recharacterised — not limited to false claims of completion; primarily false claims of correctness and general fabrication (correctness, completion, state, knowledge)
  - **CLARIFICATION-2026-02-20-02/03:** Overeagerness — a major side effect is taking control away from the user by acting on an unverified inference of what the user does want, in ways that remove the user's ability to decide otherwise
  - **FINDING-2026-02-20-09:** Context Poisoning — knock-on effect of all four root causes; AI cannot mark context items as invalidated; errors compound across turns; corroborated by SWE-bench spirals, reprompt loop, Replit fabricated data
  - **CLARIFICATION-2026-02-20-04:** Context Poisoning Amnesia chain corrected — correction is present in context but AI does not consistently apply it; mechanism unverified (hypothesis: selective retrieval / correction blindness, possibly Overconfidence not Amnesia)

### External Evidence of Problems (subtopic)
- [ai-problem-resolution-external-evidence-facts.md](ai-problem-resolution-external-evidence-facts.md) - General/external evidence of vibe coding pitfalls from published sources, academic research, and documented incidents
  - Last updated: 2026-02-20
  - Facts: 9 findings (FINDING-2026-02-20-01 through 09)
  - Covers: Vibe coding definition (Karpathy 2025), Replit/Lemkin production database deletion incident (July 2025), QA breakdown statistics (Fawzy et al. arXiv 2025), security vulnerability rates (Pearce et al. 2025 — 40% of Copilot outputs), hallucination loops in agentic coding (SWE-bench analysis), vulnerable developer problem, reprompt loop pattern
  - **FINDING-2026-02-20-08:** Cross-reference table mapping F-01–07 to internal problem types and root causes; two gaps identified (vulnerable developer not in internal taxonomy; output security quality not covered)
  - **FINDING-2026-02-20-09:** Testing and security assessment not requested by non-engineer/speed-optimising users, and not enforced by AI defaults; Overeagerness treats them as inefficiencies to skip; addresses the output security quality taxonomy gap

### Agent Issues
- [ai-problem-resolution-agent-issues-facts.md](ai-problem-resolution-agent-issues-facts.md) - Problems encountered while using the analysis agent
  - Last updated: 2026-02-20
  - Issue 6: Operation logging skipped during session (Overeagerness root cause)

### Solutions History (subtopic)
- [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md) - Catalog of all instruction/rule files across all five projects that attempt to solve one or more noted AI problems
  - Last updated: 2026-02-20
  - Solutions: 38 catalog entries (SH-001 through SH-038) spanning Oct 2025 → Feb 2026
  - Projects: spafw37, prompt-driven-development, nightingale-truenas, claude-code-container, ai-devops
  - Amnesia solutions flagged separately: SH-013, SH-014, SH-022, SH-023, SH-028, SH-029, SH-035, SH-036, SH-037
  - Evolution summary table included

### Chatmodes vs Skills Research
- [ai-devops-chatmodes-skills-facts.md](ai-devops-chatmodes-skills-facts.md) - Comparison of Custom Chatmodes/Agents, Skills, Prompts, and Claude Code Modes implementation, structure, and usage in Claude Code and GitHub Copilot
  - Last updated: 2026-02-19 (verified + new empirical finding added)
  - Facts: 24 findings
  - Verification status: Verified 2026-02-19 — 12 rejected claims corrected; see archive
  - Disproven archive: [ai-devops-chatmodes-skills-facts-archive-2026-02-19.md](ai-devops-chatmodes-skills-facts-archive-2026-02-19.md) (12 rejected claims)

---

## Analysis Outputs

*(No analysis outputs generated yet — currently in fact-gathering phase)*

---

## Verification Log

- [verification_log.md](verification_log.md) — Log of all fact verification runs

---

## Analysis Sessions

- 2026-02-17: Initial fact gathering from GitHub issues across 5 projects — identifying AI programming problems and attempted solutions
- 2026-02-19: Verification run on ai-devops-chatmodes-skills-facts.md — 12 rejected claims corrected, archive created
- 2026-02-19: Added FINDING-2026-02-19-1 — Copilot agent bodies can link to `.prompt.md` files via Markdown links (empirical observation)
- 2026-02-20 (session 2): External evidence subtopic created (7 findings); vibe coding pitfalls draft created, rejected, pending revision; agent Issue 6 logged
- 2026-02-20 (session 3): Cross-reference analysis (F-01–08); Dishonesty scope clarified; Overeagerness control-transfer clarified; Context Poisoning concept captured; Amnesia chain in Context Poisoning corrected
