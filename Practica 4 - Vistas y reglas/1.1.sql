CREATE ROLE admin1 WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT 10
	PASSWORD 'pass123.';