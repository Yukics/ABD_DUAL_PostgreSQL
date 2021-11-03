root@1188227283ff:/var/lib/postgresql/data# echo "host all miriam 127.0.0.1/32 password" >> pg_hba.conf

ALTER ROLE "miriam" WITH LOGIN;

10)
psql -U miriam

11)
psql -U miriam postgres