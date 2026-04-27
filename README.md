# Jaffle Shop — dbt Fundamentals Practice Project

A practice project built while completing the dbt Fundamentals course. 

## What I built
- Staging models for customers, orders, and payments
- A `dim_customers` mart with order history and lifetime value
- A `fct_orders` mart joining orders and payments

## Stack
Snowflake · dbt Cloud

## Key concepts practiced
- Staging → marts layer structure
- ref() and dependency management
- View vs table materializations
- CTE-based modeling patterns
- Debugging data quality issues (filtered failed payments to get correct lifetime value)
