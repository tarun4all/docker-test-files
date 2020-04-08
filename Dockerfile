FROM ubuntu:16.04
# WORKDIR /app
# COPY package.json /app
# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# RUN apt-get update
# # RUN yes | apt-get install curl
# # RUN curl -sL https://deb.nodesource.com/setup_10.x | -E bash -
# RUN yes | apt install nodejs
# RUN yes | apt install npm
# # RUN yes | apt-get install wget
# # RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
# # RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
# # RUN apt-get update
# # RUN yes | apt-get install -y mongodb-org
# RUN npm install

# RUN yes | apt install postgresql postgresql-contrib
# USER postgres

# # Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# # then create a database `docker` owned by the ``docker`` role.
# # Note: here we use ``&&\`` to run commands one after the other - the ``\``
# #       allows the RUN command to span multiple lines.
# RUN  /etc/init.d/postgresql start &&\
#     psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
#     createdb -O docker docker

# COPY . /app

# # RUN chmod -R a+X serverstart.sh
# # RUN chmod -R 777 serverstart.sh
# # Add VOLUMEs to allow backup of config, logs and databases
# VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
# CMD node app.js
# EXPOSE 5433

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER admin WITH SUPERUSER PASSWORD 'admin';" &&\
    createdb -O admin amex

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

COPY . /app

# RUN chmod +x ./docker-entrypoint.sh
RUN ls
# RUN ["chmod", "+x", "app/docker-entrypoint.sh"] 
ENTRYPOINT ["bash", "docker-entrypoint.sh"]

# Set the default command to run when starting the container
# CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]