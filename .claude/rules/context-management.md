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

Wrap variable data in descriptive XML tags to prevent confusion with instructions:

```
<task_scope>Investigate market size and competitive landscape dimensions.</task_scope>
<upstream_context>Phase 1 requirements confirmed: AI chatbot market, enterprise segment.</upstream_context>
<worklog_path>.worklog/202604/ai-chatbot/phase-2-data-collection/</worklog_path>
```

### Agent Return Format

When an agent completes a task, return a structured summary:

```markdown
## Task Completion: {task name}

### Status: {DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT}

### Key Outcomes
- {Outcome 1}
- {Outcome 2}

### Artifacts Produced
- {file path}: {one-line description}

### Worklog Updated
- {worklog path}: {what was written}

### Issues / Blockers (if any)
- {Issue and suggested resolution}
```

### Completion Status Protocol

Every agent must end its task with exactly one of these statuses:

- **DONE** — All steps completed successfully.
- **DONE_WITH_CONCERNS** — Task completed, but issues exist. List each concern.
- **BLOCKED** — Cannot proceed. State what was attempted and what is needed to unblock.
- **NEEDS_CONTEXT** — Missing information required. List each missing item.

### Phase-End Archival

At the end of each phase, Levi must:
1. Verify the phase worklog is complete (all three core files present).
2. Write a phase completion summary.
3. Release phase-specific context — subsequent phases read from worklog.

## Violation Determination

- Levi dispatches a task without including the worklog path → Violation
- Levi passes full upstream content inline instead of worklog paths → Violation

- Agent returns raw unstructured output exceeding 500 words without worklog reference → Violation
- Phase transition occurs without worklog completeness verification → Violation

## Exceptions

- During Phase 1, Levi may participate in user-facing conversation directly (this is coordination, not execution).
