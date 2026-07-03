---
name: Execution Contract
description: Six-field reporting, sonnet-to-opus escalation ladder, fresh-context verification, precedence order, and context economy for every Survey Corps task
---

# Execution Contract

## Applicability

- Applies to: all agents (Levi and every dispatched agent)
- Cite clauses by number when resolving disputes or writing dispatches, e.g. "per EC-2.1"

## EC-1 Reporting Contract

- **EC-1.1** Every task return must contain exactly these six fields, in this order:
  1. `STATUS:` DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
  2. `CONCLUSIONS:` max 10 lines — outcomes and decisions, not narrative
  3. `EVIDENCE:` file:line pointers or command outputs proving each conclusion
  4. `ARTIFACTS:` paths to every file produced or updated, including worklog files — mark new files `(new)`
  5. `RISKS/UNKNOWNS:` issues Levi must know; write "none" when none exist
  6. `NEXT:` exactly one recommendation
- **EC-1.2** `STATUS: DONE` with an empty `EVIDENCE` field is invalid. Levi rejects any DONE report citing zero files or commands.
- **EC-1.3** Any product longer than 30 lines — analysis, dossier, debate record, logs — must be written to a file; the report carries the path plus a summary of at most 3 lines.
- **EC-1.4** Do not paste file contents, diffs, or raw tool output into a report or dispatch. Write the content to a file and send the path.
- **EC-1.5** Status handling by Levi: DONE → dispatch EC-3 verification, then proceed. DONE_WITH_CONCERNS → log each concern to the worklog, resolve or accept explicitly, then proceed. BLOCKED → resolve the named blocker before re-dispatch. NEEDS_CONTEXT → supply every named item, then re-dispatch.
- **EC-1.6** Bounce protocol: a report violating EC-1.1–EC-1.4 is returned to the producer once with the schema attached; a second violation on the same task counts as a failed attempt under EC-2.

## EC-2 Escalation Ladder

The roster has two tiers: SONNET workers (Hange, Moblit, Mikasa, Historia, Erwin) and OPUS agents (Levi, Eren, Armin, Petra). No haiku tier exists, so the ladder is sonnet → opus.

- **EC-2.1** A sonnet-tier task that fails its acceptance check → one retry, changed approach only. Re-running the same approach is forbidden. A second consecutive failure on the same subtask → escalate to opus.
- **EC-2.2** Every escalation carries the full failure trace: the goal, every attempt with its exact error or diff path, hypotheses eliminated, and current file state. Escalating without the trace is a violation.
- **EC-2.3** Global cap: one initial attempt plus at most two retries = three attempts per subtask, across both tiers. This is the same 3-attempt bound as `rules/anti-sycophancy.md` — do not restate it here. One exception: when the cap is consumed and opus has not yet attempted, opus receives exactly one escalation attempt with the full trace.
- **EC-2.4** "Same subtask" = same acceptance criteria. Shrinking the goal to reset the attempt counter is a violation; a shrunk goal is new work only when Levi re-issues it with new acceptance criteria.
- **EC-2.5** Cap exhausted with no higher tier remaining → report BLOCKED and stop for user input.

## EC-3 Verification Protocol

- **EC-3.1** No self-verification: the agent that produced an artifact must not perform its acceptance, and Levi (who dispatched it) must never be the sole acceptor. Producer Self-Critique per `rules/reasoning-and-self-critique.md` is mandatory but never counts as acceptance.
- **EC-3.2** Acceptance is performed by a fresh-context verifier Levi dispatches via the Task tool. The verifier receives only the acceptance criteria and the artifact paths — never the producer's reasoning, drafts, or history. Reuse a non-producing agent (e.g. the other investigator checks a dossier; a fresh dispatch checks the merged Source Registry arithmetic). Petra remains the final-report QA.
- **EC-3.3** Files: the verifier opens the actual file and checks each criterion, citing file:line evidence per criterion. A criterion with no cited evidence is FAIL.
- **EC-3.4** Verdict format: one line per criterion — `{criterion} | PASS or FAIL | {evidence}` — then an overall verdict. Overall PASS requires every criterion PASS.
- **EC-3.5** A judgment is high-risk when it matches any of: charter or rule amendment, deleting or overwriting a file the current task did not create, or an external network write. Every high-risk judgment requires a second independent opinion from a separate agent.

## EC-4 Precedence Order

When two instructions conflict, the higher source wins — resolve by citing this order, never by judgment (this matches the Precedence Order in `CLAUDE.md`):

1. Safety: `settings.json` deny rules and destructive-action guards
2. Charter: `CLAUDE.md` and this contract
3. EC-3 verification requirements
4. EC-1 reporting requirements
5. EC-2 escalation requirements
6. Other rules in `rules/`
7. Task-specific dispatch instructions
8. Style preferences (tone, formatting, length aesthetics)

Two conflicting rules at the same level: the rule with the narrower Applicability wins. Still tied → report BLOCKED and ask Levi (agents) or the user (Levi).

## EC-5 Context Economy

- **EC-5.1** Dispatches follow the same path rule as reports (EC-1.4): paths in, paths out. Levi passes worklog paths, never inline upstream content.
- **EC-5.2** Two caps, the stricter wins: task reports max 40 lines; all other messages max 60 lines per agent. A dispatch may raise either cap only by stating the new number explicitly.

## Violation Determination

- Task return missing any EC-1.1 field, or fields out of order → Violation (bounce per EC-1.6)
- DONE status with empty EVIDENCE → Violation
- File contents, diffs, or transcripts pasted into a report or dispatch → Violation
- Retry of the same approach after a sonnet-tier failure → Violation
- Fourth attempt on the same acceptance criteria → Violation (the single EC-2.3 opus escalation attempt is the only exception)
- Escalation delivered without the failure trace → Violation
- Deliverable accepted with no fresh-context verifier verdict, or Levi acting as the sole acceptor → Violation
- Message exceeding 60 lines, or task report exceeding 40 lines, without a dispatch-raised cap → Violation

## Exceptions

- Phase 1 interactive conversation turns with the user are conversation, not task returns; EC-1 format does not apply to them. It applies to every artifact-producing dispatch in any phase.
- Micro-dispatches whose full context is under 200 words may pass context inline; the six-field report format still applies.

Tradeoff: EC-3 adds one verifier dispatch per accepted deliverable. This buys detection of false "done" claims before they propagate downstream — in the advanced-tech-advisory run, corrupted merge scores reached Phase 5 precisely because no independent verification existed.
