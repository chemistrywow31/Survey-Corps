---
name: Debate Standards
description: Multi-round debate must follow structured argument format with evidence-backed claims and fair representation
---

# Debate Standards

## Applicability

- Applies to: `levi`, `eren`, `armin`

## Rule Content

### Debate Structure

Every debate must consist of at least 1 full round. Each round contains these stages in order:

1. **Eren Opening** — Eren presents the affirmative case with evidence.
2. **Armin Rebuttal** — Armin responds to Eren's arguments and presents counterarguments.
3. **Eren Counter-rebuttal** — Eren addresses Armin's rebuttal and reinforces key points.
4. **Armin Closing** — Armin delivers final counterarguments and summary.

Levi may authorize additional rounds if unresolved points remain after Round 1.

### Argument Format

Each debate submission (opening, rebuttal, counter-rebuttal, closing) must contain:

- **Stance Declaration**: One sentence stating the position being argued.
- **Core Arguments**: Numbered list of 2-5 distinct arguments.
- **Evidence Citations**: Every argument must reference at least one Source Registry entry (e.g., `[SRC-001]`). Arguments without citations are invalid.
- **Concessions**: Acknowledge at least one valid point from the opposing side per round (except the opening).
- **Risk Assessment**: Identify 1-3 risks or weaknesses in the position being argued.

### Intellectual Honesty

Eren and Armin must:
- Argue their assigned stance vigorously, but must not fabricate evidence or misrepresent sources.
- Acknowledge strong opposing arguments rather than ignoring them.
- Distinguish between established facts, expert consensus, and speculative projections.
- Label any inference not directly supported by cited evidence as "Analyst inference."

### Levi's Moderation Duties

Levi must:
- Review each debate submission before the next stage proceeds.
- Flag submissions that lack required evidence citations and return them for revision.
- Declare the debate concluded only when both sides have completed at least 1 full round and no critical unaddressed arguments remain.
- Produce a Debate Summary after the debate concludes, listing: areas of agreement, areas of disagreement, strongest arguments from each side, and unresolved questions.

### File Naming for Debate Records

All debate submissions must be saved as files in the output directory:
- `round-{N}-eren-opening.md`
- `round-{N}-armin-rebuttal.md`
- `round-{N}-eren-counter.md`
- `round-{N}-armin-closing.md`
- `debate-summary.md` (produced by Levi after debate concludes)

## Violation Determination

- Eren or Armin submits an argument with zero Source Registry citations → Violation
- Eren or Armin fabricates a source not present in the Source Registry → Violation
- Levi allows Phase 5 to start before the debate has completed at least 1 full round → Violation
- Debate submission missing the Stance Declaration or Risk Assessment section → Violation
- Rebuttal or closing stage does not contain at least one Concession → Violation
- Levi does not produce a Debate Summary after the debate concludes → Violation
