/etc/init.d/postgresql start

CREATE TABLE student ( name varchar(50) );
INSERT INTO student VALUES ('Tarun Bansal');
select * from student;

--mount source=testvol,destination=/var/lib/postgresql/10/main