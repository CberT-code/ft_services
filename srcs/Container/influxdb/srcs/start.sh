while [ 1 ]
do
    if [ $(service influxdb status | grep -c started) != 1 ];
    then
        exit
    fi
done