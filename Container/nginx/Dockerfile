# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Download all packet needed
RUN apk get update && apk get upgrade && apk add nginx php7-fpm openrc openssl openssh sudo

RUN adduser -D -u 1000 "admin"
RUN echo "admin:adminmdp" | chpasswd


COPY srcs/ var/www/

RUN mkdir var/www/html
RUN mv var/www/index.html  var/www/html
RUN mv var/www/index2.html  var/www/index.html
RUN mkdir -p /run/nginx

RUN mv var/www/sudoers /etc/

RUN openrc boot

#SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=92/L=Paris/O=42/CN=cbertola' -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.crt

#Nginx
RUN mv var/www/default.conf /etc/nginx/conf.d/

#ouverture des ports
EXPOSE 80 443 22

ENTRYPOINT service php-fpm7 start; service sshd start; nginx -g "daemon off;";