---
name: Report Quality
description: Final reports must follow structured format with complete sections and pass quality inspection before delivery
paths:
  - "output/**/*.html"
  - "output/**/*.pptx"
  - "output/**/*.pdf"
---

# Report Quality

## Applicability

- Applies to: `petra`, `historia`, `levi`

## Rule Content

### Report Structure

Every feasibility assessment report must contain these sections in order:

1. **Executive Summary** — One-page overview of the research topic, key findings, and recommendation.
2. **Research Methodology** — Dimensions investigated, data collection approach, source count and credibility distribution.
3. **Market Analysis** — Findings per research dimension, with inline source citations.
4. **Debate Analysis** — Summary of Eren vs. Armin arguments, areas of agreement and disagreement, strongest points from each side.
5. **Technical Feasibility** — Mikasa's evaluation of implementation viability, technology stack recommendations, risk factors.
6. **Conclusions & Recommendations** — Synthesized assessment with actionable recommendations.
7. **Appendices** — Full Source Registry, debate transcripts, raw data references.

### Format Requirements

Historia must generate the report in all requested output formats. The HTML version serves as the master document; all other formats must contain identical content.

| Format | Tool | Requirements |
|---|---|---|
| HTML | UI/UX skill + manual HTML/CSS/JS | Responsive, WCAG AA contrast, printable |
| PPTX | PptxGenJS or python-pptx | Maximum 6 bullet points per slide, speaker notes on every content slide |
| PDF | Puppeteer (from HTML) or reportlab | Preserves layout, embedded fonts, accessible |
| DOCX | python-docx or pandoc | Heading hierarchy, table of contents, page numbers |

### Content Density

- Executive Summary: 200-400 words.
- Each Market Analysis dimension: 300-800 words.
- Technical Feasibility section: 500-1500 words.
- Total report length (excluding appendices): 3000-10000 words depending on topic complexity.

### Quality Inspection Checklist

Petra must verify every item before approving the report:

- [ ] All 7 required sections are present.
- [ ] Every factual claim has a Source Registry citation.
- [ ] No source rated below 3.0 is used as primary evidence without corroboration.
- [ ] Debate Analysis accurately reflects both Eren's and Armin's positions.
- [ ] Technical Feasibility includes risk factors and mitigation strategies.
- [ ] Executive Summary matches the conclusions in the full report.
- [ ] All output formats contain identical content (no missing sections in any format).
- [ ] File names follow kebab-case convention.
- [ ] No spelling or grammar errors in the user's language.

### Revision Protocol

When Petra identifies issues:
1. Produce a QA Report listing each issue with severity (critical / high / medium / low).
2. Send the QA Report to Levi.
3. Levi routes each issue to the responsible agent for revision.
4. After revisions, Petra re-inspects issues marked critical or high.

## Violation Determination

- Final report is missing any of the 7 required sections → Violation
- Report is delivered in fewer output formats than the user requested → Violation
- Petra approves a report without completing the full checklist → Violation
- Historia delivers HTML and PPTX with different content (e.g., missing section in PPTX) → Violation
- Executive Summary exceeds 400 words → Violation
- Petra identifies a critical issue but does not require re-inspection after revision → Violation
