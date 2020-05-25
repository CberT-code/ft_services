FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

RUN apk update
RUN apk add openrc 
RUN apk add grafana telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

VOLUME ["/sys/fs/cgroup"]

VOLUME ["/var/lib/grafana"]

RUN openrc boot

EXPOSE 3000

ENTRYPOINT service grafana start; service grafana status; tail -f /dev/null;