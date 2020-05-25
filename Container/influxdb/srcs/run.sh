mkdir /etc/telegraf
mv /root/telegraf.conf /etc/telegraf/
service influxdb start
service telegraf start
sleep 2
influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER user1 WITH PASSWORD 'test123'"
mv /root/influxdb.conf /etc/
service influxdb restart
tail -f /dev/null