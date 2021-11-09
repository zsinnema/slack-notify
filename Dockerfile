FROM debian:buster-slim

RUN apt-get update && apt-get install -y ca-certificates software-properties-common curl gnupg
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN add-apt-repository 'deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main'
RUN apt-get update
RUN apt-get install -y mongodb-org-shell

COPY scripts /

RUN chmod +x /*.sh

CMD /notify.sh
