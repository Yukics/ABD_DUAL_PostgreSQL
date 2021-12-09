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


--Trigger Examen
CREATE OR REPLACE FUNCTION f_insertDiv() RETURNS trigger AS $$
    BEGIN

        
        UPDATE persones SET estat = 'divorciat', num_divorciat = num_divorciat + 1 WHERE OLD.persona1=id_persona or OLD.persona2=id_persona;

		DELETE FROM casats where (OLD.persona1=casats.persona1 and OLD.persona2=casats.persona2) or (OLD.persona2=casats.persona1 and OLD.persona1=casats.persona2);

        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER t_insertDiv AFTER INSERT ON divorciats FOR EACH ROW EXECUTE PROCEDURE f_insertDiv();

INSERT INTO divorciats values(3,5,'2016-01-01', '2016-01-02');
