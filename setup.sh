#!/bin/bash

INFORMATION="\033[01;33m" #yellow
SUCCESS="\033[1;32m"      #green
ERROR="\033[1;31m"        #red
RESET="\033[0;0m"         #white

array=( nginx phpmyadmin wordpress mysql influxdb grafana ftps )

print_msg() {
  NOW=$(date +%H:%M:%S)
  printf "$1%s ➜ $2$RESET\n" $NOW
}

# CLEAN FUNCTIONS

clean_yaml() {
	print_msg $INFORMATION "Cleaning services..."
	for i in "${array[@]}"
	do
		kubectl delete -f Yaml/$i.yaml
		print_msg $ERROR "$i.yaml cleaned."
	done
	kubectl delete -f Yaml/ingress.yaml > /dev/null
	print_msg $ERROR "ingress.yaml cleaned."
	print_msg $INFORMATION "All services cleaned."
}

clean_dockers() {
	print_msg $INFORMATION "Cleaning dockers..."
	for i in "${array[@]}"
	do
		docker rmi -f $i
		print_msg $ERROR "Docker $i cleaned."
	done
	print_msg $INFORMATION "All dockers cleaned."
}

# ADD FUNCTIONS

add_yaml() {
	print_msg $INFORMATION "Adding services..."
	for i in "${array[@]}"
	do
		kubectl apply -f Yaml/$i.yaml > /dev/null
		print_msg $SUCCESS "$i.yaml added."
	done
	kubectl apply -f Yaml/ingress.yaml > /dev/null
	print_msg $SUCCESS "ingress.yaml added."
	print_msg $INFORMATION "All dockers added."
}
add_dockers() {
	print_msg $INFORMATION "Adding dockers..."
	for i in "${array[@]}"
	do
		docker build -t $i Container/$i/. > /dev/null
		print_msg $SUCCESS "Docker $i added."
	done
	print_msg $INFORMATION "All dockers added."
}
# Check Function

check_running() {
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		print_msg $ERROR "Minikube is not started"
		exit
	fi
}

# Minikube start

minikube_start(){
	print_msg $INFORMATION "Starting Minikube"
	minikube start --vm-driver=virtualbox --cpus=4 --memory=5000m > /dev/null
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard

	export minikubeip=$(minikube ip)
	sed -i '' '40d' Container/ftps/srcs/vsftpd.conf | echo  "pasv_address=${minikubeip}" >> Container/ftps/srcs/vsftpd.conf
	sed "s/ipminikube/${minikubeip}/g" Container/mysql/srcs/origine.sql > Container/mysql/srcs/wordpress.sql
	eval $(minikube docker-env)
	
	print_msg $SUCCESS  "--> minikube has been started"
}

minikube_stop(){
	minikube stop
	print_msg $SUCCESS "--> minikube was stop"
	minikube delete
	print_msg $SUCCESS "--> minikube was deleted"
}

# START OF THE SCRIPT

if [[ $1 == "" ]]
then
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		
		minikube_start

		add_dockers
		add_yaml
		
		print_msg $RESET $minikubeip

	else print_msg $INFORMATION "Minikube is already started"
	fi

elif [[ $1 == "stop" ]]
then
		check_running

		minikube_stop
	
elif [[ $1 == "restart" ]]
then
		check_running

		minikube_stop
		minikube_start

		add_dockers
		add_yaml

		print_msg $RESET $minikubeip

elif [[ $1 == "dockers" ]]
then
		check_running

		if [[ $2 == "build" ]]
		then
			add_dockers
		fi
		if [[ $2 == "rmi" ]]
		then
			clean_dockers
		fi
		if [[ $2 == "restart" ]]
		then
			clean_dockers
			add_dockers
		fi
elif [[ $1 == "yaml" ]]
then
		check_running

		if [[ $2 == "apply" ]]
		then
			add_yaml
		fi
		if [[ $2 == "delete" ]]
		then
			 clean_yaml
		fi
		if [[ $2 == "restart" ]]
		then
			clean_yaml
			add_yaml
		fi
fi