select company_name, contact_name, phone, city, country from customers 
where country in ('Spain', 'Argentina') and city != 'Barcelona'