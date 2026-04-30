with products as (

    select * from {{ ref('stg_olist__products') }}

),

product_translations as (

    select * from {{ ref('stg_olist__product_category_name_translation') }}

),

order_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

product_metrics as (

    select
        product_id,
        count(distinct order_id) as total_orders,
        sum(price) as total_revenue,
        avg(price) as avg_price,
        sum(freight_value) as total_freight_value

    from order_items

    group by 1

),

final as (

    select
        products.product_id,
        products.product_category_name,
        product_translations.product_category_name_english,
        products.product_weight_g,
        products.product_length_cm,
        products.product_height_cm,
        products.product_width_cm,
        product_metrics.total_orders,
        product_metrics.total_revenue,
        product_metrics.avg_price,
        product_metrics.total_freight_value

    from products

    left join product_translations using (product_category_name)
    left join product_metrics using (product_id)

)

select * from final