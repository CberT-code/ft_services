# Installation Alpine
FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Download all packet needed
RUN apk get update && \
    apk get upgrade && \
    apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
        php7-zlib php7-curl php7-mbstring php7-json php7-session \
        openrc openssl openssh sudo --no-cache

RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
# RUN adduser -D -u 1000 "admin"
# RUN echo "admin:adminmdp" | chpasswd

RUN mkdir var/www/

COPY srcs/ var/www/

RUN openrc boot
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
VOLUME ["/sys/fs/cgroup"]
# #ouverture des ports
EXPOSE 5050

ENTRYPOINT service php-fpm7 start; service telegraf start; php -S 0.0.0.0:5050 -t /var/www/