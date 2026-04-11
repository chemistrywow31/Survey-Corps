---
name: Web Research
description: Structured multi-dimension web research methodology for comprehensive market data collection
---

# Web Research

Use this skill to conduct systematic web research across multiple dimensions of a market research topic. Apply this skill when collecting data for Evidence Dossiers during the data collection phase.

## Research Methodology

### Step 1: Dimension Decomposition

Break the research topic into distinct investigation dimensions. Common dimension categories:

| Category | Example Dimensions |
|---|---|
| Market Size & Growth | TAM/SAM/SOM estimates, growth rate, market segmentation |
| Competitive Landscape | Key players, market share, competitive advantages, recent moves |
| Technology Trends | Emerging tech, adoption curves, maturity assessments |
| Regulatory Environment | Current regulations, pending legislation, compliance requirements |
| Consumer/User Behavior | Demographics, preferences, pain points, adoption barriers |
| Financial Indicators | Funding trends, revenue models, pricing benchmarks |
| Risk Factors | Market risks, technology risks, regulatory risks, execution risks |

Levi assigns specific dimensions to each investigator (Hange or Moblit). Do not investigate dimensions outside your assignment.

### Step 2: Search Strategy Per Dimension (Time-Bounded)

Every search query must be time-bounded. The exact time bound depends on the topic's **field classification** from Levi's task dispatch.

| Field Classification | Required time bound in queries | Acceptable recency in results |
|---|---|---|
| `rapid_change` | `{current_year}` and `{current_year - 1}` only | Age ≤ 12 months (target ≤ 6) |
| `moderate_change` | `{current_year}` and `{current_year - 1}` | Age ≤ 24 months (target ≤ 12) |
| `stable` | `{current_year}` or `{current_year - 1}`, fallback to no bound | Age ≤ 60 months |

**Required queries** (execute all three for each dimension):

1. **Broad (current year)**: `"{topic} {dimension} {current_year}"`
2. **Broad (last year)**: `"{topic} {dimension} {current_year - 1}"`
3. **Data-focused (time-bounded)**: `"{topic} {dimension} statistics report {current_year}"`

**Supplemental queries** (execute if the three required queries return fewer than 5 credible sources):

4. `"{topic} {dimension} latest {current_year}"`
5. `"{topic} {dimension} recent update"` (no year — use only as last resort)
6. `"{topic} {dimension} quarterly report {current_year}"` (for financial / market topics)

**Forbidden queries**:

- Unbounded general queries without a year for `rapid_change` or `moderate_change` topics
- Queries that explicitly reference years older than `{current_year - 1}` unless the goal is historical baseline data
- Reusing a query identical to a prior one without refinement

Refine queries based on initial results. Add industry-specific terms discovered in early results to subsequent queries. When refining, keep the year bound intact.

### Step 2b: Pre-Search Field Classification Check

Before executing any query, confirm Levi's task dispatch contains `<field_classification>`. If it is missing or unclear, return `NEEDS_CONTEXT` immediately. Do not guess the classification — the recency threshold cascades into source scoring, evidence dossier warnings, and QA gates, and a wrong classification corrupts all of them.

### Step 3: Source Collection

For each relevant search result:
1. Use WebFetch to retrieve the full content.
2. **Confirm the publication date is within the required horizon** for the field classification. Discard results older than the cutoff unless they are foundational-methodology papers (document the justification in `notes`).
3. Extract key data points, statistics, and expert opinions.
4. Record the source metadata (URL, title, author, publication, date).
5. Apply the Source Verification skill to assess credibility using the field-aware recency table and weighted overall formula.
6. Add the verified source to the Source Registry.

Collect a minimum of 5 verified sources per dimension. If fewer than 5 credible sources (rating Medium or above) are found within the required recency horizon, document this in the Data Gaps section — do not silently substitute older sources to fill the quota.

### Step 4: Cross-Validation

For every critical data point (market size figures, growth rates, adoption percentages):
- Find at least 2 independent sources that corroborate the data.
- If sources disagree, record all values and note the discrepancy.
- Prefer sources with higher credibility ratings when discrepancies exist.

### Step 5: Evidence Dossier Compilation

Compile findings into the Evidence Dossier format defined in the Evidence Standard rule.

## Search Query Templates

All templates below include a `{current_year}` placeholder that must be substituted before search.

### Market Size Research

