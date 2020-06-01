if [[ $(service mariadb status | grep -c "stop") == 1 ]]
then
	kill 1
fi
if [[ $(service mariadb status 2>&1| grep -c "crashed") == 1 ]]
then
	kill 1
fi

