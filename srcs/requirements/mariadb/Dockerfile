FROM alpine:3.18

ARG MYSQL_USER
ARG MYSQL_USER_PASSWORD
ARG MYSQL_NAME
ARG MYSQL_ROOT
ARG MYSQL_ROOT_PASSWORD

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/script_mariadb.sh /usr/local/bin/script_mariadb.sh

RUN chmod +x /usr/local/bin/script_mariadb.sh && ash -f /usr/local/bin/script_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["mariadbd-safe"]