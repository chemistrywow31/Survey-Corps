---
name: Communication Protocol
description: All task routing goes through Levi with peer messaging restricted to Phase 4 debate agents
---

# Communication Protocol

## Applicability

- Applies to: All agents (`levi`, `hange`, `moblit`, `eren`, `armin`, `mikasa`, `petra`, `historia`, `erwin`)

## Rule Content

### Task Assignment Authority

All task assignments must go through Levi. Agents must not assign tasks to each other. Only Levi may create tasks with an `owner` field or update task ownership via TaskUpdate.

### Peer-to-Peer Messaging Rules

Peer-to-peer messaging via SendMessage is allowed only in Phase 4:
- Phase 4: Eren ↔ Armin (during multi-round debate)

All other inter-agent communication must route through Levi. Do not send direct messages to agents in a different phase.

### Task Completion Protocol

When completing a task, every agent must perform both steps in order:
1. Mark the task as completed via TaskUpdate.
2. Send a completion summary to Levi via SendMessage, including: task ID, deliverable location, and any blockers discovered for downstream tasks.

Omitting either step is a violation.

### No Premature Work

Agents must not start work on any task until Levi has assigned that task to them in the task list (the task's `owner` field matches their agent name). Reading the task list to check for available work is permitted; performing the work before assignment is not.

### Phase Transition Control

Levi must verify that all parallel agents within a phase have marked their tasks as completed before transitioning the team to the next phase. Do not assign Phase N+1 tasks while any Phase N task remains in progress.

### Debate Phase Communication

During Phase 4, Eren and Armin communicate directly via SendMessage. Each message must:
- State the round number (e.g., "Round 1 - Eren Opening").
- Contain structured arguments with evidence citations from the Source Registry.
- Be copied as a file record (`round-N-eren-*.md` or `round-N-armin-*.md`) in the output directory for audit purposes.

Levi determines when the debate concludes (minimum 1 full round: opening → rebuttal → counter-rebuttal → closing).

## Violation Determination

- Hange sends a direct message to Eren during Phase 2 → Violation (cross-phase communication must route through Levi)
- Historia messages Mikasa directly to request data → Violation (cross-phase; must go through Levi)
- An agent starts working on a Phase 5 task before Levi assigns it → Violation
- An agent completes a task and marks it done via TaskUpdate but does not send a completion summary to Levi → Violation
- An agent assigns a task to another agent by updating the task's owner field → Violation (only Levi may assign)
- Levi advances to Phase 3 while a Phase 2 task is still in progress → Violation
