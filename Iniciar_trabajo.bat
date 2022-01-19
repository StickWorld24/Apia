D:
git pull
pg_restore -h 127.0.0.1 -p 5432 -U postgres -d ApiaSW ApiaSW.dump
echo "exito"