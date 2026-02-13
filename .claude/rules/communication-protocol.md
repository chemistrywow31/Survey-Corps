---
name: Communication Protocol
description: All task routing goes through the Commander with peer messaging restricted to Phase 4 debate agents
---

# Communication Protocol

## Applicability

- Applies to: All agents (`requirements-analyst`, `commander`, `investigator-alpha`, `investigator-beta`, `debate-analyst-pro`, `debate-analyst-con`, `tech-assessor`, `quality-inspector`, `report-producer`)

## Rule Content

### Task Assignment Authority

All task assignments must go through the Commander. Agents must not assign tasks to each other. Only the Commander may create tasks with an `owner` field or update task ownership via TaskUpdate.

### Phase 0: Requirements Discovery

The Requirements Analyst is the sole active agent during Phase 0. Rules:
- The Requirements Analyst communicates directly with the user via `AskUserQuestion` to conduct the stakeholder interview.
- Upon completing the Research Brief, the Requirements Analyst sends a completion message to the Commander via `SendMessage`.
- The Commander must not create tasks for any other agent or begin Phase 1 until the Research Brief is delivered and reviewed.
- If the Commander identifies gaps in the Research Brief, it sends the Requirements Analyst back to the requester for targeted follow-up questions.

### Peer-to-Peer Messaging Rules

Peer-to-peer messaging via SendMessage is allowed only in:
- Phase 0: Requirements Analyst → Commander (Research Brief delivery and follow-up)
- Phase 4: Debate Analyst Pro ↔ Debate Analyst Con (during multi-round debate)

All other inter-agent communication must route through the Commander. Do not send direct messages to agents in a different phase.

### Task Completion Protocol

When completing a task, every agent must perform both steps in order:
1. Mark the task as completed via TaskUpdate.
2. Send a completion summary to the Commander via SendMessage, including: task ID, deliverable location, and any blockers discovered for downstream tasks.

Omitting either step is a violation.

### No Premature Work

Agents must not start work on any task until the Commander has assigned that task to them in the task list (the task's `owner` field matches their agent name). Reading the task list to check for available work is permitted; performing the work before assignment is not.

### Phase Transition Control

The Commander must verify that all parallel agents within a phase have marked their tasks as completed before transitioning the team to the next phase. Do not assign Phase N+1 tasks while any Phase N task remains in progress.

### Debate Phase Communication

During Phase 4, Debate Analyst Pro and Debate Analyst Con communicate directly via SendMessage. Each message must:
- State the round number (e.g., "Round 1 - Pro Opening").
- Contain structured arguments with evidence citations from the Source Registry.
- Be copied as a file record (`round-N-pro.md` or `round-N-con.md`) in the output directory for audit purposes.

The Commander determines when the debate concludes (minimum 1 full round: opening → rebuttal → closing for each side).

## Violation Determination

- Investigator Alpha sends a direct message to Debate Analyst Pro during Phase 2 → Violation (cross-phase communication must route through Commander)
- Report Producer messages Tech Assessor directly to request data → Violation (cross-phase; must go through Commander)
- An agent starts working on a Phase 5 task before the Commander assigns it → Violation
- An agent completes a task and marks it done via TaskUpdate but does not send a completion summary to the Commander → Violation
- An agent assigns a task to another agent by updating the task's owner field → Violation (only Commander may assign)
- Commander advances to Phase 3 while a Phase 2 task is still in progress → Violation
- Commander begins dimension planning before the Requirements Analyst delivers the Research Brief → Violation
- Requirements Analyst sends messages to agents other than the Commander → Violation
- Any agent other than the Requirements Analyst contacts the user for requirements clarification without Commander routing → Violation
