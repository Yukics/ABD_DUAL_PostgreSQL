
-- Primer intento, SPOILER no funciONa
SELECT DISTINCT o.customer_id FROM (SELECT DISTINCT customer_id FROM orders AS o WHERE order_date < '1997-01-01') AS o 
right outer join (SELECT DISTINCT customer_id FROM orders WHERE order_date >= '1997-01-01') AS c
ON o.customer_id=c.customer_id 

-- Segundo intento, funciONa como debe
SELECT DISTINCT c.customer_id, c.contact_name 
FROM (SELECT customer_id, count(order_id) AS xcount FROM orders GROUP BY customer_id) AS x
INNER JOIN (SELECT o.customer_id, count(o.order_id) AS ycount FROM orders AS o WHERE o.order_date < '1997-01-01' 
			GROUP BY o.customer_id) AS y
ON x.xcount=y.ycount 
INNER JOIN customers AS c
ON c.customer_id=x.customer_id;