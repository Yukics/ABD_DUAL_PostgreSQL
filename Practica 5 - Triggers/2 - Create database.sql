-- Database creation and data insertion

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

INSERT INTO persones VALUES(1, 'Paquita', 'Salas', 1999-01-02, 'solter', 0, 0);
INSERT INTO persones VALUES(2, 'Obi', 'WAN LAN', 1998-02-03, 'solter', 0, 0);
INSERT INTO persones VALUES(3, 'Coco', 'Cabra', 1989-10-12, 'solter', 0, 0);
INSERT INTO persones VALUES(4, 'Jaime', 'Segundo', 1996-02-03, 'solter', 0, 0);
INSERT INTO persones VALUES(5, 'Juan', 'Juan', 1994-05-05, 'solter', 0, 0);
INSERT INTO persones VALUES(6, 'Robin', 'Hood', 1995-12-07, 'solter', 0, 0);
INSERT INTO persones VALUES(7, 'Rosalia', 'Tratra', 1996-11-12, 'solter', 0, 0);
INSERT INTO persones VALUES(8, 'Francisco', 'Cisco', 1992-12-18, 'solter', 0, 0);
