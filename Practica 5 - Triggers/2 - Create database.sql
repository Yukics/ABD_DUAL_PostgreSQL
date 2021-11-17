
CREATE TABLE persones (
    id_persona int NOT NULL,
    nom character varying(15) NOT NULL,
    cognom character varying(15) NOT NULL,
    data_naixement date,
    estat estat_civil NOT NULL,
    num_casat int NOT NULL,
    num_divorciat int NOT NULL
);

CREATE TABLE casats (
    persona1 int NOT NULL,
    persona2 int NOT NULL,
    data_casament date NOT NULL
);

CREATE TABLE divorciats (
    persona1 int NOT NULL,
    persona2 int NOT NULL,
    data_divorci date NOT NULL
);

