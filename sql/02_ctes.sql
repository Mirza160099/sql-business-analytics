-- 02 Common Table Expressions

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(net_revenue_gbp) AS lifetime_revenue_gbp,
        COUNT(DISTINCT order_id) AS completed_orders
    FROM orders
    WHERE status = 'Completed'
    GROUP BY customer_id
),
customer_summary AS (
    SELECT
        c.customer_id,
        c.segment,
        c.region,
        cr.lifetime_revenue_gbp,
        cr.completed_orders
    FROM customers c
    LEFT JOIN customer_revenue cr
      ON c.customer_id = cr.customer_id
)
SELECT *
FROM customer_summary
WHERE lifetime_revenue_gbp > 5000
ORDER BY lifetime_revenue_gbp DESC;
