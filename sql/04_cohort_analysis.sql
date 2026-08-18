-- 04 Cohort Analysis

-- Example monthly acquisition cohort retention
WITH customer_cohorts AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM customers
),
activity AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS activity_month
    FROM orders
    WHERE status = 'Completed'
    GROUP BY customer_id, DATE_TRUNC('month', order_date)
),
cohort_activity AS (
    SELECT
        cc.cohort_month,
        a.activity_month,
        DATE_PART(
            'month',
            AGE(a.activity_month, cc.cohort_month)
        ) AS months_since_signup,
        COUNT(DISTINCT a.customer_id) AS active_customers
    FROM customer_cohorts cc
    JOIN activity a
      ON cc.customer_id = a.customer_id
    GROUP BY cc.cohort_month, a.activity_month
),
cohort_size AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_customers
    FROM customer_cohorts
    GROUP BY cohort_month
)
SELECT
    ca.cohort_month,
    ca.months_since_signup,
    ca.active_customers,
    cs.cohort_customers,
    ROUND(
        100.0 * ca.active_customers / NULLIF(cs.cohort_customers,0),
        2
    ) AS retention_pct
FROM cohort_activity ca
JOIN cohort_size cs USING (cohort_month)
ORDER BY ca.cohort_month, ca.months_since_signup;
