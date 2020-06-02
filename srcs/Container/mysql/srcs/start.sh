while [ 1 ]
do
    if [ $(service mariadb status | grep -c started) != 1 ];
    then
        exit
    fi
done