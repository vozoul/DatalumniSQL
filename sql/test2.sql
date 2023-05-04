-- Je  ne trouve aucun résultat et je ne trouve pas l'erreur
-- je laisse le travail en l'état afin d'en rediscuter ultérierement
SELECT 
    strftime('%Y', "order.order_received") AS "Year",
    COUNT(DISTINCT "order.id") AS "Order count",
    COUNT("order_line.id") AS "Line count"
FROM 
    "order"
INNER JOIN 
   "order_line" ON "order_line.order_id" = "order.id"
WHERE 
    "year" BETWEEN '2010' AND '2020'
GROUP BY 
    "year"
ORDER BY 
    "year" ASC;