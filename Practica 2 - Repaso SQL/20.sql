SELECT o.product_id, p.product_name, sum((o.unit_price * o.quantity)*(1-o.discount)) AS Total 
FROM order_details as o
INNER JOIN products AS p
ON p.product_id=o.product_id
GROUP BY o.product_id, p.product_name ORDER BY Total DESC LIMIT 1