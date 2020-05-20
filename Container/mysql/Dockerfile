FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

COPY /srcs/my.cnf /etc/mysql/

COPY /srcs/run.sh /root

COPY /srcs/my.cnf /etc/mysql/

VOLUME ["/sys/fs/cgroup"]

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT sh /root/run.sh; tail -f /dev/null;