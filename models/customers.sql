WITH orders AS (
    SELECT 
        user_id,
        MIN(order_date) AS first_order,
        MAX(order_date) AS most_recent_order,
        COUNT(*) AS number_of_orders
    FROM HEVO_DB.ABC_PUBLIC.RAW_ORDERS
    GROUP BY user_id
),

payments AS (
    SELECT 
        o.user_id,
        SUM(p.amount) AS customer_lifetime_value
    FROM HEVO_DB.ABC_PUBLIC.RAW_PAYMENTS p
    JOIN HEVO_DB.ABC_PUBLIC.RAW_ORDERS o 
        ON p.order_id = o.id
    GROUP BY o.user_id
)

SELECT 
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    o.first_order,
    o.most_recent_order,
    o.number_of_orders,
    COALESCE(p.customer_lifetime_value, 0) AS customer_lifetime_value
FROM HEVO_DB.ABC_PUBLIC.RAW_CUSTOMERS c
LEFT JOIN orders o ON c.id = o.user_id
LEFT JOIN payments p ON c.id = p.user_id
