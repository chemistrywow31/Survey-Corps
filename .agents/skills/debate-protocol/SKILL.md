---
name: debate-protocol
description: Structured multi-round adversarial debate methodology for evaluating market feasibility from opposing viewpoints
---

# Debate Protocol

Use this skill to conduct structured adversarial debates between Pro and Con analysts. Apply this skill during Phase 3 (independent analysis) and Phase 4 (multi-round debate) to produce balanced feasibility assessments.

## Debate Lifecycle

### Phase 3: Independent Analysis (Parallel)

Before the debate begins, each analyst works independently:

1. **Eren** reviews the Evidence Dossiers and builds the affirmative case.
2. **Armin** reviews the same Evidence Dossiers and builds the opposing case.
3. Neither analyst sees the other's preparation. Each produces an internal brief (not shared until Phase 4).

### Phase 4: Multi-Round Debate (Sequential Exchange)

The debate follows a structured turn-taking protocol:

```
Round N:
  1. Eren Opening / Continued Argument → saved as round-{N}-eren-opening.md
  2. Armin Rebuttal                    → saved as round-{N}-armin-rebuttal.md
  3. Eren Counter-Rebuttal             → saved as round-{N}-eren-counter.md
  4. Armin Closing                     → saved as round-{N}-armin-closing.md
```

Minimum: 1 full round. Levi decides whether additional rounds are needed.

## Submission Template

Every debate submission must follow this structure:

```markdown
# Round {N} — {Eren/Armin} {Stage}

## Stance
{One sentence declaring the position}

## Arguments

### 1. {Argument Title}
{2-4 sentences presenting the argument}
**Evidence**: [SRC-xxx] {brief description of supporting evidence}

### 2. {Argument Title}
{2-4 sentences presenting the argument}
**Evidence**: [SRC-xxx, SRC-yyy]

{Repeat for 2-5 arguments}

## Concessions
{Acknowledge 1+ valid points from the opposing side. Required for all stages except Eren's Opening in Round 1.}

## Risk Assessment
{1-3 risks or weaknesses in the position being argued}

## Key Takeaway
{One sentence summarizing the strongest point of this submission}
```

## Debate Conduct Rules

### Evidence Integrity
- Every argument must cite at least one Source Registry entry.
- Do not reference sources not present in the Source Registry.
- Do not misrepresent what a source says. Quote accurately and in context.
- Label any reasoning not directly supported by a cited source as "Analyst inference."

### Engagement Quality
- Address the opposing side's strongest arguments, not just the weakest.
- Rebuttals must directly reference specific claims from the opposing submission.
- Do not repeat the same argument verbatim across rounds. Build upon or refine it.

### Scope Discipline
- Stay within the research topic boundaries defined by the Levi.
- Do not introduce new evidence not present in the Source Registry. If new evidence is needed, request it from Levi, who may task Hange or Moblit.

## Levi Moderation Protocol

Levi moderates the debate by:

1. **Pre-debate**: Assign the debate topic and share merged Source Registry with both analysts.
2. **Between submissions**: Review each submission for compliance (citations present, structure followed, no fabricated evidence). Return non-compliant submissions for revision.
3. **Round completion check**: After each full round, assess whether:
   - Both sides have addressed each other's core arguments.
   - Critical points of disagreement are clearly identified.
   - Additional rounds would produce substantive new arguments (not just repetition).
4. **Debate conclusion**: Produce `debate-summary.md` with:
   - Areas of agreement between Eren and Armin.
   - Unresolved points of disagreement.
   - Strongest argument from each side (with source citations).
   - Recommended risk factors for the Technical Assessment phase.

## Example

### Input

Topic: "Should Company X enter the AI chatbot market?"
Evidence Dossiers from Hange and Moblit are available.

### Round 1 — Eren Opening (excerpt)

