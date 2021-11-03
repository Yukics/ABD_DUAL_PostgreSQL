root@1188227283ff:/var/lib/postgresql/data# echo "local all miriam password" >> pg_hba.conf

ALTER ROLE "miriam" WITH LOGIN;

10)
psql -U miriam

11)
psql -U miriam postgres