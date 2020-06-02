php -S 0.0.0.0:5000 -t /var/www &> /dev/null &

while [ 1 ]
do
    sleep 5
    if [ $(service php-fpm7 status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service telegraf status | grep -c started) != 1 ];
    then
        exit
    fi
done