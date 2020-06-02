FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Updating and adding packages
RUN apk update
RUN apk add openrc mysql mysql-client
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Copying mysql telegraf configuration and run
COPY /srcs/my.cnf /etc/mysql/
COPY /srcs/run.sh /root
COPY /srcs/wordpress.sql /root
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
COPY /srcs/start.sh /root/

#Mounting Volume for openrc and mysqlDB
VOLUME ["/sys/fs/cgroup"]
VOLUME ["/var/lib/mysql"]

RUN openrc boot

#Exposing port
EXPOSE 3306

#Starting container witj
ENTRYPOINT sh /root/run.sh; sh /root/start.sh