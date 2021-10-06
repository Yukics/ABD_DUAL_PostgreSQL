--Hecho así para seguir con la convención previamente usada

--Creación Tabla
CREATE TABLE countries (
    country_id int NOT NULL,
    country_name character varying(15) NOT NULL,
    region_id int NOT NULL
);

--Agregación PK
ALTER TABLE ONLY countries
    ADD CONSTRAINT pk_countries PRIMARY KEY (country_id);


--Agregación FK
ALTER TABLE ONLY countries
    ADD CONSTRAINT fk_countries_regions FOREIGN KEY (region_id) REFERENCES region;
