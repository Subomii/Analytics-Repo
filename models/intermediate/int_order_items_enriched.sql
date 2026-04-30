with order_items as (

    select * from {{ ref('stg_olist__order_items') }}

),

products as (

    select * from {{ ref('stg_olist__products') }}

),

product_translations as (

    select * from {{ ref('stg_olist__product_category_name_translation') }}

),

sellers as (

    select * from {{ ref('stg_olist__sellers') }}

),

final as (

    select
        order_items.order_id,
        order_items.order_item_id,
        order_items.product_id,
        order_items.seller_id,
        order_items.shipping_limit_at,
        order_items.price,
        order_items.freight_value,
        products.product_category_name,
        product_translations.product_category_name_english,
        sellers.seller_city,
        sellers.seller_state

    from order_items

    left join products using (product_id)
    left join product_translations using (product_category_name)
    left join sellers using (seller_id)

)

select * from final