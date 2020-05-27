mkdir /etc/telegraf
mv /root/telegraf.conf /etc/telegraf/
mv /root/grafana.ini /etc/
service telegraf start
tail -f /dev/null