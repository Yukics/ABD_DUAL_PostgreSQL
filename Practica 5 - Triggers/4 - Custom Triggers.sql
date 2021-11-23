-- Link to used database
-- https://raw.githubusercontent.com/lerocha/chinook-database/master/ChinookDatabase/DataSources/Chinook_PostgreSql.sql

-- Trigger on new song
-- Este trigger agrega a una tabla las canciones que se agregan 

DROP TRIGGER IF EXISTS t_newSong ON Track; 
DROP FUNCTION IF EXISTS f_newSong();

CREATE OR REPLACE FUNCTION f_newSong() RETURNS trigger AS $$
    BEGIN
        -- Check that the table exists
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'chinook' AND tablename = 'newSong') THEN 
            CREATE TABLE newSongs (name character varying(200) NOT NULL, insert_date date);
        END IF;

        -- If the table has 10 rows it updates the oldest or inserts a new row
        IF (SELECT COUNT(*) FROM newSong) = 10 THEN
            UPDATE UPDATE newSong SET name = OLD.Name, insert_date = CURRENT_DATE WHERE insert_date=(SELECT insert_date FROM newSong ORDER BY insert_date ASC LIMIT 1);
        ELSE
            INSERT INTO newSongs VALUES(OLD.Name, CURRENT_DATE);
        END IF;
         
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_newSong AFTER INSERT ON Track FOR EACH ROW EXECUTE PROCEDURE f_newSong();

-- Trigger on update customer
-- Este trigger hace un backup de la información de los customer 

DROP TRIGGER IF EXISTS t_bckpCustomer ON Customer; 
DROP FUNCTION IF EXISTS f_bckpCustomer();

CREATE OR REPLACE FUNCTION f_bckpCustomer() RETURNS trigger AS $$
    BEGIN
        -- Check that the table exists
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'chinook' AND tablename = 'bckpCustomer') THEN 
            CREATE TABLE bckpCustomer (
                "CustomerId" INT NOT NULL,
                "FirstName" VARCHAR(40) NOT NULL,
                "LastName" VARCHAR(20) NOT NULL,
                "Company" VARCHAR(80),
                "Address" VARCHAR(70),
                "City" VARCHAR(40),
                "State" VARCHAR(40),
                "Country" VARCHAR(40),
                "PostalCode" VARCHAR(10),
                "Phone" VARCHAR(24),
                "Fax" VARCHAR(24),
                "Email" VARCHAR(60) NOT NULL,
                "SupportRepId" INT,
                CONSTRAINT "PK_Customer" PRIMARY KEY  ("CustomerId"));
        END IF;

        -- If the table has 10 rows it updates the oldest or inserts a new row
        IF (SELECT COUNT(*) FROM newSong) = 10 THEN
            UPDATE UPDATE newSong SET name = OLD.Name, insert_date = CURRENT_DATE WHERE insert_date=(SELECT insert_date FROM newSong ORDER BY insert_date ASC LIMIT 1);
        ELSE
            INSERT INTO newSongs VALUES(OLD.Name, CURRENT_DATE);
        END IF;
         
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_bckpCustomer BEFORE UPDATE ON Customer FOR EACH ROW EXECUTE PROCEDURE f_bckpCustomer();
