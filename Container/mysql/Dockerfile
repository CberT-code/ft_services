FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

COPY /srcs/my.cnf /etc/mysql/

USER root

RUN apk update
RUN apk add openrc mysql mysql-client sudo --no-cache
RUN openrc boot

RUN sudo service mariadb setup
RUN sudo service mariadb start && \
mysql -u root -e "CREATE DATABASE wordpress" && \
mysql -u root -e "CREATE USER 'user1'@'localhost' IDENTIFIED BY 'test123'" && \
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'user1'@'localhost'" && \
mysql -u root -e "FLUSH PRIVILEGES"

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT service mariadb restart; tail -f /dev/null;