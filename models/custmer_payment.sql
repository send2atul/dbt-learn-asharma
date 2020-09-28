{{ config(materialized='table') }}

with customers as (

select * from {{ ref('stg_customers') }}

),

orders as (

select * from {{ ref('orders') }}

),


final as (

    select
        customers.customer_id,
        sum(orders.amount)

    from customers
	  
    left join orders using (customer_id)

group by customer_id
)

select * from final