FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY /srcs/my.cnf /etc/mysql/

COPY /srcs/run.sh /root

COPY /srcs/my.cnf /etc/mysql/

VOLUME ["/sys/fs/cgroup"]

VOLUME ["/var/lib/mysql"]
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/

EXPOSE 3306

ENTRYPOINT sh /root/run.sh; service telegraf start; tail -f /dev/null;