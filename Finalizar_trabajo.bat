D:
pg_dump -Fc -h 127.0.0.1 -p 5432 -U postgres ApiaSW > ApiaSW.dump
postgres
git add ApiaSW.dump
git commit -m "updateDB"
git push
sleep(10)
exit