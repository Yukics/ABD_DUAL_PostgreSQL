SELECT p.product_name, o.quantity FROM order_details AS o
INNER JOIN (SELECT * FROM products WHERE units_on_order < 200) AS p
ON p.product_id=o.product_id

-- Segunda ainterpretación
SELECT p.product_name, sum(o.quantity) FROM order_details AS o
INNER JOIN (SELECT * FROM products WHERE units_on_order < 200) AS p
ON p.product_id=o.product_id
GROUP BY p.product_name
