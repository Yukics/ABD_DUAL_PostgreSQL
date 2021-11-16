-- Creamos una vista

CREATE VIEW v_lastTenOrders AS
SELECT order_id, customer_id, ship_name FROM public.orders
ORDER BY order_date DESC LIMIT 10

-- Creamos la regla UPDATE

CREATE RULE r_updateLastOrders AS ON UPDATE TO public.v_lastTenOrders
    DO INSTEAD
    UPDATE public.v_lastTenOrders
       SET order_id = NEW.order_id,
           customer_id = NEW.customer_id,
           ship_name = NEW.ship_name,
     WHERE order_id = OLD.order_id;

UPDATE public.v_lastTenOrders
SET order_id = 11068,
    customer_id = 'CABRA',
   	ship_name = 'Leche de cococabra'
WHERE order_id = 11068;

-- Creamos la regla INSERT

CREATE RULE r_insertLastOrders AS ON INSERT TO public.v_lastTenOrders
    DO INSTEAD
    INSERT INTO public.v_lastTenOrders VALUES (
        NEW.order_id,
        NEW.customer_id,
        NEW.ship_name
    );

INSERT INTO public.v_lastTenOrders VALUES (
        12000,
        'CABRA',
        'Leche de Cocoacabra'
    );