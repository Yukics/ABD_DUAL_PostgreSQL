-- Trigger on insert
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

-- Trigger on delete
DROP TRIGGER IF EXISTS t_deleteCasats ON casats; 
DROP FUNCTION IF EXISTS f_deleteCasats();

CREATE OR REPLACE FUNCTION f_deleteCasats() RETURNS trigger AS $$
    BEGIN
         
        UPDATE persones SET estat = 'divorciat', num_divorciat = num_divorciat + 1 WHERE OLD.persona1=id_persona;
        UPDATE persones SET estat = 'divorciat', num_divorciat = num_divorciat + 1 WHERE OLD.persona2=id_persona;
        INSERT INTO divorciats VALUES(OLD.persona1,OLD.persona2,OLD.data_casament, CURRENT_DATE);

        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_deleteCasats AFTER DELETE ON casats FOR EACH ROW EXECUTE PROCEDURE f_deleteCasats();