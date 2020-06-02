FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Updating and adding packages
RUN apk update
RUN apk add openrc sudo influxdb
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Mounting Volume for openrc and influxDB
VOLUME ["/sys/fs/cgroup"]
VOLUME ["/var/lib/influxdb"]

RUN openrc boot

#Copying telegraf and influxdb configurations
COPY /srcs/run.sh /root/
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
COPY /srcs/influxdb.conf /etc/
COPY /srcs/start.sh /root/

#Exposing port
EXPOSE 3000

#Start container with
ENTRYPOINT  service telegraf start ; sh /root/run.sh ; sh /root/start.sh