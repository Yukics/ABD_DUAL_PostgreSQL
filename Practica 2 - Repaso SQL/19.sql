SELECT DISTINCT c.customer_id, c.company_name, c.contact_name FROM customers AS c 
INNER JOIN (SELECT * FROM orders WHERE order_date >= '1997-01-01' OR order_date < '1996-01-01') AS o
ON o.customer_id=c.customer_id

-- Segundo intento
SELECT DISTINCT c.customer_id, c.contact_name, c.company_name FROM customers AS c
INNER JOIN (SELECT * FROM orders WHERE order_date >= '1996-01-01' AND order_date < '1997-01-01') AS o
ON c.customer_id!=o.customer_id
