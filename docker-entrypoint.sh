_term() { 
  echo "Caught SIGTERM signal!" 
  echo "test123" > /dir/abc.txt
  cd /dir
  pg_dumpall > export.pgsql
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

echo "Doing some initial work...";
/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf

child=$! 
wait "$child"