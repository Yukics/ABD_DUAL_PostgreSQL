DROP TRIGGER IF EXISTS t_insertCasats ON casats; 
DROP FUNCTION IF EXISTS f_insertCasats();

CREATE OR REPLACE FUNCTION f_insertCasats() RETURNS trigger AS $$
    BEGIN
        -- Check that is not the same person
        IF NEW.persona1 = NEW.persona2 THEN
            RAISE EXCEPTION 'No te puedes casar contigo mismo';
        END IF;

         
        UPDATE persones SET estat = 'casat', num_casat = num_casat + 1 WHERE NEW.persona1=id_persona;
        UPDATE persones SET estat = 'casat', num_casat = num_casat + 1 WHERE NEW.persona2=id_persona;

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_insertCasats BEFORE INSERT ON casats FOR EACH ROW EXECUTE PROCEDURE f_insertCasats();







CREATE TRIGGER t_deleteCasats AFTER DELETE ON casats

CREATE [ CONSTRAINT ] TRIGGER name { BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] }
    ON table
    [ FROM referenced_table_name ]
    [ NOT DEFERRABLE | [ DEFERRABLE ] { INITIALLY IMMEDIATE | INITIALLY DEFERRED } ]
    [ FOR [ EACH ] { ROW | STATEMENT } ]
    [ WHEN ( condition ) ]
    EXECUTE PROCEDURE function_name ( arguments )