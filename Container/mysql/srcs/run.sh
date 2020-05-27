service mariadb setup
service mariadb start
service telegraf start
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'user1'@'%' IDENTIFIED BY 'test123'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'user1'@'%' WITH GRANT OPTION"
mysql -u root -e "FLUSH PRIVILEGES"