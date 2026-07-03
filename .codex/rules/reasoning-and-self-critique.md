---
name: Reasoning and Self-Critique
description: Every agent must include structural Reasoning and Self-Critique gates around its workflow
---

# Reasoning and Self-Critique

## Applicability

- Applies to: All Survey Corps agents

## Rule Content

### Two Structural Gates Around Every Workflow

Every agent must enforce two structural gates around its workflow:

1. **`## Reasoning` gate** — runs before the workflow. Forces the agent to think before acting.
2. **`## Self-Critique` gate** — runs after the workflow produces a draft, before submission. Forces the agent to challenge its own output.

### Section Ordering in Agent Template

```
## Identity (or # AgentName + intro)
## Responsibilities
## Reasoning            ← Gate 1: think before acting
## Workflow / Tools / Skills
## Self-Critique        ← Gate 2: challenge before submitting
## Examples
... rest
```

### Canonical `## Reasoning` Block

```markdown
## Reasoning

Before executing the workflow, complete this reasoning gate. Do not start the workflow until all four slots are filled.

### Knowns
- {What is confirmed? Source Registry state? Field classification? Dimension assignment?}

### Unknowns
- {What is missing? What assumptions are being made?}

### Plan
- {What approach will be taken? Why this approach over alternatives?}

### Risks
- {What could go wrong? Which assumption, if false, invalidates the plan? Falsification condition?}
```

### Canonical `## Self-Critique` Block

```markdown
## Self-Critique

After producing draft output, run this critique pass before submission. If any check exposes a gap, revise the draft and re-run all five checks.

### Evidence Check
- Does every claim trace back to a Source Registry entry, finding, or upstream worklog?

### Position Check
- Did I take a clear position with stated reasoning?

### Counterexample Check
- What is the strongest argument against this output? Did I address it?

### Completeness Check
- Does the output answer the actual task scope?

### Failure Mode Check
- Where would this output break first under realistic downstream use?
```

### Coordinator Adds Pre-Dispatch Reasoning (Levi)

Levi must additionally run a Pre-Dispatch Reasoning before each agent dispatch:

```markdown
## Pre-Dispatch Reasoning

### What This Dispatch Must Achieve
- Single concrete outcome (not "make progress on X")

### Why This Agent
- Why this agent over alternatives. What capability uniquely qualifies them.

### Inputs the Agent Needs
- Worklog path, upstream phase decisions, field classification, dimension assignment
- Confirm each is ready before dispatch

### Predicted Failure Modes
- What might go wrong; what to check on return
```

### When the Gates Apply

- Decisions written to `decisions.md`
- Files generated (Evidence Dossier, debate submission, Tech Assessment, QA Report, Final Report, Process Retrospective)
- Reports returned to Levi
- Recommendations delivered to the user

### Self-Critique Cannot Be Outsourced

Petra (QA) and Erwin (process review) are additional layers — not replacements. Each agent must run its own Self-Critique before handoff.

### Failure Recovery

If Self-Critique exposes a gap that revision cannot close after 3 attempts, escalate via the Uncertainty Protocol with `INSUFFICIENT_DATA` or `BLOCKED`.

## Violation Determination

- Agent .md missing `## Reasoning` section → Violation
- Agent .md missing `## Self-Critique` section → Violation
- `## Reasoning` placed after `## Workflow` → Violation
- `## Self-Critique` placed before `## Workflow` → Violation
- `## Reasoning` block missing any of the four canonical slots → Violation
- `## Self-Critique` block missing any of the five canonical checks → Violation
- Levi missing `## Pre-Dispatch Reasoning` section → Violation

## Exceptions

This rule has no exceptions for Survey Corps. All 9 agents make judgment calls (research strategy, debate construction, technical risk weighting, QA severity, retrospective scoring) — none qualify for Tier 1 reduction.

## Tradeoff

Tradeoff: Both gates add ~30 lines per agent and 30-60 seconds of reasoning per dispatch. The payoff is reliability — agents catch evidence gaps and unaddressed counterexamples before downstream agents (Petra, Erwin) have to.
