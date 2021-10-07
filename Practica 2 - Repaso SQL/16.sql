SELECT o.order_id, o.ship_name AS "Nombre empresa", e.last_name FROM orders AS o 
INNER JOIN employees AS e
ON e.employee_id=o.employee_id
WHERE order_date > '1995-01-01' AND order_date < '1998-01-01'