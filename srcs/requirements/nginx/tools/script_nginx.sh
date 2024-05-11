#!/bin/ash

openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout $CERT_KEY -out $CERT_ -subj "$OPENSSL"

envsubst '$CERT_ $CERT_KEY $DOMAIN_NAME' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

nginx -g "daemon off;"
