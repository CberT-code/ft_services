#!/bin/bash

INFORMATION="\033[01;33m" #yellow
SUCCESS="\033[1;32m"      #green
ERROR="\033[1;31m"        #red
RESET="\033[0;0m"         #white

print_msg() {
  NOW=$(date +%H:%M:%S)
  printf "$1%s ➜ $2$RESET\n" $NOW
}

# CLEAN FUNCTIONS

clean_services() {
	print_msg $INFORMATION "Cleaning services..."
	kubectl delete -all services
	print_msg $SUCCESS "Services cleaned."
}

clean_deployement() {
	print_msg $INFORMATION "Cleaning deployment..."
	kubectl delete -all deployment.app
	print_msg $SUCCESS "Deployment cleaned."
}

clean_ingress() {
	print_msg $INFORMATION "Cleaning ingress..."
	kubectl delete -all services
	print_msg $SUCCESS "Ingress cleaned."
}

clean_yaml() {
	print_msg $INFORMATION "Cleaning services..."
	kubectl delete -f Yaml/nginx.yaml
	print_msg $SUCCESS "nginx cleaned."
	kubectl delete -f Yaml/phpmyadmin.yaml
	print_msg $SUCCESS "phpmyadmin cleaned."
	kubectl delete -f Yaml/wordpress.yaml
	print_msg $SUCCESS "wordpress cleaned."
	kubectl delete -f Yaml/mysql.yaml
	print_msg $SUCCESS "mysql cleaned."
	kubectl delete -f Yaml/ingress.yaml
	print_msg $SUCCESS "ingress cleaned."
	print_msg $INFORMATION "All services cleaned."
}

clean_dockers() {
	print_msg $INFORMATION "Cleaning dockers..."
	docker rmi -f nginx
	print_msg $SUCCESS "Docker nginx cleaned."
	docker rmi -f phpmyadmin
	print_msg $SUCCESS "Docker phpmyadmin cleaned."
	docker rmi -f wordpress
	print_msg $SUCCESS "Docker wordpress cleaned."
	docker rmi -f mysql
	print_msg $SUCCESS "Docker mysql cleaned."
	print_msg $INFORMATION "All dockers cleaned."
}

# ADD FUNCTIONS

add_yaml() {
	print_msg $INFORMATION "Adding services..."
	kubectl apply -f Yaml/nginx.yaml
	print_msg $SUCCESS "nginx added."
	kubectl apply -f Yaml/phpmyadmin.yaml
	print_msg $SUCCESS "phpmyadmin added."
	kubectl apply -f Yaml/wordpress.yaml
	print_msg $SUCCESS "wordpress added."
	kubectl apply -f Yaml/mysql.yaml
	print_msg $SUCCESS "mysql added."
	kubectl apply -f Yaml/ingress.yaml
	print_msg $SUCCESS "ingress added."
	print_msg $INFORMATION "All services added."
}

add_dockers() {
	print_msg $INFORMATION "Adding dockers..."
	docker build -t nginx Container/nginx/.
	print_msg $SUCCESS "Docker nginx added."
	docker build -t phpmyadmin Container/phpmyadmin/.
	print_msg $SUCCESS "Docker phpmyadmin added."
	docker build -t wordpress Container/wordpress/.
	print_msg $SUCCESS "Docker wordpress added."
	docker build -t wordpress Container/mysql/.
	print_msg $SUCCESS "Docker mysql added."
	print_msg $INFORMATION "All dockers added."
}

# Check Function

check_running() {
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		print_msg $INFORMATION "Minikube is not started"
		exit
	fi
}

# START OF THE SCRIPT

if [[ $1 == "" ]]
then
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		minikube start
		minikube addons enable metrics-server
		minikube addons enable ingress
		minikube addons enable dashboard

		export minikubeip=$(minikube ip)
		print_msg $SUCCESS  "--> minikube has been started with metric-server ingress dashboard"

		eval $(minikube docker-env)
		print_msg $SUCCESS "--> docker eval nginx running"

		add_dockers
		add_yaml

	else print_msg $INFORMATION "Minikube is already started"
	fi
elif [[ $1 == "stop" ]]
then
		check_running

		clean_yaml
		clean_dockers

		minikube stop
		print_msg $SUCCESS "--> minikube was stop"
		minikube delete
		print_msg $SUCCESS "--> minikube was deleted"
	
elif [[ $1 == "restart" ]]
then
		check_running

		clean_yaml
		clean_dockers
		minikube stop
		print_msg $SUCCESS "--> minikube was stop"
		minikube delete
		print_msg $SUCCESS "--> minikube was deleted"

		minikube start
		minikube addons enable metrics-server
		minikube addons enable ingress
		minikube addons enable dashboard

		export minikubeip=$(minikube ip)
		print_msg $SUCCESS  "--> minikube has been started with metric-server ingress dashboard"

		eval $(minikube docker-env)
		print_msg $SUCCESS "--> docker eval nginx running"
		add_dockers
		add_yaml

elif [[ $1 == "dockers" ]]
then
		check_running

		if $2 == "build" 
		then
			add_dockers
		fi
		if $2 == "rmi"
		then
			clean_dockers
		fi
		if $2 == "restart"
		then
			clean_dockers
			add_dockers
		fi
elif [[ $1 == "yaml" ]]
then
		check_running

		if $2 == "apply" 
		then
			add_yaml
		fi
		if $2 == "delete"
		then
			clean_yaml
		fi
		if $2 == "restart"
		then
			clean_yaml
			add_yaml
		fi
elif  [[ $1 == "restartyaml" ]]
then
		check_running

		kubectl delete -f Yaml/nginx.yaml
		kubectl delete -f Yaml/wordpress.yaml
		kubectl delete -f Yaml/phpmyadmin.yaml
		kubectl delete -f Yaml/ingress.yaml

		kubectl apply -f Yaml/nginx.yaml
		kubectl apply -f Yaml/wordpress.yaml
		kubectl apply -f Yaml/phpmyadmin.yaml
		kubectl apply -f Yaml/ingress.yaml
		kubectl apply -f Yaml/mysql.yaml
fi