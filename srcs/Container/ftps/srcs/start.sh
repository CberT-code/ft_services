vsftpd /etc/vsftpd/vsftpd.conf &> /dev/null &

sleep 20
while [ 1 ]
do
    sleep 5
    if [ $(service telegraf status | grep -c started) != 1 ];
    then
        exit
    fi
done