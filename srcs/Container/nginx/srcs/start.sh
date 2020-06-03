
sleep 20
while [ 1 ]
do
    sleep 5
    if [ $(service nginx status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service sshd status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service telegraf status | grep -c started) != 1 ];
    then
        exit
    fi
done