UPDATE customers SET contain_s = True WHERE upper(contact_name) LIKE '%S%';
SELECT contact_name, contain_s FROM customers;