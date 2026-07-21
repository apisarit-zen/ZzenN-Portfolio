# 🌏 FDI & Environmental Quality: Evidence from ASEAN-6

**Type:** Applied Econometrics / Panel Data Research | **Data:** 6 countries × 22 years (2002–2023), 132 observations | **Tools:** Stata (Fixed Effects, Driscoll-Kraay SE)

## 1. Background

Foreign Direct Investment (FDI) is often promoted as a growth driver for developing economies, but its environmental consequences are contested — it can either push countries toward becoming "pollution havens" or trigger a "pollution halo" through cleaner technology transfer. This project studies that question empirically for **ASEAN-6** (Indonesia, Malaysia, Philippines, Singapore, Thailand, Vietnam), a region combining rapid economic growth with widely varying institutional quality — making it a natural setting to test whether governance shapes the environmental outcome of FDI.

## 2. Research Questions

| # | Question |
|---|---|
| RQ1 | Does economic growth in ASEAN-6 follow the Environmental Kuznets Curve (EKC) — rising emissions early in development, then falling after a turning point? |
| RQ2 | Does FDI have a direct effect on CO₂ emissions? |
| RQ3 | Does institutional quality — specifically *Voice and Accountability* (civic participation, press freedom, government accountability) — change the direction of FDI's environmental effect? |

## 3. Methodology

Panel data for 6 countries (2002–2023, N=132) was compiled from the World Bank's World Development Indicators and Worldwide Governance Indicators. A **Fixed Effects model** (selected via Hausman test, χ²(5)=101.31, p<0.001) was used to control for unobserved country-specific factors. To address heteroskedasticity, autocorrelation, and cross-sectional dependence common in cross-country panels, the main model uses **Driscoll-Kraay standard errors**. An interaction term (FDI × Voice and Accountability) was added to test whether institutional quality conditions FDI's environmental impact, with marginal effects computed at different institutional-quality levels to locate the turning point.

## 4. Key Findings

### Finding 1 — Growth Follows the EKC, But Most of ASEAN-6 Is Still on the "Upward Slope" (answers RQ1)
GDP per capita has a significant positive relationship with CO₂ emissions, while GDP² is significant and negative — the classic inverted-U pattern the EKC predicts. But most sample countries (Indonesia, the Philippines, and Vietnam in particular) haven't yet reached the income level where the curve turns downward, meaning **waiting for growth alone to reduce emissions is not a viable near-term strategy** — active environmental policy is needed now, not after development "catches up."

### Finding 2 — FDI Alone Doesn't Move the Needle, But It's Not Neutral Either (answers RQ2)
In the baseline model, FDI has no statistically significant direct effect on CO₂ (p = 0.53), and its raw correlation with emissions is weak (r = 0.16). Taken at face value, this would suggest FDI is environmentally irrelevant — but that conclusion turns out to be incomplete.

### Finding 3 — Institutional Quality Determines Whether FDI Helps or Hurts the Environment (answers RQ3, the central result)
Once *Voice and Accountability* (VA) is added as a conditioning variable, FDI becomes highly significant (p < 0.001) — its effect flips sign depending on institutional quality:
- In countries with **weak governance** (low VA), FDI is associated with *higher* CO₂ emissions — consistent with the "pollution haven" pattern, where foreign firms face little oversight.
- In countries with **strong governance** (high VA), FDI is associated with *lower* CO₂ emissions — consistent with a "pollution halo," where transparency and accountability push firms toward cleaner technology.
- The estimated **turning point is VA ≈ -0.75**. The ASEAN-6 sample average (VA = -0.39) sits above this threshold, meaning FDI is, on net, helping reduce emissions across the region — but some countries still fall below the line and remain at risk of the pollution-haven pattern.

**Takeaway:** the reason prior studies on FDI and pollution in ASEAN reached conflicting conclusions is that the relationship isn't fixed — it depends entirely on how strong a country's institutions are. Studying FDI's environmental effect without accounting for governance gives an incomplete, sometimes misleading picture.

## 5. Policy Recommendations

| Finding | Recommendation |
|---|---|
| Governance quality is the deciding factor for FDI's environmental impact | Strengthen Voice and Accountability directly: guarantee public access to environmental impact assessments, involve civil society in reviewing major foreign investment approvals, and publish annual enforcement/compliance reports for foreign firms. |
| Countries below the VA threshold (≈ -0.75) remain at pollution-haven risk | Treat institutional reform as urgent, not optional, for these countries — it's a precondition for FDI to function as a development tool rather than an environmental liability. |
| Most ASEAN-6 economies are still on the rising side of the EKC | Don't wait for growth to naturally reduce emissions — pair growth policy with proactive energy-transition measures, since energy use was the strongest single predictor of CO₂ in the model. |

## 6. Limitations
- CO₂ per capita is a single proxy for "environmental quality" — it doesn't capture air/water pollution or biodiversity loss.
- Voice and Accountability is one of six World Bank governance dimensions; other dimensions (e.g., Rule of Law, Regulatory Quality) were excluded to avoid multicollinearity, but may carry independent explanatory power.
- Country-level (macro) data can't capture industry- or firm-level variation in how FDI affects emissions.
- A 6-country sample limits generalizability beyond ASEAN.

## 7. Tools & Techniques
- **Stata:** panel data econometrics, Fixed Effects, Driscoll-Kraay standard errors, marginal effects (`nlcom`)
- **Data sources:** World Bank World Development Indicators, Worldwide Governance Indicators

---
📄 [Read the full paper (PDF)](./SR-6540140629_P7Y.pdf) — includes full literature review, descriptive statistics, correlation/VIF diagnostics, and complete regression tables.

*Research conducted as part of ECON 2900412 Research Paper, Faculty of Economics, Chulalongkorn University.*
