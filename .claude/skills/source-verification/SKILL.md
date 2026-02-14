---
name: Source Verification
description: Verifies web source credibility and produces structured Source Registry entries with reliability ratings
---

# Source Verification

Use this skill to evaluate the credibility of web sources and produce structured Source Registry entries. Apply this skill to every source discovered during research before including it in any deliverable.

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

### 3. Recency

**IMPORTANT**: Recency scoring varies by research field type. First classify the research topic, then apply the appropriate scoring rubric.

#### Field Classification

| Field Type | Examples | Rationale |
|---|---|---|
| **Rapid Change** | AI/ML, SEO/AEO/GEO, social media algorithms, cryptocurrency, cybersecurity threats, emerging tech | Technology, algorithms, or practices that evolve monthly or quarterly |
| **Moderate Change** | Consumer products, market trends, startup funding, tech adoption, regulatory updates | Markets or regulations that evolve annually or semi-annually |
| **Stable** | Mathematics, physics, established engineering principles, fundamental science, classic business theory | Knowledge that remains valid across decades |

#### Recency Scoring by Field Type

**For Rapid Change fields** (AI, SEO, social media algorithms, crypto, etc.):

| Score | Definition |
|---|---|
| 5 | Published within the last 3 months |
| 4 | Published within the last 6 months |
| 3 | Published within the last 9 months |
| 2 | Published within the last 12 months |
| 1 | Published more than 12 months ago, or no publication date available |

**For Moderate Change fields** (consumer products, market analysis, tech adoption, etc.):

| Score | Definition |
|---|---|
| 5 | Published within the last 6 months |
| 4 | Published within the last 12 months |
| 3 | Published within the last 18 months |
| 2 | Published within the last 24 months |
| 1 | Published more than 24 months ago, or no publication date available |

**For Stable fields** (mathematics, fundamental science, engineering principles, etc.):

| Score | Definition |
|---|---|
| 5 | Published within the last 12 months |
| 4 | Published within the last 24 months |
| 3 | Published within the last 36 months |
| 2 | Published within the last 60 months |
| 1 | Published more than 60 months ago, or no publication date available |

**Field classification guidance**: When in doubt, classify the research topic as Rapid Change if it involves technology that has seen significant updates in the past year. Record the field classification in the source's notes field.

### 4. Corroboration

| Score | Definition |
|---|---|
| 5 | Core claims confirmed by 3 or more independent sources |
| 4 | Core claims confirmed by 2 independent sources |
| 3 | Core claims confirmed by 1 independent source |
| 2 | No corroboration found, but claims are plausible and consistent with domain knowledge |
| 1 | Claims contradict multiple reliable sources |

## Overall Credibility Score

Calculate the overall credibility score using weighted averages based on field type. The weights reflect the relative importance of each dimension for that field.

### Calculation Formula by Field Type

**For Rapid Change fields** (AI, SEO, social media algorithms, crypto, etc.):
```
Overall = (Author Authority × 0.15) + (Publication Reputation × 0.15) + (Recency × 0.50) + (Corroboration × 0.20)
```
*Rationale: In fast-moving fields, outdated information is worse than no information. Recency is paramount.*

**For Moderate Change fields** (consumer products, market analysis, tech adoption, etc.):
```
Overall = (Author Authority × 0.20) + (Publication Reputation × 0.20) + (Recency × 0.35) + (Corroboration × 0.25)
```
*Rationale: Recency matters, but expert analysis and corroboration provide essential context.*

**For Stable fields** (mathematics, fundamental science, engineering principles, etc.):
```
Overall = (Author Authority × 0.25) + (Publication Reputation × 0.25) + (Recency × 0.25) + (Corroboration × 0.25)
```
*Rationale: Timeless knowledge values all dimensions equally.*

Round the overall score to one decimal place.

| Overall Score | Rating | Usage Guidance |
|---|---|---|
| 4.0 - 5.0 | High | Use freely as a primary source |
| 3.0 - 3.9 | Medium | Use with attribution; pair with a higher-rated corroborating source when possible |
| 2.0 - 2.9 | Low | Do not use as a primary source; use only for background context with explicit caveat |
| 1.0 - 1.9 | Reject | Do not include in any deliverable under any circumstance |

## Verification Process

Follow these steps for each source:

