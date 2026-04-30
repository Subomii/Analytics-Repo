with customers as (

    select * from {{ ref('stg_olist__customers') }}

),

customer_orders as (

    select
        customer_id,
        count(order_id) as total_orders,
        sum(total_payment_value) as lifetime_value,
        avg(avg_review_score) as avg_review_score,
        min(ordered_at) as first_order_at,
        max(ordered_at) as most_recent_order_at,
        avg(actual_delivery_days) as avg_delivery_days

    from {{ ref('fct_olist_orders') }}

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.customer_unique_id,
        customers.customer_city,
        customers.customer_state,
        customers.customer_zip_code_prefix,
        customer_orders.total_orders,
        customer_orders.lifetime_value,
        customer_orders.avg_review_score,
        customer_orders.first_order_at,
        customer_orders.most_recent_order_at,
        customer_orders.avg_delivery_days

    from customers

    left join customer_orders using (customer_id)

)

select * from final