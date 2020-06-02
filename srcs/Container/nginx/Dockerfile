# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Updating and adding packets
RUN apk get update && apk get upgrade && apk add nginx php7-fpm openrc openssl openssh
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#Adding admin user
RUN adduser -D admin
RUN echo "admin:test123" | chpasswd

#Creating folders for path in 80 or 443 and nginx
RUN mkdir var/www/http
RUN mkdir var/www/https
RUN mkdir -p /run/nginx

#Copying sources
COPY srcs/ var/www/http/
COPY srcs/img/ /var/www/https/img/

#Moving index for 443
RUN mv var/www/http/index2.html  var/www/https/index.html

#Moving sudo conf
RUN mv var/www/http/sudoers /etc/

RUN mv var/www/http/start.sh /root/

#Mounting Volume for openrc
VOLUME ["/sys/fs/cgroup"]

RUN openrc boot

#Creating SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=92/L=Paris/O=42/CN=cbertola' -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.crt

#Moving Nginx and telegraf conf
RUN mv var/www/http/default.conf /etc/nginx/conf.d/
RUN mv var/www/http/telegraf.conf /etc/telegraf.conf.d/

#Exposing ports
EXPOSE 80 443 22

#Start docker with
ENTRYPOINT service sshd start; service telegraf start; service nginx start ; sh /root/start.sh