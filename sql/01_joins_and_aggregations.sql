-- 01 Joins and Aggregations

-- Revenue by customer segment
SELECT
    c.segment,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT c.customer_id) AS customers,
    ROUND(SUM(o.net_revenue_gbp),2) AS revenue_gbp
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE o.status = 'Completed'
GROUP BY c.segment
ORDER BY revenue_gbp DESC;

-- Revenue by product category and region
SELECT
    c.region,
    p.category,
    ROUND(SUM(o.net_revenue_gbp),2) AS revenue_gbp
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY c.region, p.category
ORDER BY c.region, revenue_gbp DESC;
