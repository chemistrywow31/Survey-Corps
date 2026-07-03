---
name: Context Management
description: Codex-native dispatch format, task return format, and worklog-based context isolation
---

# Context Management

## Applicability

- Applies to: all Survey Corps roles

## Rule Content

### Dispatch Format

Levi's dispatch to any role must include:

1. **Current worklog path**: where the role writes phase notes and artifacts.
2. **Upstream reference paths**: worklog or deliverable paths the role must read.
3. **Task scope summary**: the exact outcome expected from this role.
4. **Field classification**: required for research, source scoring, and source freshness checks.
5. **Acceptance criteria**: 1–5 mechanically checkable conditions the deliverable must meet — a fresh-context verifier checks exactly these per `.codex/rules/execution-contract.md` EC-3.
6. **Scope fence**: an explicit OUT list of files and directories the role must not touch.

Levi must not paste full upstream content inline — pass paths. Use XML tags for variable data:

```xml
<task_scope>Investigate market size and competitive landscape.</task_scope>
<field_classification>rapid_change</field_classification>
<upstream_context>.worklog/202605/ai-chatbot/phase-1-intake/decisions.md</upstream_context>
<acceptance_criteria>Dossier cites at least 8 sources; every claim maps to a Source Registry ID.</acceptance_criteria>
<scope_fence>OUT: do not edit the Phase 1 worklog; do not write outside the phase-2 directory.</scope_fence>
<worklog_path>.worklog/202605/ai-chatbot/phase-2-data-collection/</worklog_path>
```

### Agent Return Format

Every role returns the six-field schema in `.codex/rules/execution-contract.md` EC-1, in this order:

1. `STATUS:` DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
2. `CONCLUSIONS:` outcomes and decisions, max 10 lines
3. `EVIDENCE:` file:line pointers or command outputs proving each conclusion — `STATUS: DONE` with empty EVIDENCE is invalid
4. `ARTIFACTS:` paths to every file produced or updated, including worklog files; mark new files `(new)`
5. `RISKS/UNKNOWNS:` issues Levi must know; write "none" when none exist
6. `NEXT:` exactly one recommendation

Full detail goes to the worklog; only the summary returns to Levi. Any product longer than 30 lines goes to a file with the path in ARTIFACTS (EC-1.3). Roles must not paste file contents or raw tool output into a return.

### Completion Status Protocol

- **DONE**: all steps completed successfully; EVIDENCE provided.
- **DONE_WITH_CONCERNS**: completed with concrete issues; list each concern with severity.
- **BLOCKED**: cannot proceed; state what was attempted (up to 3 attempts per EC-2) and what is needed.
- **NEEDS_CONTEXT**: missing information; list every missing item in one return.

Levi handles each status per `.codex/rules/execution-contract.md` EC-1.5; accepting DONE additionally requires the fresh-context verification in EC-3.

### Phase-End Archival

At the end of each phase, Levi must:

1. Verify the phase worklog contains `references.md`, `findings.md`, and `decisions.md`.
2. Write a phase completion summary.
3. Store any long artifacts as files and pass paths downstream instead of pasting full content.
4. Release phase-specific context from active memory where possible.

## Violation Determination

- Dispatch omits worklog path, acceptance criteria, scope fence, or field classification when required → Violation
- Role return uses the deprecated five-section markdown return template instead of the EC-1 six-field schema → Violation
- Role return missing any EC-1 field, or with fields out of order → Violation
- Long upstream content is pasted inline when a file-path handoff would preserve context better → Violation
- Phase transition occurs before worklog completeness is verified → Violation

## Exceptions

- During Phase 1, Levi may participate in user-facing conversation directly (this is coordination, not execution).
