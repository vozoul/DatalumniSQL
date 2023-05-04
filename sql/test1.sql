SELECT 
    u.id, u.first_name || ' ' || u.last_name as "full_name", o.id,
    CASE 
        WHEN o.order_delivered IS NOT NULL THEN 'Delivered'
        WHEN o.order_shipped IS NOT NULL THEN 'Shipped'
        WHEN o.order_prepared IS NOT NULL THEN 'Prepared'
        WHEN o.payment_received IS NOT NULL THEN 'Paid'
        ELSE 'Received'
    END
		AS "status"
FROM 
    "user" u
    JOIN "order" o
		ON u.id = o.user_id
WHERE 
    o.id BETWEEN 1337 AND 1500
ORDER BY 
    u.last_name DESC;