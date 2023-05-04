-- j'ai le retour d'une erreur "no such column: cte_revenue_2019.revenue2019"
-- la colonne étant effectivement déclaré, je soupconne mon outils (mise à jour surement nécessaire)
-- je laisse le travail en l'état afin d'en rediscuter ultérierement
WITH
	cte_revenue_2018 AS (
		SELECT
			o.user_id,
			SUM(ol.quantity * ol.unit_price) AS revenue2018
		FROM
			"order" o
			JOIN "order_line" ol ON o.id = ol.order_id
		WHERE
			strftime('%Y', o.payment_received) = '2018'
		GROUP BY
			o.user_id),
	cte_revenue_2019 AS (
		SELECT
			o.user_id,
			SUM(ol.quantity * ol.unit_price) AS revenue2019
		FROM
			"order" o
			JOIN "order_line" ol ON o.id = ol.order_id
		WHERE
			strftime('%Y', o.payment_received) = '2019'
		GROUP BY
			o.user_id)
SELECT
	u.id AS "User ID",
	u.first_name || ' ' || u.last_name AS "Full name",
	RANK() OVER (ORDER BY cte_revenue_2018.revenue2018 DESC) AS "Rank 2018",
	RANK() OVER (ORDER BY cte_revenue_2019.revenue2019 DESC) AS "Rank 2019"
FROM
	cte_revenue_2018
	JOIN "user" u ON cte_revenue_2018.user_id = u.id
WHERE
	RANK() OVER (ORDER BY cte_revenue_2018.revenue2018 DESC) <= 10
ORDER BY
	cte_revenue_2018.revenue2018 DESC;