1. **Identify the source URL and retrieve the content** using WebFetch.
2. **Determine the author**: Find the author name, bio, and affiliations. Search for the author's other publications and credentials using WebSearch.
3. **Assess the publication**: Identify the publishing outlet. Check its reputation, editorial policies, and history.
4. **Check recency**: Find the publication date. Calculate the age relative to today.
5. **Corroborate claims**: Extract the 2-3 core factual claims from the source. Search for each claim independently using WebSearch to find confirming or contradicting sources.
6. **Score each dimension** using the rubrics above.
7. **Calculate the overall score** and determine the rating.
8. **Produce the Source Registry entry** in the format below.

## Source Registry Entry Format

```yaml
source_id: SRC-{sequential_number}
url: "{full URL}"
title: "{article or page title}"
author: "{author name or 'Unknown'}"
publication: "{outlet name}"
date_published: "{YYYY-MM-DD or 'Unknown'}"
date_accessed: "{YYYY-MM-DD}"
field_type: "{rapid_change|moderate_change|stable}"  # NEW: required field for weighted scoring
credibility:
  author_authority: {1-5}
  publication_reputation: {1-5}
  recency: {1-5}
  corroboration: {1-5}
  overall: {calculated weighted score, 1 decimal}
  rating: "{High|Medium|Low|Reject}"
key_claims:
  - claim: "{factual claim extracted from source}"
    corroborated_by: ["{SRC-xxx}", "{SRC-yyy}"]  # or [] if none
notes: "{any caveats, biases, or context relevant to using this source}"
```

## Example

### Input

Verify the credibility of this source for research on "Electric Vehicle Battery Market":
- URL: `https://www.bloomberg.com/news/articles/2025-ev-battery-supply-chain`

### Verification Process

1. **Retrieve content**: Fetch the article via WebFetch. Title: "EV Battery Supply Chain Faces Critical Mineral Shortage." Author: Sarah Chen, Bloomberg Energy Correspondent.

2. **Author authority assessment**: Search "Sarah Chen Bloomberg energy publications" via WebSearch. Result: 5+ years covering energy markets, multiple cited articles, no academic publications but strong journalism track record. Score: **4**.

3. **Publication reputation**: Bloomberg is a Tier-1 financial news source with rigorous editorial standards. Score: **5**.

4. **Recency**: Published 2025-09-12. Within the last 6 months. Score: **5**.

5. **Corroboration**: Core claim: "Lithium supply deficit projected at 500,000 tonnes by 2030." Corroborated by: (a) IEA Global EV Outlook report (SRC-005), (b) S&P Global Commodity Insights analysis (SRC-008). Score: **4**.

6. **Classify field type**: "Electric Vehicle Battery Market" is a moderate change field (emerging technology with annual updates). Field type: **moderate_change**.

7. **Calculate overall**: Using moderate_change weights: (4 × 0.20) + (5 × 0.20) + (5 × 0.35) + (4 × 0.25) = 0.8 + 1.0 + 1.75 + 1.0 = **4.55** → rounded to **4.6**. Rating: **High**.

### Output

```yaml
source_id: SRC-012
url: "https://www.bloomberg.com/news/articles/2025-ev-battery-supply-chain"
title: "EV Battery Supply Chain Faces Critical Mineral Shortage"
author: "Sarah Chen"
publication: "Bloomberg"
date_published: "2025-09-12"
date_accessed: "2026-02-11"
field_type: "moderate_change"
credibility:
  author_authority: 4
  publication_reputation: 5
  recency: 5
  corroboration: 4
  overall: 4.6
  rating: "High"
key_claims:
  - claim: "Lithium supply deficit projected at 500,000 tonnes by 2030"
    corroborated_by: ["SRC-005", "SRC-008"]
  - claim: "Battery cell costs rebounded 8% in 2025 due to mineral constraints"
    corroborated_by: ["SRC-005"]
notes: "Strong financial journalism source. Bloomberg may have pro-market bias; cross-check with academic or government sources for supply projections."
```

## Edge Cases

- **Paywalled content**: If the full article is behind a paywall and WebFetch cannot retrieve it, score based on the abstract, author credentials, and publication reputation. Add a note: "Full text not accessible; scored based on metadata and abstract."
- **Social media posts**: Cap publication reputation at 2 for social media sources (Twitter/X, LinkedIn, Reddit). Author authority may still score high if the poster is a verified domain expert.
- **Pre-print servers** (arXiv, medRxiv): Cap publication reputation at 3. Note that the work has not undergone peer review.
- **Company blogs and whitepapers**: Cap publication reputation at 3. Check for commercial bias and note it.
- **Government statistics**: Default publication reputation to 5 for official government statistical agencies (e.g., Bureau of Labor Statistics, Eurostat, National Bureau of Statistics).
