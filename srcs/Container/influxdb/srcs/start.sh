while [ 1 ]
do
    sleep 5
    if [ $(service influxdb status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service telegraf status | grep -c started) != 1 ];
    then
        exit
    fi
done