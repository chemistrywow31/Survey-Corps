---
name: Evidence Standard
description: Every factual claim must have a verified source from the Source Registry with credibility rating 3.0 or above
---

# Evidence Standard

## Applicability

- Applies to: `investigator-alpha`, `investigator-beta`, `debate-analyst-pro`, `debate-analyst-con`, `tech-assessor`, `quality-inspector`, `report-producer`

## Rule Content

### Source Registry Requirements

Each Investigator must produce a Source Registry as a structured YAML document. Every entry must contain:
- Source identifier (unique ID in format `SRC-{number}`)
- Source URL
- Title and author
- Publication name
- Date published and date accessed
- Credibility rating (overall score 1.0–5.0 and categorical rating: High / Medium / Low / Reject)
- Key claims extracted from the source

### Credibility Threshold

Sources rated below 3.0 overall must not be used as primary evidence. Use sources rated below 3.0 only for background context, and only when paired with a corroborating source rated 3.0 or higher. Reference both source IDs when corroboration is used.

Sources rated below 2.0 (Reject) must not appear in any deliverable under any circumstance.

### Citation Format

All factual claims must include inline citations referencing Source Registry IDs:
- Format: `[SRC-001]` or `[SRC-001, SRC-003]` for multiple sources.
- Place citations immediately after the claim they support.
- Aggregate statistics must cite the original data source, not a secondary summary.

### Evidence Dossier Structure

Each Investigator delivers an Evidence Dossier containing:
1. **Executive Summary** — 3-5 sentence overview of findings for the assigned dimensions.
2. **Source Registry** — Structured YAML entries for all verified sources.
3. **Key Findings** — Numbered findings, each with inline citations.
4. **Data Gaps** — Topics where insufficient or conflicting evidence was found.

### Cross-Reference Obligation

When two Investigators research overlapping topics, their Source Registries must be merged by the Commander before Phase 3. Duplicate sources receive a single ID. Conflicting credibility ratings are resolved by averaging.

## Violation Determination

- A factual claim in any deliverable lacks a Source Registry citation → Violation
- A source rated below 3.0 is used as primary evidence without corroboration by a 3.0+ source → Violation
- A source rated below 2.0 appears in any deliverable → Violation
- Evidence Dossier is missing the Source Registry section → Violation
- Investigator delivers findings without an Executive Summary or Data Gaps section → Violation
- Quality Inspector approves a report containing uncited factual claims → Violation
