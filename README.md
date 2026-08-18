# SQL Business Analytics

A recruiter-facing SQL portfolio covering **joins, CTEs, window functions, cohort analysis, ranking, customer/revenue analytics, data-quality checks, query-optimisation concepts and interview-grade scenarios**.

> **Data note:** All datasets are synthetic and created for portfolio purposes.

## Business Context

The repository models a simple commercial environment with:

- customers
- products
- orders
- customer segments
- regions
- acquisition channels
- revenue

The purpose is to demonstrate that SQL can move from simple querying into **business analysis, data validation and scalable analytical thinking**.

## Repository Structure

```text
sql-business-analytics/
├── data/
│   ├── raw/
│   └── processed/
├── sql/
│   ├── 01_joins_and_aggregations.sql
│   ├── 02_ctes.sql
│   ├── 03_window_functions.sql
│   ├── 04_cohort_analysis.sql
│   ├── 05_customer_revenue_analysis.sql
│   ├── 06_data_quality_checks.sql
│   ├── 07_interview_scenarios.sql
│   └── 08_query_optimisation_examples.sql
├── docs/
└── README.md
```

## Skills Demonstrated

### Joins & Aggregations
- multi-table joins
- grouped revenue analysis
- segment/product/region reporting

### CTEs
- staged query logic
- reusable business calculations
- readable analytical SQL

### Window Functions
- `DENSE_RANK`
- `LAG`
- running totals
- regional ranking

### Cohort Analysis
- acquisition cohort
- activity month
- months since signup
- retention %

### Customer & Revenue Analytics
- lifetime revenue proxy
- average order value
- revenue concentration
- top-customer analysis

### Data Quality
- duplicate order IDs
- missing foreign keys
- orphan checks
- invalid numerical relationships
- status profiling

### Query Optimisation
- index concepts
- execution plans
- query selectivity
- avoiding unnecessary columns
- pre-aggregation / materialisation concepts

## Interview-Grade Scenarios

Included examples cover:

1. Second-highest revenue customer per region.
2. Customers with 3+ orders in a rolling 30-day window.
3. Month-over-month revenue growth.
4. Products contributing to the first 80% of revenue.
5. Revenue ranking.
6. Running totals.
7. Cohort retention.
8. Revenue concentration.

## Example Window Function

```sql
DENSE_RANK() OVER (
    PARTITION BY region
    ORDER BY revenue_gbp DESC
)
```

## Example Cohort Logic

```text
Signup Month
     +
Activity Month
     ↓
Months Since Signup
     ↓
Active Customers / Cohort Size
     ↓
Retention %
```

## Data Quality Philosophy

Analytical SQL is only valuable when the underlying data can be trusted.

The project therefore includes explicit checks for:

- duplicates
- null keys
- referential-integrity failures
- invalid revenue values
- inconsistent status values

## Query Optimisation Philosophy

The repository does **not** claim that adding an index or rewriting a query always makes it faster.

Instead, the documented process is:

```text
Understand workload
       ↓
Inspect execution plan
       ↓
Identify bottleneck
       ↓
Change query/index/model
       ↓
Measure again
```

See [`docs/query_optimisation.md`](docs/query_optimisation.md).

## Database Compatibility

The analytical SQL uses PostgreSQL-style syntax in areas such as:

- `DATE_TRUNC`
- `DATE_PART`
- `AGE`
- `INTERVAL`

Equivalent functions can be substituted for SQL Server, MySQL, BigQuery, Snowflake or other platforms.

## Interview Talking Points

1. INNER JOIN vs LEFT JOIN.
2. WHERE vs HAVING.
3. CTE vs subquery.
4. Window function vs aggregation.
5. ROW_NUMBER vs RANK vs DENSE_RANK.
6. Cohort retention.
7. Running totals.
8. Duplicate detection.
9. Referential integrity.
10. Index trade-offs.
11. Execution plans.
12. How you would optimise a slow BI query.

## Portfolio Classification

**Type:** Portfolio Build  
**Data:** Synthetic  
**Purpose:** Demonstrate advanced analytical SQL and interview readiness.
