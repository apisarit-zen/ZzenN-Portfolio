# ☕ Coffee Sales Dashboard (Excel)

**Type:** Excel Dashboard / Data Analysis | **Data:** 1,000 orders, 1,000 customers, 4 products, Jan 2019 – Aug 2022 | **Tools:** Excel (PivotTables, PivotCharts, Slicers, VLOOKUP/XLOOKUP)

![Coffee Sales Dashboard](./screenshots/coffee_dashboard.png)

## 1. Background
This dashboard analyzes transaction-level sales data for a coffee retailer selling 4 coffee types (Arabica, Excelsa, Liberica, Robusta) across 3 countries. The raw data comes as 3 separate tables — **orders**, **customers**, and **products** — so the project isn't just chart-building; it starts with joining relational data inside Excel before any pivoting happens. The goal is a single-page, filterable dashboard that a manager could use to check sales trends, market performance, and top customers without touching a single formula.

## 2. Business Questions
| # | Question |
|---|---|
| BQ1 | How does sales volume trend over time, and does any coffee type consistently outsell the others? |
| BQ2 | Which country drives the most revenue, and how concentrated is the business geographically? |
| BQ3 | Who are the top customers, and how much does the business depend on them? |
| BQ4 | Can the dashboard be filtered by product attributes (roast type, size) and customer loyalty status for deeper slicing? |

## 3. Data Model & Methodology
The workbook has 3 raw tables (`orders`, `customers`, `products`) linked by customer ID and product ID. **XLOOKUP** was used to pull customer name/country and product/roast/size details into the orders table, since a transaction on its own only contains IDs. Once flattened, 3 **PivotTables** were built — total sales by coffee type over time, sales by country, and top 5 customers by revenue — and each was turned into a PivotChart. Four **slicers** (Order Date, Roasted Type, Size, Loyalty Card) were connected to all three pivots simultaneously, so a manager can filter the entire dashboard by any of these dimensions at once.

## 4. Key Findings

### Finding 1 — Sales Are Split Evenly Across Coffee Types, With No Clear Winner (answers BQ1)
Across the full period, revenue is close to evenly split between the four coffee types: **Excelsa ($12,306, 27%)**, **Liberica ($12,054, 27%)**, **Arabica ($11,769, 26%)**, and **Robusta ($9,005, 20%)**. The time-series line chart also shows no coffee type consistently leads month to month — the lines cross constantly, and the spikes (e.g., Arabica in Feb 2021, Liberica in Jul 2021) look more like one-off high-volume months than a sustained trend for any single type.

**Takeaway:** this is a balanced product portfolio, not one propped up by a single hero product — Robusta is the softest performer but not by a wide margin.

### Finding 2 — Revenue Is Heavily Concentrated in the US Market (answers BQ2)
The United States accounts for **$35,639 in sales — about 79% of total revenue** — versus Ireland (15%) and the United Kingdom (6%). Customer counts follow the same pattern (782 US customers vs. 150 Ireland, 68 UK), so the concentration reflects market size, not just higher spend per customer.

**Takeaway:** the business is effectively a US-first operation with small international side markets — any disruption to the US customer base would have an outsized impact on total revenue.

### Finding 3 — No Single Customer Dominates Revenue (answers BQ3)
The top 5 customers by spend (Allis Wilmore $317, Brenn Dundredge $307, Terri Farra $289, Nealson Cuttler $282, Don Flintiff $278) sit within a narrow $40 band of each other, out of 913 customers who placed at least one order. There's no "whale" customer pulling far ahead of the rest.

**Takeaway:** customer revenue is well-diversified — the business isn't exposed to the risk of losing one or two large accounts, which is a healthier position than it might appear from the total order count alone.

## 5. Recommendations
| Finding | Recommendation |
|---|---|
| Coffee types perform evenly, Robusta slightly weaker | Test bundling Robusta with a stronger seller, or review its pricing/positioning rather than assuming it needs to be discontinued. |
| ~79% of revenue comes from the US | Prioritize US market retention (loyalty programs, restocking) while treating Ireland/UK as smaller growth opportunities rather than core revenue drivers. |
| No dominant customer | Continue current diversified acquisition strategy — there's no urgent need for high-touch account management, since revenue risk isn't concentrated in a few customers. |

## 6. Limitations
- Data covers Jan 2019 – Aug 2022 only, so any post-2022 trend shift isn't captured.
- "Top 5 Customers" is based on total historical spend, not frequency or recency — a customer who ordered once at a high value ranks the same as one with many small steady orders.
- No cost/margin data — country and product comparisons are revenue-based, not profit-based.
- Loyalty Card and Roasted Type/Size slicers allow deeper filtering, but this write-up reports only the unfiltered, all-time view; a logical next step is comparing loyalty-card vs. non-loyalty customer behavior.

## 7. Tools & Techniques
- **Excel:** PivotTables, PivotCharts, Slicers (linked across multiple pivots), XLOOKUP for relational joins
- **Data model:** 3 linked tables (orders, customers, products) flattened for analysis

---
📄 [Download the Excel file](./coffeeOrdersData.xlsx)
