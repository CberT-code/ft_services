while [ 1 ]
do
    if [ $(service nginx status | grep -c started) != 1 ];
    then
        exit
    fi
    if [ $(service sshd status | grep -c started) != 1 ];
    then
        exit
    fi
done