# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Updating and adding packets
RUN apk get update
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
        php7-zlib php7-curl php7-mbstring php7-json php7-session \
        openrc mysql-client
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Creating the folder src for :5000
RUN mkdir var/www

#Copying srcs
COPY srcs/ var/www/
COPY srcs/start.sh /root/

#MountingVolume for openrc
VOLUME ["/sys/fs/cgroup"]

RUN openrc boot

#Moving telegraf conf
RUN mv var/www/telegraf.conf /etc/telegraf.conf.d/

#Exposing ports
EXPOSE 5000

#Start container with
ENTRYPOINT service php-fpm7 start; service telegraf start; sh /root/start.sh