```markdown
# Round 1 — Eren Opening

## Stance
Company X must enter the AI chatbot market now to capture early-mover advantage in a $4.1B addressable market.

## Arguments

### 1. Large and Growing Market
The AI customer service chatbot market is projected to reach $4.1-4.3B by 2027 at a 23.3% CAGR [SRC-001, SRC-002]. Delaying entry reduces the window for capturing market share before consolidation.
**Evidence**: [SRC-001] Statista Global Chatbot Market Report; [SRC-002] MarketsAndMarkets Conversational AI Forecast

### 2. Enterprise Demand Acceleration
Enterprise adoption of conversational AI reached 35% in 2025, up from 18% in 2023 [SRC-003]. This adoption curve indicates strong pull-demand rather than speculative supply-push.
**Evidence**: [SRC-003] Gartner Enterprise AI Adoption Survey 2025

## Concessions
N/A (Opening statement — no opposing arguments to concede yet)

## Risk Assessment
1. Market size projections from analyst firms historically overestimate by 15-25% [Analyst inference].
2. Company X has no existing NLP team, requiring significant hiring or acquisition investment.

## Key Takeaway
The combination of rapid market growth and accelerating enterprise adoption creates a compelling entry window that narrows with each quarter of delay.
```

### Round 1 — Armin Rebuttal (excerpt)

```markdown
# Round 1 — Armin Rebuttal

## Stance
Company X must not enter the AI chatbot market due to intense competition and insufficient differentiation.

## Arguments

### 1. Market Saturation by Incumbents
The top 5 players already control 68% of the market [SRC-007]. Late entrants in saturated AI markets historically capture less than 3% market share within 3 years [SRC-009].
**Evidence**: [SRC-007] IDC Competitive Landscape Report; [SRC-009] Harvard Business Review "Late Mover Disadvantage in AI Markets"

### 2. Overstated Market Projections
Pro cites $4.1-4.3B projections, but these figures assume 23.3% CAGR — analyst projections in adjacent AI markets have overestimated actual growth by 20-30% in 3 of the last 5 years [SRC-011].
**Evidence**: [SRC-011] MIT Sloan Management Review "AI Market Forecasting Accuracy"

## Concessions
Eren correctly identifies accelerating enterprise adoption as a real trend [SRC-003]. The demand signal is genuine, though it does not guarantee that a new entrant can capture meaningful share.

## Risk Assessment
1. This argument depends on historical precedent; the AI chatbot market may behave differently from prior AI markets.
2. If Company X has a unique technological advantage not yet disclosed, the competitive barrier argument weakens.

## Key Takeaway
Strong market growth does not equal opportunity for late entrants when incumbents already dominate and switching costs are rising.
```

### Edge Case — Minimal Evidence for One Side

Input: Topic "Should Company X invest in brain-computer interface R&D?" Source Registry contains 12 sources, but only 2 support the affirmative case (BCI market is early-stage with limited commercial data).

Eren Action:
1. Build 2 arguments from the available evidence (instead of the usual 3-5).
2. Clearly label the thin evidence base in the Risk Assessment: "This affirmative case rests on only 2 primary sources. Confidence is lower than typical due to limited commercial data for BCI applications."
3. Mark any extrapolation from adjacent markets as "Analyst inference."

Armin Action:
1. Acknowledge the weak evidence base in Concessions: "Eren is constrained by limited BCI market data, which weakens both sides equally."
2. Do not exploit the thin evidence base as an argument against feasibility — argue on substance, not on evidence availability.

### Rejection Case — Source Registry Not Provided

Input: Levi assigns Phase 4 debate but does not share the merged Source Registry with the debate analysts.

Action: Both Eren and Armin return `NEEDS_CONTEXT` immediately. Do not begin constructing arguments without the Source Registry.

Output:
```
NEEDS_CONTEXT: Merged Source Registry not provided. The Debate Protocol requires all arguments to cite Source Registry entries. Provide the merged Source Registry file path before debate can begin.
```
