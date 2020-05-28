FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Adding and updating packages
RUN apk update
RUN apk add openrc bash
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
RUN apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz

#Unziping grafana and removing cache
RUN tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
&& rm /grafana-6.6.0/conf/defaults.ini \
&& rm -rf /var/cache/apk/* 	

#Adding Volume for openrc and grafana
VOLUME ["/sys/fs/cgroup"]

RUN openrc boot

#Creating folder for dashboard
RUN mkdir -p /var/lib/grafana/dashboards

#Copying telegraph conf
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/
COPY /srcs/defaults.ini /grafana-6.6.0/conf/
COPY /srcs/grafana.db /grafana-6.6.0/data/
COPY /srcs/run.sh /root
COPY /srcs/dashboard.json /var/lib/grafana/dashboards

#Exposing port
EXPOSE 3000

#Starting docker with
ENTRYPOINT  sh /root/run.sh;