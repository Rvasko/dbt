with orders as (
  select * from {{ ref('stg_US_orders_from_raw_orders') }}
  ORDER BY CUSTOMER_KEY
),

customer_orders as (

    select
        CUSTOMER_KEY,

        min(DATE_ORDERED) as first_order_date,
        max(DATE_ORDERED) as most_recent_order_date,
        count(ORDER_KEY) as number_of_orders,
        sum(EXTENDED_PRICE) as TOTAL_SPENT

    from orders

    group by 1

),

final as (

    select
        DISTINCT orders.CUSTOMER_KEY,
        customer_orders.TOTAL_SPENT,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from orders

    left join customer_orders using (customer_key)

)

select * from final
