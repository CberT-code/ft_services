php -S 0.0.0.0:5050 -t /var/www &> /dev/null &

sleep 20
while [ 1 ]
do
    sleep 5
wget http://172.17.0.2/wordpress
    rm -rf wordpress
    if [ $(service php-fpm7 status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service telegraf status | grep -c started) != 1 ];
    then
        exit
    fi
done