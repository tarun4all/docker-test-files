pg_dumpall -c -U docker > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

docker run -it --rm --mount "type=bind,src=$(pwd)/shared,dst=/opt/shared" --workdir /opt/shared ubuntu bash

docker create volume <volname>

docker run --rm --mount "type=bind,src=$(pwd)/shared,dst=/app/dir" --workdir /shared nn

pg_dump -U admin amex > dbexport.pgsql

export PGPASSWORD=admin and PGPASSWORD=admin && pg_dump amex -U admin -h localhost -F c > dbexport.pgsql

export PGPASSWORD=admin and PGPASSWORD=admin && pg_restore -U admin -d amex -h localhost dbexport.pgsql
psql -U username dbname < dbexport.pgsql