# Query Optimisation Concepts

This repository demonstrates **query optimisation thinking**, not claims of benchmarked production performance.

## Areas to review

### 1. Execution Plans
Use `EXPLAIN` / `EXPLAIN ANALYZE` to inspect:
- table scans
- index usage
- join strategy
- row estimates
- sort operations

### 2. Indexing
Candidate indexes should be driven by actual query patterns.

Possible examples:
- `(customer_id, order_date)`
- `(status, order_date)`
- `product_id`

Indexes improve reads but increase:
- storage
- write cost
- maintenance

### 3. Filter Early
Reduce unnecessary rows before expensive joins/aggregations when the optimiser cannot already do so efficiently.

### 4. Select Only Needed Columns
Avoid unnecessary `SELECT *` in operational queries.

### 5. Data Types
Use appropriate types and avoid functions/casts on indexed columns where they prevent efficient access paths.

### 6. Pre-Aggregation
For very large BI workloads, consider:
- summary tables
- materialized views
- incremental models
- partitioning

### 7. Validate
Do not assume a rewrite is faster. Measure it.
