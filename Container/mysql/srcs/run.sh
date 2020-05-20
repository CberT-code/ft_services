apk update
apk add openrc 
apk add mysql
apk add mysql-client
apk add sudo
apk add openssh
apk add busybox-extras
# apk add mysql-client
rc-update add sshd
openrc boot
service mariadb setup
service mariadb start
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'user1'@'%' IDENTIFIED BY 'test123'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'user1'@'%' WITH GRANT OPTION"
mysql -u root -e "FLUSH PRIVILEGES"