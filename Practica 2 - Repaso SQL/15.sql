SELECT company_name, contact_name, phone, city, country FROM customers 
WHERE country IN ('Spain', 'Argentina') AND city != 'Barcelona'