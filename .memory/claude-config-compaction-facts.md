# Claude Config Facts: Context Compaction Subtopic

Detailed research findings on context compaction behavior in Claude API and Claude Code.

**Sources:**
- [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
- [How Claude Code works - Claude Code Docs](https://code.claude.com/docs/en/how-claude-code-works)
- [Claude Code Context Buffer Management](https://claudefa.st/blog/guide/mechanics/context-buffer-management)
- [Why Claude Loses Context After Compaction](https://docs.bswen.com/blog/2026-02-09-claude-context-loss-compaction/)
- Web search results from 2026 documentation

---

## FINDING-2026-03-05-88: Context Compaction Overview and Purpose

**Source:** [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction), [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works)
**Verified:** [VERIFIED on 2026-03-06 by https://platform.claude.com/docs/en/build-with-claude/compaction]

**What:**
Context compaction is server-side automatic summarization that extends effective context length for long conversations by replacing older context with concise summaries when approaching context window limits.

**Purpose:**
- Keeps conversations within context window limits (200K tokens for Opus 4.6, Sonnet 4.6)
- Maintains model focus and performance (long contexts degrade model attention)
- Replaces stale content with concise summaries
- Allows conversations to continue beyond raw context limits

**Not just token management:**
As conversations get longer, models struggle to maintain focus across the full history. Compaction keeps the active context focused and performant by replacing stale content with concise summaries.

**Ideal use cases:**
- Chat-based, multi-turn conversations for extended periods
- Task-oriented prompts requiring extensive follow-up work (tool use)
- Agentic workflows that may exceed 200K context window

**Supported models:**
- Claude Opus 4.6 (`claude-opus-4-6`)
- Claude Sonnet 4.6 (`claude-sonnet-4-6`)

**Status:**
Beta feature as of 2026. Requires beta header `compact-2026-01-12` in API requests.

---

## FINDING-2026-03-05-89: When Context Compaction Triggers

**Source:** [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction), [Claude Code Context Buffer](https://claudefa.st/blog/guide/mechanics/context-buffer-management)
**Verified:** [PARTIALLY VERIFIED on 2026-03-06: API trigger values verified by https://platform.claude.com/docs/en/build-with-claude/compaction; Claude Code specific values from external sources]

**What:**
Compaction triggers when input tokens exceed a configured threshold. Both API and Claude Code implementations use automatic triggering.

**API trigger configuration:**
- Default trigger: 150,000 tokens
- Minimum trigger: 50,000 tokens
- Configurable via `trigger` parameter in `context_management.edits`
- Example: `{"type": "input_tokens", "value": 150000}`

**Claude Code trigger behavior (2026):**
- Buffer reduced to ~33,000 tokens (16.5% of context window)
- Down from previous 45,000 tokens
- Change not announced in official changelog
- Triggers at 64-75% capacity (current versions)
- Older versions waited until 90%+ capacity
- Built-in completion buffer ensures agent has room to finish current task before interruption

**Detection:**
- API detects when input tokens exceed trigger threshold
- Claude Code manages automatically without user configuration
- Anthropic's engineers built in buffer for graceful compaction

**Known issues (2026):**
- Opus 4.6 reports "context full" prematurely
- `/compact` command fails in some scenarios
- First noticed in v2.1.32, still present in v2.1.34

---

## FINDING-2026-03-05-90: How Compaction Works (Process Flow)

**Source:** [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
**Verified:** [VERIFIED on 2026-03-06 by https://platform.claude.com/docs/en/build-with-claude/compaction]

**What:**
When compaction is enabled, Claude automatically follows a specific process to summarize and compact the conversation.

**API compaction process:**
1. Detect when input tokens exceed configured trigger threshold
2. Generate a summary of the current conversation
3. Create a `compaction` block containing the summary
4. Continue the response with the compacted context

**Subsequent requests:**
- Append the response (including compaction block) to messages
- API automatically drops all message blocks prior to the compaction block
- Conversation continues from the summary

**Compaction block structure:**
```json
{
  "type": "compaction",
  "content": "[summary text]",
  "cache_control": { "type": "ephemeral" }
}
```

**Multiple compactions:**
A long-running conversation may result in multiple compactions. The last compaction block reflects the final state of the prompt, replacing content prior to it with the generated summary.

**Same model for summarization:**
The model specified in your request is used for summarization. There is no option to use a different (cheaper) model for the summary.

---

## FINDING-2026-03-05-91: Default Summarization Instructions

**Source:** [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
**Verified:** [VERIFIED on 2026-03-06 by https://platform.claude.com/docs/en/build-with-claude/compaction]

**What:**
By default, compaction uses a specific summarization prompt designed to maintain continuity for future context.

**Default prompt:**
```text
You have written a partial transcript for the initial task above. Please write a summary of the transcript. The purpose of this summary is to provide continuity so you can continue to make progress towards solving the task in a future context, where the raw history above may not be accessible and will be replaced with this summary. Write down anything that would be helpful, including the state, next steps, learnings etc. You must wrap your summary in a <summary></summary> block.
```

**Custom instructions:**
- Provided via `instructions` parameter
- Completely replaces the default prompt (does not supplement)
- Example: `"Focus on preserving code snippets, variable names, and technical decisions."`

**Pause after compaction:**
- `pause_after_compaction` parameter (boolean, default `false`)
- When enabled, API returns message with `compaction` stop reason after generating compaction block
- Allows adding additional content blocks (preserving recent messages) before API continues

**Use case for pause:**
Preserve the last N messages verbatim instead of summarizing them by including them after the compaction block.

---

## FINDING-2026-03-05-92: What Gets Preserved During Compaction

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works), [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/how-claude-code-works and https://platform.claude.com/docs/en/build-with-claude/compaction]

**What:**
During compaction, certain content is prioritized for preservation while older content is summarized.

**Always preserved (Claude Code):**
- Your requests (user messages)
- Key code snippets
- Current file contents being worked on
- Recent conversation context

**Preserved with manual control (API):**
- Recent messages if using `pause_after_compaction` with manual preservation logic
- Content specified in custom `instructions` parameter
- System prompt (when using cache breakpoints)

**Example preservation pattern (API):**
```python
# Preserve the last 2 messages (1 user + 1 assistant turn)
preserved_messages = messages[-2:] if len(messages) >= 2 else messages

# Build new message list: compaction + preserved messages
messages_after_compaction = [
    {"role": "assistant", "content": [compaction_block]}
] + preserved_messages
```

**Cache behavior:**
- Compaction summary becomes new content requiring cache write
- Without cache breakpoints, system prompt would be invalidated
- Using `cache_control` breakpoint at end of system prompt keeps it cached separately
- Only the compaction summary needs new cache entry

---

## FINDING-2026-03-05-93: What Gets Removed During Compaction

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works), [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/how-claude-code-works and https://platform.claude.com/docs/en/build-with-claude/compaction]

**What:**
During compaction, older content is cleared or summarized to free context space.

**Removal priority (Claude Code):**
1. **First:** Older tool outputs are cleared
2. **Second:** Conversation history is summarized if needed
3. **Lost:** Detailed instructions from early in the conversation

**What may be lost:**
- Detailed instructions from early conversation
- Older tool use outputs
- Historical context not in recent messages
- Early conversation nuance and details

**API behavior:**
All message blocks prior to the `compaction` block are automatically dropped on subsequent requests.

**Impact:**
"Detailed instructions from early in the conversation may be lost. Put persistent rules in CLAUDE.md rather than relying on conversation history."

**Mitigation:**
- Use CLAUDE.md for persistent rules
- Use Rules for enforced standards
- Use custom summarization instructions to preserve specific content types
- Use `pause_after_compaction` to manually preserve recent messages

---

## FINDING-2026-03-05-94: What Is Reloaded After Compaction

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works), [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/how-claude-code-works: documentation limitation confirmed, streaming behavior verified]

**What:**
Information about what is automatically reloaded after compaction is limited in official documentation.

**Documented automatic loading:**
- System instructions (always present)
- CLAUDE.md content (loaded at session start, see FINDING-95 for compaction behavior)
- Auto memory MEMORY.md first 200 lines (loaded at session start)
- Skills descriptions (at session start, full content on-demand)
- MCP server tool definitions (added to every request)

**Not documented:**
- Whether CLAUDE.md is reloaded after compaction
- Whether Rules are reloaded after compaction
- Whether Skills remain loaded after compaction
- Whether MCP servers need reconnection after compaction
- What happens to loaded context after compaction

**Streaming behavior:**
When streaming with compaction enabled:
- Receive `content_block_start` event when compaction begins
- Compaction block streams differently from text blocks
- Single `content_block_delta` with complete summary content (no intermediate streaming)
- Then `content_block_stop` event

**API continuation:**
Conversation continues from the compaction summary. The summary serves as the new context baseline.

---

## FINDING-2026-03-05-95: CLAUDE.md and Rules Behavior During Compaction

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works), User discussion 2026-03-05
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/how-claude-code-works: documentation gap confirmed, official guidance verified, reload behavior not documented as claimed]

**What:**
Official documentation emphasizes using CLAUDE.md for persistent instructions but does not explicitly state whether CLAUDE.md or Rules are reloaded after compaction.

**Official guidance:**
- "Put persistent rules in CLAUDE.md rather than relying on conversation history"
- "To control what's preserved during compaction, add a 'Compact Instructions' section to CLAUDE.md"
- "Run `/compact` with a focus (like `/compact focus on the API changes`)"

**Compact Instructions feature:**
CLAUDE.md can include a special "Compact Instructions" section that tells Claude what to preserve during compaction. This suggests CLAUDE.md content influences summarization but doesn't confirm reload behavior.

**What is NOT documented:**
- Whether CLAUDE.md is reloaded after compaction occurs
- Whether Rules (.claude/rules/*.md) are reloaded after compaction
- Whether unconditional rules remain "always in context" through compaction
- Whether path-scoped rules reload when matching files are accessed again after compaction
- Priority of CLAUDE.md/Rules during compaction decisions

**Implications:**
The guidance "put persistent rules in CLAUDE.md rather than conversation history" implies:
- CLAUDE.md is more reliable than conversation for persistence
- But doesn't guarantee CLAUDE.md survives compaction
- Could mean: CLAUDE.md loads at session start (pre-compaction) vs conversation which gets compacted
- Or could mean: CLAUDE.md reloads after compaction while conversation doesn't

**User observation:**
"Rules aren't guaranteed to *remain* in context, though. If they are loaded at the start of a request, there is still a chance that they will be pushed out as the context size increases."

This uncertainty applies equally to CLAUDE.md, Rules, and Skills.

---

## FINDING-2026-03-05-96: Claude Code Specific Compaction Behavior

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works), [Claude Code Context Buffer](https://claudefa.st/blog/guide/mechanics/context-buffer-management)
**Verified:** [PARTIALLY VERIFIED on 2026-03-06: core behavior verified by https://code.claude.com/docs/en/how-claude-code-works; known issues and specific numbers from external sources]

**What:**
Claude Code implements automatic compaction with specific behaviors and user controls.

**Automatic management:**
- "Claude Code manages context automatically as you approach the limit"
- Clears older tool outputs first
- Summarizes conversation if needed
- Preserves requests and key code snippets

**User visibility:**
- Run `/context` to see what's using space
- MCP servers add tool definitions to every request
- Few servers can consume significant context before starting work
- Run `/mcp` to check per-server costs

**User control:**
- Add "Compact Instructions" section to CLAUDE.md
- Run `/compact` with focus (e.g., `/compact focus on the API changes`)
- No manual trigger threshold configuration (automatic only)

**Context window:**
"Claude's context window holds your conversation history, file contents, command outputs, CLAUDE.md, loaded skills, and system instructions."

**Known issues (2026):**
- Premature "context full" reports with Opus 4.6
- `/compact` command failures in v2.1.32-v2.1.34
- UI inaccessibility: data preserved in JSONL but no working UI to access after compaction (Issue #27242)
- Feature regression noticed around v2.1.31 timeframe (early February 2026)

**Best practices:**
- Keep CLAUDE.md under 200 lines and 2,000 tokens
- Use Skills for on-demand loading (disable-model-invocation: true)
- Use Subagents for isolated context (fresh context, return summary only)
- Review context costs regularly with `/context`

---

## FINDING-2026-03-05-97: Context Management Strategies Beyond Compaction

**Source:** [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works)
**Verified:** [VERIFIED on 2026-03-06 by https://code.claude.com/docs/en/how-claude-code-works]

**What:**
Beyond compaction, Claude Code provides features to control what loads into context.

**Skills on-demand loading:**
- Claude sees skill descriptions at session start
- Full content only loads when skill is used
- For manually invoked skills, set `disable-model-invocation: true` to keep descriptions out of context until needed
- Supports progressive disclosure pattern

**Subagents for isolation:**
- Get their own fresh context, completely separate from main conversation
- Work doesn't bloat main context
- Return summary when done
- Why subagents help with long sessions: complete context isolation

**Progressive disclosure:**
- Load detailed information only when needed
- Skills use references/ subdirectory for detailed content
- SKILL.md loads on invocation, supporting files load via Read tool when needed
- Character budget only applies to descriptions, not supporting files

**Context cost awareness:**
- Different features have different context costs
- MCP servers: tool definitions in every request
- Skills: descriptions at start, full content on use
- Subagents: no cost to main context (isolated)
- Rules: unconditional rules always present, path-scoped rules load on file access

**Monitoring:**
- `/context` command shows current usage
- `/mcp` command shows per-server costs
- Plan what loads based on task requirements

---

## FINDING-2026-03-05-98: Server-Side vs Client-Side Implementation

**Source:** [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction), [How Thinking Mode, Token Strategy, and Context Compaction Work](https://towardsdev.com/how-thinking-mode-token-strategy-and-context-compaction-really-work-in-claude-code-e5140d8e0d6f), Web search 2026
**Verified:** [PARTIALLY VERIFIED on 2026-03-06: server-side approach verified by https://platform.claude.com/docs/en/build-with-claude/compaction; client-side SDK details from external sources]

**What:**
Context compaction is primarily a **server-side operation** that occurs on Anthropic's infrastructure, not in the Claude Code client application.

**Server-side compaction (primary, recommended):**
- Compaction happens on Anthropic's servers during API requests
- Claude Code uses the server-side compaction feature from the Claude API
- Requires beta header `compact-2026-01-12` in API requests
- Handles context management automatically with minimal integration work
- The Claude model itself generates the summary on the server
- No client-side limitations or complexity

**Client-side SDK option (alternative, not recommended for most use cases):**
- Python and TypeScript SDKs include client-side compaction in `tool_runner`
- Client manages conversation context through summarization
- More integration complexity
- Less accurate token usage calculation
- Subject to client-side limitations

**Why server-side is recommended:**
- Automatic management: API handles everything
- Better token calculation: Server has accurate token counts
- No client complexity: No need to implement summarization logic
- Consistent behavior: Same implementation across all clients

**Claude Code implementation:**
- Claude Code uses the server-side API compaction feature
- When you see "Claude Code manages context automatically," this refers to Claude Code configuring the server-side compaction via API
- The `/compact` command triggers server-side compaction
- Compaction process executes on Anthropic's servers, not locally

**Clarification:**
While Claude Code (the client application) initiates and configures compaction, the actual summarization and context management occurs server-side. The model running on Anthropic's infrastructure generates the summary, not the client application.

---

## Notes

**Verification Status:** All 11 findings (FINDING-88 through FINDING-98) VERIFIED on 2026-03-06. 8 fully verified, 3 partially verified (external sources supplement official documentation). See `.memory/claude-config-compaction-verification-working.md` for detailed verification.

**Sources consulted:**
- [Compaction - Claude API Docs](https://platform.claude.com/docs/en/build-with-claude/compaction)
- [How Claude Code works - Claude Code Docs](https://code.claude.com/docs/en/how-claude-code-works)
- [Claude Code Context Buffer Management](https://claudefa.st/blog/guide/mechanics/context-buffer-management) (2026)
- [Why Claude Loses Context After Compaction](https://docs.bswen.com/blog/2026-02-09-claude-context-loss-compaction/) (2026)

**Key findings:**
1. **Compaction is a server-side operation** - executes on Anthropic's infrastructure, not in Claude Code client
2. Default trigger: 150K tokens (API), 64-75% capacity (Claude Code 2026)
3. Older tool outputs cleared first, then conversation summarized
4. Requests and key code snippets preserved
5. Early conversation instructions may be lost
6. **CLAUDE.md and Rules reload behavior NOT DOCUMENTED** - official guidance says "put persistent rules in CLAUDE.md" but doesn't confirm reload after compaction
7. Compact Instructions section in CLAUDE.md controls what's preserved in summary
8. Skills, Subagents provide alternative context management strategies
9. Server-side recommended over client-side SDK option (better token calculation, automatic management)

**Critical gap:** Whether CLAUDE.md, Rules, or Skills are automatically reloaded after compaction is not explicitly documented. This creates uncertainty about enforcement consistency in long conversations.
