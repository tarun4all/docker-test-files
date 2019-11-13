FROM ubuntu
WORKDIR /app
COPY package.json /app
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
# RUN yes | apt-get install curl
# RUN curl -sL https://deb.nodesource.com/setup_10.x | -E bash -
RUN yes | apt install nodejs
RUN yes | apt install npm
RUN yes | apt-get install wget
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN yes | apt-get install -y mongodb-org
RUN npm install
COPY . /app
CMD node app.js
EXPOSE 8081