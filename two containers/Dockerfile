FROM ubuntu
WORKDIR /app
COPY package.json /app
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN yes | apt install nodejs
RUN yes | apt install npm
RUN yes | apt-get install groovy
RUN npm install
COPY . /app
RUN groovy groovyTest.groovy
CMD node server.js
EXPOSE 4000