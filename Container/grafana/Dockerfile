FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

RUN apk update
RUN apk add openrc 
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
&& tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
&& rm /grafana-6.6.0/conf/defaults.ini \
&& rm -rf /var/cache/apk/* 	

COPY /srcs/defaults.ini ./grafana-6.6.0/conf/

VOLUME ["/sys/fs/cgroup"]

VOLUME ["/var/lib/grafana"]

RUN openrc boot

COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
COPY /srcs/run.sh /root

EXPOSE 3000

ENTRYPOINT  sh /root/run.sh;