-- Link to used database
-- https://raw.githubusercontent.com/lerocha/chinook-database/master/ChinookDatabase/DataSources/Chinook_PostgreSql.sql

-- Trigger on new song
-- Este trigger agrega a una tabla las canciones que se agregan 

DROP TRIGGER IF EXISTS t_newSong ON Track; 
DROP FUNCTION IF EXISTS f_newSong();

CREATE OR REPLACE FUNCTION f_newSong() RETURNS trigger AS $$
    BEGIN
        -- Check that is not the same person
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'chinook' AND tablename = 'newSong') THEN 
            CREATE TABLE newSongs (Name character varying(200) NOT NULL);
        END IF;
    
        INSERT INTO newSongs VALUES(OLD.Name, CURRENT_DATE);
         
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_newSong AFTER INSERT ON Track FOR EACH ROW EXECUTE PROCEDURE f_newSong();
