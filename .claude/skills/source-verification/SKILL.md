---
name: Source Verification
description: Verifies web source credibility with field-aware recency scoring and produces structured Source Registry entries
---

# Source Verification

Use this skill to evaluate the credibility of web sources and produce structured Source Registry entries. Apply this skill to every source discovered during research before including it in any deliverable.

## Research Field Classification (Required)

Before scoring any source, identify the research topic's **change velocity**. Recency scoring and overall weighting depend on this classification. Levi sets the classification during Phase 1 intake and passes it in the task dispatch under `<field_classification>`. If it is missing, return `NEEDS_CONTEXT` — do not guess.

| Category | Examples | Default Recency Horizon |
|---|---|---|
| `rapid_change` | AI / LLM, SEO / AEO / GEO, social media algorithms, cryptocurrency, short-form video platforms, prompt engineering, frontier model releases | 3-6 months |
| `moderate_change` | Consumer tech products, startup funding, tech adoption, DTC brands, cloud infra pricing, regional market analysis | 6-12 months |
| `stable` | Mathematics, classical engineering principles, fundamental science, long-horizon macroeconomics, established medical guidelines | 1-5 years |

When a topic spans multiple velocities, use the **fastest applicable** category for the portion that determines the conclusion. Example: "AI chatbot for enterprise customer service" = `rapid_change` (AI tech) even though "enterprise customer service" is stable.

## Credibility Assessment Criteria

Evaluate each source against these four dimensions:

### 1. Author Authority

| Score | Definition |
|---|---|
| 5 | Recognized expert with peer-reviewed publications or senior role at a leading institution in the field |
| 4 | Professional with demonstrated experience and public track record in the domain |
| 3 | Credentialed professional or journalist at a reputable outlet covering the topic |
| 2 | Anonymous author, self-published, or author with no verifiable credentials |
| 1 | Known unreliable author, previously retracted work, or clear conflict of interest |

### 2. Publication Reputation

| Score | Definition |
|---|---|
| 5 | Tier-1 academic journal, official government data source, or established industry authority (e.g., Nature, IEEE, WHO) |
| 4 | Major news outlet with editorial standards, well-known industry publication (e.g., Reuters, Wired, Harvard Business Review) |
| 3 | Reputable blog, mid-tier publication, or company engineering blog with editorial review |
| 2 | Personal blog, forum post, or publication with no editorial process |
| 1 | Known misinformation source, content farm, or site with a history of retractions |

### 3. Recency (Field-Aware)

Score recency using the column matching the research topic's field classification. A 4-year-old AI paper is effectively obsolete; a 4-year-old engineering principle is current. Never use a single scale for all topics.

| Score | `rapid_change` | `moderate_change` | `stable` |
|---|---|---|---|
| 5 | ≤ 3 months | ≤ 6 months | ≤ 12 months |
| 4 | ≤ 6 months | ≤ 12 months | ≤ 24 months |
| 3 | ≤ 9 months | ≤ 18 months | ≤ 36 months |
| 2 | ≤ 12 months | ≤ 24 months | ≤ 60 months |
| 1 | > 12 months or no date | > 24 months or no date | > 60 months or no date |

**Foundational-work exception**: Seminal methodology, original theory, or canonical references may retain their recency score when older, provided `notes` explicitly justifies the exception. Never applies to statistical data, market figures, pricing, adoption rates, or trend analysis.

### 4. Corroboration

| Score | Definition |
|---|---|
| 5 | Core claims confirmed by 3 or more independent sources |
| 4 | Core claims confirmed by 2 independent sources |
| 3 | Core claims confirmed by 1 independent source |
| 2 | No corroboration found, but claims are plausible and consistent with domain knowledge |
| 1 | Claims contradict multiple reliable sources |

## Overall Credibility Score (Field-Weighted)

Calculate the overall credibility score using the weighted formula for the topic's field classification. Rapid-change fields weight Recency heavily to prevent stale-but-prestigious sources from passing as High credibility.

| Field | Author Authority | Publication Reputation | Recency | Corroboration |
|---|---|---|---|---|
| `rapid_change` | 0.15 | 0.15 | **0.50** | 0.20 |
| `moderate_change` | 0.20 | 0.20 | **0.35** | 0.25 |
| `stable` | 0.25 | 0.25 | 0.25 | 0.25 |

Round the weighted result to one decimal place. Record the formula used in the `weighting_formula` field so downstream agents can audit the calculation. A rapid-change source with Recency 2 and all other dimensions at 5 produces `(5×0.15)+(5×0.15)+(2×0.50)+(5×0.20) = 3.5` → Medium, not High — the intended correction.

| Overall Score | Rating | Usage Guidance |
|---|---|---|
| 4.0 - 5.0 | High | Use freely as a primary source |
| 3.0 - 3.9 | Medium | Use with attribution; pair with a higher-rated corroborating source when possible |
| 2.0 - 2.9 | Low | Do not use as a primary source; use only for background context with explicit caveat |
| 1.0 - 1.9 | Reject | Do not include in any deliverable under any circumstance |

## Verification Process

Follow these steps for each source:

