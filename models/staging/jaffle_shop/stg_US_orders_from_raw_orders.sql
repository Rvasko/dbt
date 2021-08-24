with raw_orders_US as (

    select
        ORDERKEY AS ORDER_KEY,
        CUSTOMERKEY as CUSTOMER_KEY,
        QUANTITY,
        EXTENDEDPRICE as EXTENDED_PRICE,
        TRIM(CLERK, 'Clerk#0') AS CLERK_NUMBER,
        COMMITDATE AS DATE_ORDERED,
        SHIPDATE AS DATE_SHIPPED

    from {{ source('DV_PROTOTYPE_DB', 'raw_orders')}}
    WHERE CUSTOMER_NATION_NAME = 'UNITED STATES'
)

Select * from raw_orders_US
