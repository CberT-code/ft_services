# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Updating and adding packets 
RUN apk get update && apk get upgrade
RUN apk add wget unzip openrc php7-fpm php7 php7-mbstring php7-cgi php7-openssl php7-session php7-zlib php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom mysql-client --no-cache
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Creating src for -5050
RUN mkdir var/www/

#Adding admin user
RUN adduser -D admin
RUN echo "admin:test123" | chpasswd

#Copying srcs
COPY srcs/ var/www/

#Mounting Volume
VOLUME ["/sys/fs/cgroup"]

RUN openrc boot

#Moving telegraf conf
RUN mv var/www/telegraf.conf /etc/telegraf.conf.d/

#Exposing ports
EXPOSE 5050

#Start containers with
ENTRYPOINT  service php-fpm7 start ; service telegraf start; php -S 0.0.0.0:5050 -t /var/www/