1. **Confirm the field classification** from Levi's task dispatch (`rapid_change` / `moderate_change` / `stable`). If absent, return `NEEDS_CONTEXT`.
2. **Identify the source URL and retrieve the content** using WebFetch.
3. **Determine the author**: Find the author name, bio, and affiliations. Search for the author's other publications and credentials using WebSearch.
4. **Assess the publication**: Identify the publishing outlet. Check its reputation, editorial policies, and history.
5. **Check recency**: Find the publication date. Calculate the age relative to today. Score using the recency table for the confirmed field classification.
6. **Corroborate claims**: Extract the 2-3 core factual claims from the source. Search for each claim independently using WebSearch to find confirming or contradicting sources.
7. **Score each dimension** using the rubrics above.
8. **Calculate the weighted overall score** using the formula for the field classification. Record the formula in `notes`.
9. **Produce the Source Registry entry** in the format below.

## Source Registry Entry Format

```yaml
source_id: SRC-{sequential_number}
url: "{full URL}"
title: "{article or page title}"
author: "{author name or 'Unknown'}"
publication: "{outlet name}"
date_published: "{YYYY-MM-DD or 'Unknown'}"
date_accessed: "{YYYY-MM-DD}"
field_classification: "{rapid_change|moderate_change|stable}"
age_at_access: "{N months}"
credibility:
  author_authority: {1-5}
  publication_reputation: {1-5}
  recency: {1-5}
  corroboration: {1-5}
  overall: {weighted score, 1 decimal}
  rating: "{High|Medium|Low|Reject}"
  weighting_formula: "{e.g. rapid_change: 0.15/0.15/0.50/0.20}"
key_claims:
  - claim: "{factual claim extracted from source}"
    corroborated_by: ["{SRC-xxx}", "{SRC-yyy}"]  # or [] if none
notes: "{any caveats, biases, or foundational-work justification relevant to using this source}"
```

## Example

### Input

Verify the credibility of this source for research on "Electric Vehicle Battery Market":
- URL: `https://www.bloomberg.com/news/articles/2025-ev-battery-supply-chain`
- Field classification (from Levi): `moderate_change` (consumer tech and market sizing)

### Verification Process

- Field: `moderate_change` → use moderate recency table and 0.20/0.20/0.35/0.25 weighting.
- Title: "EV Battery Supply Chain Faces Critical Mineral Shortage" by Sarah Chen, Bloomberg Energy Correspondent.
- Author Authority **4** (5+ years covering energy, strong journalism track record).
- Publication Reputation **5** (Bloomberg, Tier-1 financial news).
- Recency **4** (published 2025-09-12, accessed 2026-04-12, age 7 months, within moderate 12-month window).
- Corroboration **4** (claim "Lithium deficit 500k tonnes by 2030" confirmed by SRC-005 IEA, SRC-008 S&P).
- Overall: `(4×0.20)+(5×0.20)+(4×0.35)+(4×0.25) = 4.2` → **High**.

### Output

```yaml
source_id: SRC-012
url: "https://www.bloomberg.com/news/articles/2025-ev-battery-supply-chain"
title: "EV Battery Supply Chain Faces Critical Mineral Shortage"
author: "Sarah Chen"
publication: "Bloomberg"
date_published: "2025-09-12"
date_accessed: "2026-04-12"
field_classification: "moderate_change"
age_at_access: "7 months"
credibility:
  author_authority: 4
  publication_reputation: 5
  recency: 4
  corroboration: 4
  overall: 4.2
  rating: "High"
  weighting_formula: "moderate_change: 0.20/0.20/0.35/0.25"
key_claims:
  - claim: "Lithium supply deficit projected at 500,000 tonnes by 2030"
    corroborated_by: ["SRC-005", "SRC-008"]
  - claim: "Battery cell costs rebounded 8% in 2025 due to mineral constraints"
    corroborated_by: ["SRC-005"]
notes: "Strong financial journalism source. Bloomberg may have pro-market bias; cross-check with academic or government sources for supply projections."
```

### Contrast — Same Source in Rapid-Change Field

If cited for `rapid_change` research (e.g., "AI-assisted battery chemistry discovery"), the same Bloomberg article's Recency drops to **2** (9-12 month window) and the weighted formula produces `(4×0.15)+(5×0.15)+(2×0.50)+(4×0.20) = 3.15` → **Medium**. Cannot be used as primary evidence in rapid-change research without fresher corroboration.

## Edge Cases

- **Paywalled content**: Score based on abstract, author credentials, and publication reputation. Note: "Full text not accessible; scored on metadata."
- **Social media posts** (Twitter/X, LinkedIn, Reddit): Cap publication reputation at 2. Author authority may still score high for verified domain experts.
- **Pre-print servers** (arXiv, medRxiv): Cap publication reputation at 3. Note the lack of peer review.
- **Company blogs and whitepapers**: Cap publication reputation at 3. Note commercial bias.
- **Government statistics**: Default publication reputation to 5 for official agencies.

### Rejection Case — Unretrievable Source

If WebFetch cannot retrieve the content (HTTP 404, no cache), do not assign scores. Create a Source Registry entry with `title: "UNRETRIEVABLE"`, all credibility dimensions at 0, `rating: "Reject"`, `key_claims: []`, and a note explaining the failure. If the source was the only evidence for a critical claim, report `INSUFFICIENT_DATA: Source {URL} unretrievable. Request Hange or Moblit to find a replacement.`
