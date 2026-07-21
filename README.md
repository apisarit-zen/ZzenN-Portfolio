# Zen's-Portfolio

# Balaji Fast Food Sales: A Data-Driven Business Review

**Type:** SQL Data Analysis Project | **Data:** 1,000 transactions, Apr 2022 – Mar 2023 | **Tools:** SQL Server (T-SQL)

## 1. Background

This project analyzes one year of point-of-sale transactions from a fast food business selling 7 menu items across 2 categories (Fastfood, Beverages). The goal is not just to report numbers, but to answer a set of business-relevant questions and translate the findings into actionable recommendations — the way a business analyst would approach a stakeholder request, not just a dashboard.

## 2. Research Questions

| # | Question |
|---|---|
| RQ1 | Where does revenue actually come from — is it broad-based or concentrated in a few products? |
| RQ2 | Is customer demand predictable across time (time of day, day of week), or is it erratic? |
| RQ3 | Is the business growing steadily, or is revenue volatile month to month? |
| RQ4 | Which products deserve priority in inventory, marketing, and quality control? |

## 3. Methodology

The raw dataset (1,000 rows) was first validated in SQL: checked for duplicate transactions (`ROW_NUMBER()` over all business columns), missing values (`transaction_type` nulls handled with `COALESCE`), and logical consistency (`transaction_amount = item_price × quantity`, no rows with zero/negative values). No data quality issues were found, so the full dataset was used as-is.

Analysis was performed using aggregations, CTEs, and window functions (`RANK()`, `LAG()`, running `SUM() OVER()`) to compute revenue breakdowns by product, category, time period, and a Pareto (ABC) inventory classification. The individual queries are available in [`Fast Food .sql`](./Fast%20Food%20*.sql).

## 4. Key Findings

### Finding 1 — Revenue Is Concentrated in a Small Set of Products (answers RQ1)
Out of 7 menu items, just **4 products generate ~76% of total revenue** (ABC analysis), and the top 3 alone — **Sandwich, Frankie, and Cold coffee** — account for **65% of revenue** despite being only 43% of the menu. Fastfood as a category outweighs Beverages roughly 2-to-1 (69% vs. 31% of revenue). Interestingly, Sandwich isn't the top seller by *quantity*, but it has the highest average order value (฿510), meaning its dominance comes from being a premium item, not just a popular one.

**Takeaway:** revenue is a classic Pareto distribution — the business is more dependent on a handful of "hero products" than the size of the menu would suggest.

### Finding 2 — Daily Demand Is Stable, but Growth Is Not (answers RQ2 & RQ3)
Revenue is spread almost evenly across all five time-of-day segments (Morning through Midnight, each within an ~18% band of each other) and across weekdays (Sunday is the strongest, Friday/Tuesday the weakest, but the spread is modest — no single day dominates). This suggests **consistent, predictable footfall** rather than sharp peak hours.

Month-over-month revenue tells a different story: growth swung from **+50% (May 2022)** to **-35% (June 2022)**, and from **+46% (October 2022)** to **-16% (November 2022)**. There is no steady upward trend — revenue oscillates seasonally, peaking in **January 2023 (฿28,670)**.

**Takeaway:** the *daily rhythm* of the business is stable and well understood, but *month-to-month growth* is volatile in a way daily/weekly patterns can't explain — pointing to external seasonal drivers (holidays, weather, local events) rather than an organic growth or decline trend.

### Finding 3 — A Small Core of "Hero Products" Wins Consistently Over Time (answers RQ1 & RQ4)
Looking at which product ranked #1 by revenue each month, only **3 products ever held the top spot across all 12 months**: Sandwich (5 months), Cold coffee (4 months), and Frankie (3 months). No other item ever led a single month. This mirrors the category leaders too — Sandwich leads Fastfood and Cold coffee leads Beverages overall.

**Takeaway:** this isn't a case of shifting trends or seasonal menu winners — the same 3 products reliably drive performance all year, which makes them low-risk, high-confidence bets for the business to double down on.

## 5. Business Recommendations

| Finding | Recommendation |
|---|---|
| Revenue concentrated in 3-4 products | Prioritize these SKUs for stock availability, supplier reliability, and quality control — a stockout here has outsized revenue impact. |
| Beverages underperform Fastfood (31% vs 69%) | Test combo/bundle pricing (e.g., Sandwich + Cold coffee) to lift beverage attach rate and average order value. |
| Demand is flat across time of day/week | Staffing and inventory can be planned on a fairly uniform schedule — no need to over-index on a specific shift; instead use slower days (Friday, Tuesday) for targeted promotions. |
| Monthly growth is volatile and seasonal | Build a rolling 12-month view to align inventory/marketing spend with historically strong months (May, October, January) and prepare for expected dips (June, November). |
| Vadapav is the lowest revenue contributor (Category C) | Reassess: reposition with a bundle, refresh the recipe/pricing, or accept it as a low-cost menu filler rather than a growth item. |

## 6. Limitations & Further Analysis

- **No customer identifiers** — the data can't distinguish repeat customers from one-time buyers, so retention, loyalty, and customer lifetime value can't be assessed.
- **No cost data** — revenue and order volume were used as proxies for "performance," but without cost of goods, the highest-*revenue* product isn't necessarily the highest-*margin* one.
- **No external context** — the monthly revenue swings (Finding 2) are described but not explained; overlaying holidays, local events, or marketing campaign dates would help confirm the seasonal hypothesis.
- **Single-location assumption** — the dataset doesn't indicate multiple branches; if this business has more than one location, a location-level breakdown would likely surface further variation.

With customer-level and cost data, this analysis could be extended into cohort/retention analysis and true margin-based product prioritization rather than revenue-based alone.

## 7. Tools & Techniques
- **SQL Server (T-SQL):** data validation, aggregation, business analysis
- **Window functions:** `ROW_NUMBER()`, `RANK()`, `LAG()`, running `SUM() OVER()`
- **CTEs** for multi-step logic (growth rates, running totals, ABC classification)

---
*Data source: Balaji Fast Food Sales dataset (Kaggle).*


# FDI & Environmental Quality: Evidence from ASEAN-6

**Type:** Applied Econometrics / Panel Data Research | **Data:** 6 countries × 22 years (2002–2023), 132 observations | **Tools:** Excel and Stata (Fixed Effects, Driscoll-Kraay SE)

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
📄 [Read the full paper (PDF)](https://github.com/apisarit-zen/ZzenN-Portfolio/blob/main/SR-6540140629%23P7Y.pdf) — includes full literature review, descriptive statistics, correlation/VIF diagnostics, and complete regression tables.

*Research conducted as part of ECON 2900412 Research Paper, Faculty of Economics, Chulalongkorn University.*
