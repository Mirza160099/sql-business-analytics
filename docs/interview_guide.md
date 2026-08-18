# SQL Interview Guide

## Core Topics

### Joins
Know:
- INNER
- LEFT
- RIGHT
- FULL
- CROSS
- self joins

Be able to explain row multiplication.

### Aggregations
Understand:
- `GROUP BY`
- `HAVING`
- distinct counts
- conditional aggregation

### CTEs
Use CTEs for readability and logical staging. A CTE does not automatically imply better performance.

### Window Functions
Practice:
- `ROW_NUMBER`
- `RANK`
- `DENSE_RANK`
- `LAG`
- `LEAD`
- running totals
- partitioned averages

### Cohort Analysis
Understand:
- cohort definition
- cohort month
- activity month
- months since acquisition
- retention %

### Data Quality
Expect questions on:
- duplicates
- nulls
- referential integrity
- invalid ranges
- inconsistent categories

### Optimisation
Explain:
- execution plan
- indexes
- selectivity
- scan vs seek
- partitioning
- materialisation
- why performance must be measured
