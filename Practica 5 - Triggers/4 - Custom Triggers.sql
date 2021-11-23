-- Link to used database
-- https://raw.githubusercontent.com/lerocha/chinook-database/master/ChinookDatabase/DataSources/Chinook_PostgreSql.sql

-- Trigger on new song
-- Este trigger agrega a una tabla las canciones que se agregan 

DROP TRIGGER IF EXISTS t_newSong ON Track; 
DROP FUNCTION IF EXISTS f_newSong();

CREATE OR REPLACE FUNCTION f_newSong() RETURNS trigger AS $$
    BEGIN
        -- Check that the table exists
        CREATE TABLE IF NOT EXISTS "newSongs" ("Name" character varying(200) NOT NULL, insert_date timestamp);

        -- If the table has 10 rows it updates the oldest or inserts a new row
        IF (SELECT COUNT(*) FROM "newSongs") = 10 THEN
            UPDATE "newSongs" SET "Name" = NEW."Name", insert_date = CURRENT_TIMESTAMP WHERE insert_date=(SELECT insert_date FROM "newSongs" ORDER BY insert_date ASC LIMIT 1);
        ELSE
            INSERT INTO "newSongs" VALUES(NEW."Name", CURRENT_TIMESTAMP);
        END IF;
         
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_newSong BEFORE INSERT ON "Track" FOR EACH ROW EXECUTE PROCEDURE f_newSong();

-- TEST
INSERT INTO "Track" VALUES(3600, 'Cococabra', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3601, 'Ave maria cuando seras mia', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3602, 'Caja de zapatos', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3603, 'Autismo', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3604, 'AHHHHHH', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3605, 'Sisoy', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3606, 'Maburro', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3607, 'Y la culpa no era mía', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3608, 'Tengo una vaca lechera', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3609, 'Alexa play despacito', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3610, 'AHHHHHHHHHHHHH en do mayor', 347,2,24,NULL,3214543, 9879432, '0.99');
INSERT INTO "Track" VALUES(3611, 'Funca o no funca', 347,2,24,NULL,3214543, 9879432, '0.99');

DELETE FROM "Track" WHERE "TrackId"=3600;
DELETE FROM "Track" WHERE "TrackId"=3601;
DELETE FROM "Track" WHERE "TrackId"=3602;
DELETE FROM "Track" WHERE "TrackId"=3603;
DELETE FROM "Track" WHERE "TrackId"=3604;
DELETE FROM "Track" WHERE "TrackId"=3605;
DELETE FROM "Track" WHERE "TrackId"=3606;
DELETE FROM "Track" WHERE "TrackId"=3607;
DELETE FROM "Track" WHERE "TrackId"=3608;
DELETE FROM "Track" WHERE "TrackId"=3609;
DELETE FROM "Track" WHERE "TrackId"=3610;
DELETE FROM "Track" WHERE "TrackId"=3611;

-- Trigger on update customer
-- Este trigger hace un backup de la información de los customer 

DROP TRIGGER IF EXISTS t_bckpCustomer ON Customer; 
DROP FUNCTION IF EXISTS f_bckpCustomer();

CREATE OR REPLACE FUNCTION f_bckpCustomer() RETURNS trigger AS $$
    BEGIN
        -- Check that the table exists
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'chinook' AND tablename = 'bckpCustomer') THEN 
            CREATE TABLE bckpCustomer (
                "Id" SERIAL PRIMARY KEY,
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
                "SupportRepId" INT);
        END IF;

        -- Inserts a new entry to backup table autoincremental Id
        INSERT INTO bckpCustomer VALUES (
                DEFAULT,
                OLD.CustomerId,
                OLD.FirstName,
                OLD.LastName,
                OLD.Company,
                OLD.Address,
                OLD.City,
                OLD.State,
                OLD.Country,
                OLD.PostalCode,
                OLD.Phone,
                OLD.Fax,
                OLD.Email,
                OLD.SupportRepId
            );
         
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_bckpCustomer BEFORE UPDATE OR DELETE ON Customer FOR EACH ROW EXECUTE PROCEDURE f_bckpCustomer();
