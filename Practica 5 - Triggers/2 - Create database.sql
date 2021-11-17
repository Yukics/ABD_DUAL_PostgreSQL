
CREATE TABLE persones (
    id_persona int NOT NULL,
    nom character varying(15) NOT NULL,
    cognom character varying(15) NOT NULL,
    data_naixement date,
    estat estat_civil NOT NULL,
    num_casat int NOT NULL,
    num_divorciat int NOT NULL,
    PRIMARY KEY(id_persona)
);

CREATE TABLE casats (
    persona1 int NOT NULL,
    persona2 int NOT NULL,
    data_casament date NOT NULL,
    PRIMARY KEY(persona1, persona2),
    CONSTRAINT fk_persona1_casats FOREIGN KEY(persona1) REFERENCES persones(id_persona),
    CONSTRAINT fk_persona2_casats FOREIGN KEY(persona2) REFERENCES persones(id_persona)
);

CREATE TABLE divorciats (
    persona1 int NOT NULL,
    persona2 int NOT NULL,
    data_divorci date NOT NULL,
    PRIMARY KEY(persona1, persona2),
    CONSTRAINT fk_persona1_divorciats FOREIGN KEY(persona1) REFERENCES persones(id_persona),
    CONSTRAINT fk_persona2_divorciats FOREIGN KEY(persona2) REFERENCES persones(id_persona)
);

