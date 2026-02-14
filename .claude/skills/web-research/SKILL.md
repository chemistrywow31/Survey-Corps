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

The Commander assigns specific dimensions to each Investigator. Do not investigate dimensions outside your assignment.

### Step 2: Search Strategy Per Dimension

**IMPORTANT**: Search queries must enforce recency requirements based on the research field type (rapid_change, moderate_change, or stable). The Commander will specify the field type in the dimension assignment.

#### For Rapid Change Fields (AI, SEO, social media algorithms, crypto, etc.)

Execute these queries in order (minimum 4 queries):

1. **Current year focus**: `"{topic} {dimension} {current_year}"`
2. **Recent trends**: `"{topic} {dimension} latest trends {current_year}"`
3. **Data-focused**: `"{topic} {dimension} statistics data {current_year}"`
4. **Expert opinion**: `"{topic} {dimension} analysis expert {current_year}"`

**Recency requirement**: At least 70% of sources must be published within the last 6 months. Do NOT use sources older than 12 months unless no alternatives exist (document this in Data Gaps).

#### For Moderate Change Fields (consumer products, market trends, etc.)

Execute these queries in order (minimum 3 queries):

1. **Broad query**: `"{topic} {dimension} market research {current_year}"`
2. **Data-focused**: `"{topic} {dimension} statistics report {current_year} OR {last_year}"`
3. **Expert opinion**: `"{topic} {dimension} forecast analysis {current_year}"`

**Recency requirement**: At least 60% of sources must be published within the last 12 months. Avoid sources older than 24 months.

#### For Stable Fields (mathematics, fundamental science, engineering principles)

Execute these queries in order (minimum 3 queries):

1. **Broad query**: `"{topic} {dimension} research review"`
2. **Data-focused query**: `"{topic} {dimension} data analysis"`
3. **Expert opinion query**: `"{topic} {dimension} expert analysis"`

**Recency requirement**: No strict time constraint, but prefer sources from the last 5 years when available.

#### Query Refinement

After initial results, refine queries by:
- Adding industry-specific terms discovered in early results
- Including specific company, product, or technology names mentioned in high-quality sources
- Combining multiple dimensions if initial results are sparse

### Step 3: Source Collection

For each relevant search result:
1. Use WebFetch to retrieve the full content.
2. Extract key data points, statistics, and expert opinions.
3. Record the source metadata (URL, title, author, publication, date).
4. **Classify the field type** (rapid_change, moderate_change, or stable) based on the research topic.
5. Apply the Source Verification skill to assess credibility using the appropriate recency rubric for the field type.
6. Add the verified source to the Source Registry with the field_type field populated.

**Minimum source requirements**:
- Collect a minimum of 5 verified sources (rating Medium or above) per dimension.
- For rapid_change fields: Ensure at least 70% of sources are within the last 6 months.
- For moderate_change fields: Ensure at least 60% of sources are within the last 12 months.

If these requirements cannot be met, document this in the Data Gaps section with specific details:
- How many recent sources were found
- Why older sources were necessary
- What search queries were attempted

### Step 4: Cross-Validation

For every critical data point (market size figures, growth rates, adoption percentages):
- Find at least 2 independent sources that corroborate the data.
- If sources disagree, record all values and note the discrepancy.
- Prefer sources with higher credibility ratings when discrepancies exist.

### Step 5: Evidence Dossier Compilation

Compile findings into the Evidence Dossier format defined in the Evidence Standard rule.

## Search Query Templates

### Market Size Research

```
"{industry} market size {year}" → WebSearch
"{industry} TAM SAM revenue forecast" → WebSearch
"{industry} market report {consulting_firm}" → WebSearch (e.g., Gartner, McKinsey, Statista)
```

### Competitive Analysis

```
"{industry} competitive landscape top companies" → WebSearch
"{competitor_name} market share revenue" → WebSearch
"{industry} startup funding recent" → WebSearch
```

### Technology Assessment

```
"{technology} adoption rate enterprise {year}" → WebSearch
"{technology} vs {alternative} comparison" → WebSearch
"{technology} maturity Gartner hype cycle" → WebSearch
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
