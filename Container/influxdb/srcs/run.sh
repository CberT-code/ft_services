service influxdb start
service telegraf start
sleep 2
influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER user1 WITH PASSWORD 'test123'"
tail -f /dev/null