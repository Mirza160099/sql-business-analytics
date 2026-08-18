-- 08 Query Optimisation Concepts
-- Syntax may vary by database engine.

-- Example index candidates
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

CREATE INDEX idx_orders_status_date
ON orders(status, order_date);

CREATE INDEX idx_orders_product
ON orders(product_id);

-- Prefer selective filtering early when it reduces scanned rows.
SELECT
    customer_id,
    SUM(net_revenue_gbp) AS revenue_gbp
FROM orders
WHERE status = 'Completed'
  AND order_date >= DATE '2026-01-01'
GROUP BY customer_id;

-- Avoid SELECT * when only a few columns are needed.
SELECT order_id, customer_id, order_date, net_revenue_gbp
FROM orders
WHERE status = 'Completed';

-- Use EXPLAIN / EXPLAIN ANALYZE in the target database to validate
-- execution plans rather than assuming an index will always help.
