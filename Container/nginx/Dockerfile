# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Download all packet needed
RUN apk get update && apk get upgrade && apk add nginx php7-fpm openrc openssl openssh sudo
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN adduser -D -u 1000 "admin"
RUN echo "admin:adminmdp" | chpasswd

RUN mkdir var/www/http
RUN mkdir var/www/https
COPY srcs/ var/www/http/


RUN mv var/www/http/index2.html  var/www/https/index.html
RUN mkdir -p /run/nginx

RUN mv var/www/http/sudoers /etc/

RUN openrc boot

#SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=92/L=Paris/O=42/CN=cbertola' -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.crt

#Nginx
RUN mv var/www/http/default.conf /etc/nginx/conf.d/
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
VOLUME ["/sys/fs/cgroup"]

#ouverture des ports
EXPOSE 80 443 22

ENTRYPOINT service php-fpm7 start; service sshd start; service telegraf start; nginx -g "daemon off;";