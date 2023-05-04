SELECT 
    DISTINCT o.user_id AS "Missing user ID"
FROM 
    "order" o
WHERE 
    "o.user_id" NOT IN (
        SELECT 
            id 
        FROM 
            "user"
    );