```
"{industry} market size {current_year}" → WebSearch
"{industry} TAM SAM revenue forecast {current_year}" → WebSearch
"{industry} market report {consulting_firm} {current_year}" → WebSearch (e.g., Gartner, McKinsey, Statista)
```

### Competitive Analysis

```
"{industry} competitive landscape top companies {current_year}" → WebSearch
"{competitor_name} market share revenue {current_year}" → WebSearch
"{industry} startup funding {current_year}" → WebSearch
```

### Technology Assessment

```
"{technology} adoption rate enterprise {current_year}" → WebSearch
"{technology} vs {alternative} comparison {current_year}" → WebSearch
"{technology} maturity Gartner hype cycle {current_year}" → WebSearch
```

### Rapid-Change Topics (AI / SEO / Social Algos / Crypto)

```
"{topic} {current_year}" → WebSearch
"{topic} update {current_month} {current_year}" → WebSearch
"{topic} latest changes {current_year}" → WebSearch
"{platform} algorithm update {current_year}" → WebSearch
```

## Example

### Input

Research topic: "AI-Powered Customer Service Chatbots"
Assigned dimension: Market Size & Growth

### Research Process

1. **Broad query**: WebSearch for "AI customer service chatbot market size 2026"
   - Result: Statista report projecting $4.1B market by 2027, CAGR 23.3%
   - Fetch full article via WebFetch, extract data points

2. **Data-focused query**: WebSearch for "conversational AI market statistics revenue report"
   - Result: MarketsAndMarkets report with segmentation data
   - Fetch and cross-validate with Statista figures

3. **Expert opinion query**: WebSearch for "AI chatbot customer service analysis expert forecast 2026"
   - Result: Gartner prediction on enterprise adoption rates
   - Fetch, verify author credentials, add to Source Registry

4. **Cross-validation**: Market size figures from Statista ($4.1B) and MarketsAndMarkets ($4.3B) are within 5% — record both with note on methodology differences.

5. **Compile**: Add all 3 verified sources to Source Registry, write Key Findings with inline citations.

### Output (Evidence Dossier excerpt)

```markdown
## Key Findings — Market Size & Growth

1. The global AI customer service chatbot market is projected to reach $4.1-4.3 billion by 2027, growing at a CAGR of 23.3% [SRC-001, SRC-002].
2. Enterprise adoption rate for conversational AI reached 35% in 2025, up from 18% in 2023 [SRC-003].
3. North America accounts for 42% of the market, followed by Europe at 28% [SRC-002].

## Data Gaps

- Limited data on SMB adoption rates (most reports focus on enterprise).
- No credible source found for churn rates of chatbot implementations.
```

### Edge Case — Sparse Results

Input: Research topic "Quantum Computing in Agricultural Supply Chain Optimization", assigned dimension: Market Size & Growth.

Research Process:
1. **Broad query**: WebSearch for "quantum computing agriculture supply chain market size 2026" — returns 0 relevant results.
2. **Refined query**: WebSearch for "quantum computing supply chain optimization market" — returns 2 results, both from vendor whitepapers (credibility capped at 3).
3. **Adjacent query**: WebSearch for "quantum computing enterprise market size" — returns 3 credible results for the broader quantum computing market, but none specific to agriculture.

Action: Report the data gap. Include the 2 broader quantum computing market sources with a note that agriculture-specific data is unavailable. Document all 6 attempted queries in the Data Gaps section.

Output (Evidence Dossier excerpt):
```markdown
## Data Gaps — Market Size & Growth

- No credible source found for quantum computing applications specifically in agricultural supply chain. Queries attempted: [list all 6 queries].
- Broader quantum computing enterprise market data available from [SRC-001, SRC-002] but cannot be directly extrapolated to the agriculture vertical.
- Recommend: Levi consider removing this dimension or broadening it to "Quantum Computing in Supply Chain" (all industries).
```

### Rejection Case — No Research Topic Provided

Input: Hange or Moblit receives dimension assignment "Market Size & Growth" but no research topic is specified in Levi's dispatch.

Action: Return `NEEDS_CONTEXT` immediately. Do not execute any search queries without a defined research topic.

Output:
```
NEEDS_CONTEXT: Research topic not specified in task dispatch. Received dimension assignment "Market Size & Growth" but cannot construct search queries without the research topic. Provide the research topic (e.g., "AI-powered customer service chatbots") to proceed.
```
