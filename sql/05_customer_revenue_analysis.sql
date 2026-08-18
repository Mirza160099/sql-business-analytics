-- 05 Customer & Revenue Analysis

-- Customer lifetime value proxy
SELECT
    c.customer_id,
    c.segment,
    c.region,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(o.net_revenue_gbp),2) AS lifetime_revenue_gbp,
    ROUND(AVG(o.net_revenue_gbp),2) AS avg_order_value_gbp
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
 AND o.status = 'Completed'
GROUP BY c.customer_id, c.segment, c.region
ORDER BY lifetime_revenue_gbp DESC;

-- Revenue concentration (top 10% customers)
WITH customer_rev AS (
    SELECT customer_id, SUM(net_revenue_gbp) AS revenue_gbp
    FROM orders
    WHERE status='Completed'
    GROUP BY customer_id
),
ranked AS (
    SELECT
        customer_id,
        revenue_gbp,
        PERCENT_RANK() OVER (ORDER BY revenue_gbp DESC) AS pct_rank
    FROM customer_rev
)
SELECT
    ROUND(SUM(CASE WHEN pct_rank <= 0.10 THEN revenue_gbp ELSE 0 END),2) AS top_10pct_revenue,
    ROUND(SUM(revenue_gbp),2) AS total_revenue,
    ROUND(
      100.0 * SUM(CASE WHEN pct_rank <= 0.10 THEN revenue_gbp ELSE 0 END)
      / NULLIF(SUM(revenue_gbp),0),
      2
    ) AS top_10pct_revenue_share_pct
FROM ranked;
