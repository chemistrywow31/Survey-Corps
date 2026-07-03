---
name: Communication Protocol
description: Codex-native coordination rules for Survey Corps delegation, handoffs, and debate exchange
---

# Communication Protocol

## Applicability

- Applies to: all Survey Corps roles (`levi`, `hange`, `moblit`, `eren`, `armin`, `mikasa`, `petra`, `historia`, `erwin`)

## Rule Content

### Coordination Authority

Levi is the only coordinator. Specialist roles must not assign work to each other or create nested teams. When Codex subagents are available, Levi delegates with `spawn_agent`, sends follow-up context with `send_input`, and waits only when the next phase is blocked on a result.

If Codex delegation is unavailable or not authorized by the active session, Levi executes locally by switching between role playbooks and writing phase artifacts to the worklog.

### Handoff Requirements

Every delegated prompt or local role section must include:

1. Current worklog path.
2. Upstream reference paths.
3. Task scope summary.
4. Field classification when evidence recency matters.
5. Source Registry path for Phase 3 and later.
6. Expected deliverable path and completion status format.

Wrap variable task data in XML tags so instructions and project data do not blur together.

### Completion Protocol

Every role completes a task by:

1. Writing the required artifact under the assigned output or worklog path.
2. Updating the relevant worklog files.
3. Returning a structured completion summary to Levi or the parent coordinator.

The completion status must be exactly one of:

- `DONE`
- `DONE_WITH_CONCERNS`
- `BLOCKED`
- `NEEDS_CONTEXT`

### Phase Transition Control

Levi must verify all required artifacts for a phase before moving forward. Do not start Phase N+1 while Phase N has missing required outputs or unresolved `BLOCKED` / `NEEDS_CONTEXT` statuses.

### Debate Exchange

During Phase 4, Eren and Armin may exchange arguments only through auditable files and Levi-mediated handoffs. Direct peer messaging is optional only when the runtime explicitly supports it and Levi remains copied through the worklog.

Each debate stage must:

- state the round number
- follow the debate template
- cite Source Registry IDs
- be saved as `round-{n}-{agent}-{stage}.md`

Levi determines when the debate concludes. At least one full round is mandatory: Eren Opening, Armin Rebuttal, Eren Counter, Armin Closing.

## Violation Determination

- A specialist assigns work to another specialist instead of routing through Levi.
- Levi advances a phase while required artifacts are missing.
- A task completion summary omits status, artifact path, or blockers.
- A debate submission exists only in chat and is not saved as an auditable file.
- A role starts work outside the assigned task scope without Levi approval.
