
  
    



create or replace transient  table ANALYTICS.dbt_subomii.fct_orders
    
    
    
    as (with orders as (

    select * from ANALYTICS.dbt_subomii.stg_jaffle_shop_orders

),

payments as (

    select * from ANALYTICS.dbt_subomii.stg_stripe__payments

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        payments.amount

    from orders

    left join payments using (order_id)

)

select * from final
    )
;




  