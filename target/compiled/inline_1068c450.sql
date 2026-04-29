with customers as (

    select * from ANALYTICS.dbt_subomii.stg_jaffle_shop__customers

),

orders as (

select * from ANALYTICS.dbt_subomii.stg_jaffle_shop_orders

),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

)
SELECT * FROM CUSTOMER_ORDERS