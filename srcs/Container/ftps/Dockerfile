FROM alpine
MAINTAINER Cbertola <cbertola@student.42.fr>

#Download packages
RUN apk add vsftpd openrc openssl
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Copy srcs
COPY /srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY /srcs/telegraf.conf /etc/telegraf.conf.d/

#Volume creation for openrcboot
VOLUME [ "/sys/fs/cgroup" ]

RUN openrc boot

#Creating user
RUN adduser -D admin
RUN echo "admin:test123" | chpasswd

#Path to no-register user ftp
RUN mkdir -p /var/run/vsftpd/empty

#Generating SSL files
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=cbertola' -keyout /etc/ssl/private/key.pem -out /etc/ssl/private/cert.pem

#Preparating the user files
RUN mkdir /home/admin/ftp
RUN chown nobody:nogroup /home/admin/ftp
RUN chmod a-w /home/admin/ftp

#Creating FTP Entry folder
RUN mkdir /home/admin/ftp/files
RUN chown admin:admin /home/admin/ftp/files

#Add admin to the user list
RUN echo "admin" | tee -a /etc/vsftpd/vsftpd.userlist

#Exposing ports
EXPOSE 21 20 30000-30006

#Starting service
ENTRYPOINT service telegraf start; vsftpd /etc/vsftpd/vsftpd.conf


