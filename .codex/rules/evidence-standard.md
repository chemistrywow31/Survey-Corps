---
name: Evidence Standard
description: Every factual claim must cite a verified Source Registry entry scored with field-aware recency and weighted credibility
---

# Evidence Standard

## Applicability

- Applies to: `levi`, `hange`, `moblit`, `eren`, `armin`, `mikasa`, `petra`, `historia`

## Rule Content

### Field Classification Requirement

Every research project must carry a `field_classification` (`rapid_change` / `moderate_change` / `stable`) set by Levi during Phase 1. The classification must be propagated to every Phase 2 task dispatch in `<field_classification>` XML tags and recorded in every Source Registry entry. Source Verification scores Recency and the Overall formula differently per field (see `skills/source-verification/SKILL.md`).

### Source Registry Requirements

Each investigator (Hange and Moblit) must produce a Source Registry as a structured YAML document. Every entry must contain:
- Source identifier (unique ID in format `SRC-{number}`)
- Source URL
- Title and author
- Publication name
- Date published and date accessed
- `field_classification` inherited from Levi's dispatch
- `age_at_access` in months
- Per-dimension credibility scores (author_authority, publication_reputation, recency, corroboration)
- `weighting_formula` used for overall calculation
- Overall weighted score (1.0–5.0) and categorical rating (High / Medium / Low / Reject)
- Key claims extracted from the source

### Credibility Threshold

Sources rated below 3.0 overall (using the field-weighted formula) must not be used as primary evidence. Use sources rated below 3.0 only for background context, and only when paired with a corroborating source rated 3.0 or higher. Reference both source IDs when corroboration is used.

Sources rated below 2.0 (Reject) must not appear in any deliverable under any circumstance.

### Recency Thresholds by Field

The Source Registry for each investigator must satisfy these distribution requirements:

| Field | 70% of sources within | 90% of sources within | Hard ceiling |
|---|---|---|---|
| `rapid_change` | 6 months | 12 months | 12 months |
| `moderate_change` | 12 months | 24 months | 24 months |
| `stable` | 36 months | 60 months | 60 months |

**Foundational-work exception**: Sources exceeding the hard ceiling may be included only when (a) they are seminal theory, canonical methodology, or original-definition references, and (b) the `notes` field explicitly justifies the exception. Statistical data, market figures, pricing, adoption rates, and trend analysis are never eligible.

**Executive Summary warning**: When an Evidence Dossier fails the 70% threshold, its Executive Summary must open with a `Recency Warning` line stating field classification, the count of out-of-window sources, and the access date. When it fails the 90% threshold, the investigator must return `DONE_WITH_CONCERNS` and Levi must decide whether to proceed.

### Citation Format

All factual claims must include inline citations referencing Source Registry IDs:
- Format: `[SRC-001]` or `[SRC-001, SRC-003]` for multiple sources.
- Place citations immediately after the claim they support.
- Aggregate statistics must cite the original data source, not a secondary summary.

### Evidence Dossier Structure

Each investigator delivers an Evidence Dossier containing:
1. **Executive Summary** — 3-5 sentence overview of findings for the assigned dimensions.
2. **Source Registry** — Structured YAML entries for all verified sources.
3. **Key Findings** — Numbered findings, each with inline citations.
4. **Data Gaps** — Topics where insufficient or conflicting evidence was found.

### Cross-Reference Obligation

When Hange and Moblit research overlapping topics, their Source Registries must be merged by Levi before Phase 3. Duplicate sources receive a single ID. Conflicting credibility ratings are resolved by averaging.

## Violation Determination

- A factual claim in any deliverable lacks a Source Registry citation → Violation
- A source rated below 3.0 is used as primary evidence without corroboration by a 3.0+ source → Violation
- A source rated below 2.0 appears in any deliverable → Violation
- Evidence Dossier is missing the Source Registry section → Violation
- An investigator (Hange or Moblit) delivers findings without an Executive Summary or Data Gaps section → Violation
- Petra approves a report containing uncited factual claims → Violation
- Levi dispatches a Phase 2 task without `<field_classification>` → Violation
- A Source Registry entry is missing `field_classification`, `age_at_access`, or `weighting_formula` → Violation
- Overall score was calculated as a simple average instead of the field-weighted formula → Violation
- Evidence Dossier fails the 70% recency threshold but contains no Recency Warning in the Executive Summary → Violation
- Evidence Dossier fails the 90% recency threshold and investigator returned `DONE` instead of `DONE_WITH_CONCERNS` → Violation
- A source older than the hard ceiling is included without a foundational-work justification in `notes` → Violation
- A statistical/market/trend claim is cited via the foundational-work exception → Violation (exception does not apply to these claim types)
