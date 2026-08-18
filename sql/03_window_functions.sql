-- 03 Window Functions

-- Rank customers by revenue within region
WITH customer_revenue AS (
    SELECT
        c.region,
        c.customer_id,
        SUM(o.net_revenue_gbp) AS revenue_gbp
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.region, c.customer_id
)
SELECT
    region,
    customer_id,
    revenue_gbp,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY revenue_gbp DESC
    ) AS revenue_rank_in_region
FROM customer_revenue;

-- Running monthly revenue
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(net_revenue_gbp) AS revenue_gbp
    FROM orders
    WHERE status = 'Completed'
    GROUP BY 1
)
SELECT
    month,
    revenue_gbp,
    SUM(revenue_gbp) OVER (
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue_gbp,
    LAG(revenue_gbp) OVER (ORDER BY month) AS previous_month_revenue_gbp
FROM monthly_revenue
ORDER BY month;
