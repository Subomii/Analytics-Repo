with orders as (

    select * from {{ ref('int_orders_enriched') }}

),

order_items as (

    select
        order_id,
        count(order_item_id) as item_count,
        sum(price) as items_subtotal,
        sum(freight_value) as total_freight_value

    from {{ ref('int_order_items_enriched') }}

    group by 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.customer_city,
        orders.customer_state,
        orders.order_status,
        orders.ordered_at,
        orders.approved_at,
        orders.delivered_to_carrier_at,
        orders.delivered_to_customer_at,
        orders.estimated_delivery_at,
        orders.total_payment_value,
        orders.payment_count,
        orders.avg_review_score,
        order_items.item_count,
        order_items.items_subtotal,
        order_items.total_freight_value,
        datediff('day', 
            orders.ordered_at, 
            orders.delivered_to_customer_at) as actual_delivery_days,
        datediff('day', 
            orders.ordered_at, 
            orders.estimated_delivery_at) as estimated_delivery_days

    from orders

    left join order_items using (order_id)

)

select * from final