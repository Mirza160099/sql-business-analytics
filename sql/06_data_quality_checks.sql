-- 06 Data Quality Checks

-- Duplicate orders
SELECT order_id, COUNT(*) AS row_count
FROM orders_with_quality_issues
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Missing foreign keys
SELECT COUNT(*) AS missing_customer_id_rows
FROM orders_with_quality_issues
WHERE customer_id IS NULL;

-- Orphan customer references
SELECT COUNT(*) AS orphan_orders
FROM orders_with_quality_issues o
LEFT JOIN customers c
  ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Invalid revenue values
SELECT *
FROM orders_with_quality_issues
WHERE net_revenue_gbp < 0
   OR gross_revenue_gbp < 0
   OR net_revenue_gbp > gross_revenue_gbp;

-- Status distribution for anomaly review
SELECT status, COUNT(*) AS rows
FROM orders_with_quality_issues
GROUP BY status;
