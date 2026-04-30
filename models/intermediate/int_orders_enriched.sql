with orders as (

    select * from {{ ref('stg_olist__orders') }}

),

customers as (

    select * from {{ ref('stg_olist__customers') }}

),

payments as (

    select
        order_id,
        sum(payment_value) as total_payment_value,
        count(payment_sequential) as payment_count

    from {{ ref('stg_olist__payments') }}

    group by 1

),

reviews as (

    select
        order_id,
        avg(review_score) as avg_review_score

    from {{ ref('stg_olist__reviews') }}

    group by 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        customers.customer_city,
        customers.customer_state,
        orders.order_status,
        orders.ordered_at,
        orders.approved_at,
        orders.delivered_to_carrier_at,
        orders.delivered_to_customer_at,
        orders.estimated_delivery_at,
        payments.total_payment_value,
        payments.payment_count,
        reviews.avg_review_score

    from orders

    left join customers using (customer_id)
    left join payments using (order_id)
    left join reviews using (order_id)

)

select * from final