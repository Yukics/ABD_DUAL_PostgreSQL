echo "host all all all password" >> pg_hba.conf

psql=> ALTER ROLE "client1" WITH PASSWORD 'password';

postgresql.conf

listen_address="localhost">listen_address="*" 