SELECT *
FROM [dbo].[Balaji Fast Food Sales Report];

/* Check Duplicate */
SELECT 
    *,
    ROW_NUMBER() OVER(PARTITION BY 
                    [date],
                    [item_name],
                    [item_type],
                    [item_price],
                    [quantity],
                    [transaction_amount],
                    [transaction_type],
                    [received_by],
                    [time_of_sale] ORDER BY [order_id]) ROWNUM
FROM [dbo].[Balaji Fast Food Sales Report]
ORDER BY ROWNUM DESC;

/* Coalesce transaction_type */
SELECT [order_id]
      ,[date]
      ,[item_name]
      ,[item_type]
      ,[item_price]
      ,[quantity]
      ,[transaction_amount]
      ,COALESCE([transaction_type],'Unknown') [transaction_type]
      ,[received_by]
      ,[time_of_sale]
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

/* Validate transaction amount */
SELECT *
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
WHERE transaction_amount <> item_price * quantity;

/* check wrong data */
SELECT *
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
WHERE quantity <= 0
   OR item_price <= 0
   OR transaction_amount <= 0;

/* check distinct */
SELECT DISTINCT item_name
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

SELECT DISTINCT item_type
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

SELECT DISTINCT transaction_type
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

SELECT DISTINCT received_by
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

SELECT DISTINCT time_of_sale
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

/* Extract date*/
SELECT
    date,
    YEAR(date) AS year,
    MONTH(date) AS month,
    DAY(date) AS day,
    DATENAME(WEEKDAY, date) AS weekday
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];




/* start analysis */
/* 1.Overall Business Performance */
SELECT 
    COUNT(order_id) Total_order,
    SUM(transaction_amount) Total_revenue,
    AVG(transaction_amount) AVG_order_value
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report];

/* 2.Best Seller Item */
SELECT 
    item_name,
    SUM(quantity) Total_quantity,
    SUM(transaction_amount) Revenue_By_Item
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY item_name
ORDER BY Revenue_By_Item DESC;

/* 3.Category Performance */
SELECT 
    item_type,
    SUM(quantity) Item_sold,
    SUM(transaction_amount) Revenue_By_Item
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY item_type
ORDER BY Revenue_By_Item DESC;

/* 4.Sales by Time of the day */
SELECT
    time_of_sale,
    COUNT(*) AS orders,
    SUM(transaction_amount) AS revenue
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY time_of_sale
ORDER BY revenue DESC;

/* 5.Peak Selling Days */
SELECT
    DATENAME(WEEKDAY, date) AS weekday,
    COUNT(*) AS orders,
    SUM(transaction_amount) AS revenue
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY revenue DESC;

/* 6.Month Over Month Revenue Growth(%) */
WITH MonthlyRevenue AS
(
    SELECT
        YEAR([date]) AS sales_year,
        MONTH([date]) AS sales_month,
        SUM(transaction_amount) AS revenue
    FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
    GROUP BY YEAR([date]), MONTH([date])
),
MonthlyGrowth AS
(
    SELECT
        sales_year,
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_year, sales_month
        ) AS previous_revenue
    FROM MonthlyRevenue
)
SELECT
    sales_year,
    sales_month,
    revenue,
    previous_revenue,
    revenue - previous_revenue AS revenue_growth,
    ROUND(
        (revenue - previous_revenue) * 100
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_pct
FROM MonthlyGrowth
ORDER BY sales_year, sales_month;


/* 7.Ranking Product in Each Category */
WITH ProductSales AS
(
    SELECT
        item_type,
        item_name,
        SUM(transaction_amount) AS total_revenue,
        RANK() OVER(
            PARTITION BY item_type
            ORDER BY SUM(transaction_amount) DESC
        ) AS ranking
    FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
    GROUP BY item_type, item_name
)
SELECT *
FROM ProductSales;


/* 8.Monthly best-selling product */
WITH MonthlyProduct AS
(
SELECT
    YEAR([date]) sales_year,
    MONTH([date]) sales_month,
    item_name,
    SUM(transaction_amount) revenue,
    RANK() OVER(PARTITION BY YEAR([date]),MONTH([date])
            ORDER BY SUM(transaction_amount) DESC) ranking
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY YEAR([date]),
    MONTH([date]),
    item_name
)
SELECT *
FROM MonthlyProduct
WHERE ranking = 1;

/* 9.Product Performance Matrix */
SELECT
    item_name,
    COUNT(*) total_orders,
    SUM(quantity) total_quantity,
    SUM(transaction_amount) total_revenue,
    AVG(transaction_amount) average_order_value
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY item_name
ORDER BY total_revenue DESC;


/* 10.ABC Inventory Analysis (80/20) */
WITH ProductRevenue AS
(
SELECT
    item_name,
    SUM(transaction_amount) revenue
FROM [PortfolioSQL].[dbo].[Balaji Fast Food Sales Report]
GROUP BY item_name
),

RunningRevenue AS
(
SELECT
    *,
    SUM(revenue) OVER(ORDER BY revenue DESC) cumulative_revenue,
    SUM(revenue) OVER() total_revenue,
    ROUND(revenue * 100 /SUM(revenue) OVER (),2) AS revenue_pct
FROM ProductRevenue
)

SELECT
    item_name,
    revenue,
    revenue_pct,
    ROUND(cumulative_revenue*100/total_revenue,2) cumulative_percentage,
    CASE 
        WHEN cumulative_revenue*100.0/total_revenue<=80 THEN 'A (Top 80%)'
        WHEN cumulative_revenue*100.0/total_revenue<=95 THEN 'B (Next 15%)'
        ELSE 'C (Last 5%)'
    END AS ABC_Category
FROM RunningRevenue
ORDER BY revenue DESC;