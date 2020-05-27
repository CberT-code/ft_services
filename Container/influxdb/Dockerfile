FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

RUN apk update
RUN apk add openrc sudo influxdb
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN openrc boot

COPY /srcs/run.sh /root
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
COPY /srcs/influxdb.conf /root

VOLUME ["/sys/fs/cgroup"]

VOLUME ["/var/lib/influxdb"]

EXPOSE 3000

ENTRYPOINT  sh /root/run.sh;