FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl gettext

ARG CERT_
ARG CERT_KEY
ARG OPENSSL
ARG DOMAIN_NAME

COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template

COPY ./tools/script_nginx.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script_nginx.sh

EXPOSE 443

ENTRYPOINT ["ash", "-f", "/usr/local/bin/script_nginx.sh"]