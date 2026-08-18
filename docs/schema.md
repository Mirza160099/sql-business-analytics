# Relational Schema

```text
Customers
---------
customer_id PK
signup_date
region
segment
acquisition_channel

Products
--------
product_id PK
category
unit_price_gbp
active_flag

Orders
------
order_id PK
customer_id FK -> Customers
product_id FK -> Products
order_date
quantity
discount_pct
gross_revenue_gbp
net_revenue_gbp
status
```

## Grain

The `orders` table is one synthetic order record per row.

## Relationships

- One customer -> many orders
- One product -> many orders
