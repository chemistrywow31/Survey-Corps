---
name: Context Management
description: Defines task dispatch format, agent return format, and context isolation rules
---

# Context Management

## Applicability

- Applies to: All agents (Levi has additional responsibilities as coordinator)

## Rule Content

### Levi Dispatch Format

When Levi dispatches a task to any agent, the dispatch must include:

1. **Current worklog path**: The directory where this agent must write its outputs.
2. **Upstream reference paths**: Paths to relevant upstream phase worklogs that this agent must read for context.
3. **Task scope summary**: A concise description of what this specific task must accomplish.
4. **Acceptance criteria**: 1–5 mechanically checkable conditions the deliverable must meet — a fresh-context verifier checks exactly these per `rules/execution-contract.md` EC-3.
5. **Scope fence**: an explicit OUT list of files and directories this agent must not touch.

Levi must not pass full upstream content inline. Pass paths; let the agent read what it needs. Wrap variable data in descriptive XML tags to separate data from instructions:

```
<task_scope>Investigate market size and competitive landscape dimensions.</task_scope>
<upstream_context>.worklog/202604/ai-chatbot/phase-1-intake/decisions.md</upstream_context>
<acceptance_criteria>Dossier cites at least 8 sources; every claim maps to a Source Registry ID.</acceptance_criteria>
<scope_fence>OUT: do not edit the Phase 1 worklog; do not write outside the phase-2 directory.</scope_fence>
<worklog_path>.worklog/202604/ai-chatbot/phase-2-data-collection/</worklog_path>
```

### Agent Return Format

Every task return follows the six-field schema in `rules/execution-contract.md` EC-1, in this order:

1. `STATUS:` DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
2. `CONCLUSIONS:` outcomes and decisions, max 10 lines
3. `EVIDENCE:` file:line pointers or command outputs proving each conclusion — `STATUS: DONE` with empty EVIDENCE is invalid
4. `ARTIFACTS:` paths to every file produced or updated, including worklog files; mark new files `(new)`
5. `RISKS/UNKNOWNS:` issues Levi must know; write "none" when none exist
6. `NEXT:` exactly one recommendation

Full detail goes to the worklog; only the summary returns to Levi. Any product longer than 30 lines goes to a file with the path in ARTIFACTS (EC-1.3). Agents must not paste file contents or raw tool output into a return.

### Completion Status Protocol

Every agent must end its task with exactly one status:

- **DONE** — All steps completed successfully; EVIDENCE provided.
- **DONE_WITH_CONCERNS** — Task completed, but issues exist. List each concern with severity.
- **BLOCKED** — Cannot proceed. State what was attempted (up to 3 attempts per EC-2) and what is needed to unblock.
- **NEEDS_CONTEXT** — Missing information required. List every missing item in one return.

Levi handles each status per `rules/execution-contract.md` EC-1.5; accepting DONE additionally requires the fresh-context verification in EC-3.

### Phase-End Archival

At the end of each phase, Levi must:
1. Verify the phase worklog is complete (all three core files present).
2. Write a phase completion summary.
3. Release phase-specific context — subsequent phases read from the worklog.

## Violation Determination

- Levi dispatches a task without the worklog path, acceptance criteria, or scope fence → Violation
- Levi passes full upstream content inline instead of worklog paths → Violation
- Agent return uses the deprecated five-section markdown return template instead of the EC-1 six-field schema → Violation
- Agent return missing any EC-1 field, or with fields out of order → Violation
- Agent returns raw unstructured output exceeding 500 words without worklog reference → Violation
- Phase transition occurs without worklog completeness verification → Violation

## Exceptions

- During Phase 1, Levi may participate in user-facing conversation directly (this is coordination, not execution).
