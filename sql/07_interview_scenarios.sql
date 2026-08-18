-- 07 Interview-Grade SQL Scenarios

-- Q1: Second-highest revenue customer per region
WITH customer_revenue AS (
    SELECT
        c.region,
        c.customer_id,
        SUM(o.net_revenue_gbp) AS revenue_gbp
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status='Completed'
    GROUP BY c.region, c.customer_id
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY region
            ORDER BY revenue_gbp DESC
        ) AS rnk
    FROM customer_revenue
)
SELECT *
FROM ranked
WHERE rnk = 2;

-- Q2: Customers with 3+ completed orders in any rolling 30-day window
SELECT DISTINCT o1.customer_id
FROM orders o1
JOIN orders o2
  ON o1.customer_id = o2.customer_id
 AND o2.order_date BETWEEN o1.order_date AND o1.order_date + INTERVAL '30 days'
WHERE o1.status='Completed'
  AND o2.status='Completed'
GROUP BY o1.customer_id, o1.order_date
HAVING COUNT(DISTINCT o2.order_id) >= 3;

-- Q3: Month-over-month revenue growth
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(net_revenue_gbp) AS revenue_gbp
    FROM orders
    WHERE status='Completed'
    GROUP BY 1
),
lagged AS (
    SELECT
        month,
        revenue_gbp,
        LAG(revenue_gbp) OVER (ORDER BY month) AS prev_month
    FROM monthly
)
SELECT
    month,
    revenue_gbp,
    prev_month,
    ROUND(
      100.0 * (revenue_gbp - prev_month)
      / NULLIF(prev_month,0),
      2
    ) AS mom_growth_pct
FROM lagged
ORDER BY month;

-- Q4: Products contributing to first 80% of revenue
WITH product_rev AS (
    SELECT
        p.product_id,
        p.category,
        SUM(o.net_revenue_gbp) AS revenue_gbp
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE o.status='Completed'
    GROUP BY p.product_id, p.category
),
ranked AS (
    SELECT *,
        SUM(revenue_gbp) OVER (ORDER BY revenue_gbp DESC) AS running_revenue,
        SUM(revenue_gbp) OVER () AS total_revenue
    FROM product_rev
)
SELECT *
FROM ranked
WHERE running_revenue / NULLIF(total_revenue,0) <= 0.80
ORDER BY revenue_gbp DESC;
