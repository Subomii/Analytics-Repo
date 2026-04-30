with orders as (

    select * from {{ ref('fct_olist_orders') }}

),

final as (

    select
        customer_state,
        count(order_id) as total_orders,
        avg(actual_delivery_days) as avg_actual_delivery_days,
        avg(estimated_delivery_days) as avg_estimated_delivery_days,
        avg(actual_delivery_days - estimated_delivery_days) as avg_delay_days,
        sum(case when actual_delivery_days > estimated_delivery_days 
            then 1 else 0 end) as late_orders,
        sum(case when actual_delivery_days <= estimated_delivery_days 
            then 1 else 0 end) as on_time_orders,
        round(sum(case when actual_delivery_days > estimated_delivery_days 
            then 1 else 0 end) * 100.0 / count(order_id), 2) as late_order_pct

    from orders

    where delivered_to_customer_at is not null

    group by 1

)

select * from final