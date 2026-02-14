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
- **Field type** (rapid_change, moderate_change, or stable) — NEW REQUIREMENT
- Credibility rating (overall score 1.0–5.0 and categorical rating: High / Medium / Low / Reject)
  - Credibility scores must use the weighted formula appropriate for the field type (see Source Verification skill)
- Key claims extracted from the source

### Recency Requirements

**CRITICAL**: Source recency requirements vary by research field type. The Commander specifies the field type during Phase 2 assignment.

#### For Rapid Change Fields (AI, SEO, social media algorithms, crypto, etc.)

- **Minimum distribution**: At least 70% of sources must be published within the last 6 months; at least 90% within the last 12 months
- **Maximum age**: Sources older than 12 months require explicit justification in the source's notes field or in the Data Gaps section
- **Recency scoring**: Use the rapid_change recency rubric from the Source Verification skill
- **Warning requirement**: If these requirements are not met, the Evidence Dossier's Executive Summary must include: "This research relies on sources older than optimal for this rapid_change topic. Findings may not fully reflect current conditions."

#### For Moderate Change Fields (consumer products, market analysis, etc.)

- **Minimum distribution**: At least 60% of sources must be published within the last 12 months
- **Maximum age**: Avoid sources older than 24 months; if used, justify in notes or Data Gaps
- **Recency scoring**: Use the moderate_change recency rubric from the Source Verification skill

#### For Stable Fields (mathematics, fundamental science, etc.)

- **Minimum distribution**: No strict requirements
- **Preference**: Prefer recent sources (last 5 years) when quality is equivalent
- **Recency scoring**: Use the stable recency rubric from the Source Verification skill

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
1. **Executive Summary** — 3-5 sentence overview of findings for the assigned dimensions. Must include a recency warning if source distribution requirements are not met.
2. **Source Recency Report** — Distribution of source publication dates:
   - Number and percentage of sources from last 3 months
   - Number and percentage of sources from last 6 months
   - Number and percentage of sources from last 12 months
   - Number and percentage of sources older than 12 months
   - Justification for any sources that exceed the maximum age for the field type
3. **Source Registry** — Structured YAML entries for all verified sources, including the field_type field.
4. **Key Findings** — Numbered findings, each with inline citations.
5. **Data Gaps** — Topics where insufficient or conflicting evidence was found, or where recency requirements could not be met.

### Cross-Reference Obligation

When two Investigators research overlapping topics, their Source Registries must be merged by the Commander before Phase 3. Duplicate sources receive a single ID. Conflicting credibility ratings are resolved by averaging.

## Violation Determination

- A factual claim in any deliverable lacks a Source Registry citation → Violation
- A source rated below 3.0 is used as primary evidence without corroboration by a 3.0+ source → Violation
- A source rated below 2.0 appears in any deliverable → Violation
- Evidence Dossier is missing the Source Registry section → Violation
- Evidence Dossier is missing the Source Recency Report section → Violation
- Investigator delivers findings without an Executive Summary or Data Gaps section → Violation
- **Source Registry entry is missing the field_type field** → Violation
- **For rapid_change fields: Less than 70% of sources are from the last 6 months AND no warning in Executive Summary** → Violation
- **For rapid_change fields: Any source older than 12 months without justification in notes or Data Gaps** → Violation
- **For moderate_change fields: Less than 60% of sources are from the last 12 months AND no documentation in Data Gaps** → Violation
- Quality Inspector approves a report containing uncited factual claims → Violation
- Quality Inspector approves a report that violates recency requirements without flagging it → Violation
