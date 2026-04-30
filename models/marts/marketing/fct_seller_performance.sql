with sellers as (

    select * from {{ ref('stg_olist__sellers') }}

),

order_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

orders as (

    select * from {{ ref('fct_olist_orders') }}

),

seller_metrics as (

    select
        order_items.seller_id,
        count(distinct order_items.order_id) as total_orders,
        sum(order_items.price) as total_revenue,
        avg(orders.avg_review_score) as avg_review_score,
        avg(orders.actual_delivery_days) as avg_delivery_days,
        count(distinct order_items.product_id) as unique_products_sold

    from order_items

    left join orders using (order_id)

    group by 1

),

final as (

    select
        sellers.seller_id,
        sellers.seller_city,
        sellers.seller_state,
        seller_metrics.total_orders,
        seller_metrics.total_revenue,
        seller_metrics.avg_review_score,
        seller_metrics.avg_delivery_days,
        seller_metrics.unique_products_sold

    from sellers

    left join seller_metrics using (seller_id)

)

select * from final