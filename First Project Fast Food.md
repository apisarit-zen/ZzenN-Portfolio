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

Analysis was performed using aggregations, CTEs, and window functions (`RANK()`, `LAG()`, running `SUM() OVER()`) to compute revenue breakdowns by product, category, time period, and a Pareto (ABC) inventory classification. The individual queries are available in [`Fast Food Analysis.sql`](./Fast%20Food%20๕.sql).

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
*Data source: Balaji Fast Food Sales dataset (Kaggle). Analysis, SQL scripts, and write-up by the author.*
