SELECT customer_id, count(order_id) as "Total" FROM orders GROUP BY customer_id ORDER BY "Total" DESC LIMIT 1;

SELECT c.customer_id, c.company_name, c.contact_name FROM customers as c
INNER JOIN 
    (SELECT customer_id, count(order_id) FROM orders GROUP BY customer_id ORDER BY "Total" DESC LIMIT 1) as maxcliente
ON c.customer_id = maxcliente.customer_id;