#!/bin/bash

if [[ $1 == "start" ]]
then
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		minikube start
		minikube addons enable metrics-server
		minikube addons enable ingress
		minikube addons enable dashboard
		export minikubeip=$(minikube ip)
		echo "--> minikube has been started with metric-server ingress dashboard"

		eval $(minikube docker-env)
		echo "--> docker eval nginx running"

		docker build -t nginx Container/nginx/.
		echo "--> nginx has beem build"
		docker build -t phpmyadmin Container/phpmyadmin/.
		echo "--> phpmyadmin has beem build"
		docker build -t wordpress Container/wordpress/.
		echo "--> wordpress has beem build"
		docker build -t mysql Container/mysql/.
		echo "--> mysql has beem build"

		kubectl apply -f nginx.yaml
		echo "--> nginx deploy has been started"
		kubectl apply -f wordpress.yaml
		echo "--> wordpress deploy has been started"
		kubectl apply -f phpmyadmin.yaml
		echo "--> phpmyadmin deploy has been started"
		kubectl apply -f mysql.yaml
		echo "--> mysql deploy has been started"
	fi
elif [[ $1 == "stop" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		kubectl delete -f nginx.yaml
		echo "--> delete deploy nginx"
		kubectl delete -f wordpress.yaml
		echo "--> delete deploy wordpress"
		kubectl delete -f phpmyadmin.yaml
		echo "--> delete deploy phpmyadmin"
		kubectl delete -f ingress.yaml
		echo "--> delete deploy ingress"
		kubectl delete -f mysql.yaml
		echo "--> mysql deploy ingress"

		docker rmi -f nginx
		echo "--> rm docker image nginx"
		docker rmi -f phpmyadmin
		echo "--> rm docker image phpmyadmin"
		docker rmi -f wordpress
		echo "--> rm docker image wordpress"
		docker rmi -f mysql
		echo "--> rm docker image mysql"

		minikube stop
		echo "--> minikube was stop"
		minikube delete
		echo "--> minikube was deleted"
	fi
elif [[ $1 == "restart" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		kubectl delete -f nginx.yaml
		echo "--> delete deploy nginx"
		kubectl delete -f wordpress.yaml
		echo "--> delete deploy wordpress"
		kubectl delete -f phpmyadmin.yaml
		echo "--> delete deploy phpmyadmin"
		kubectl delete -f ingress.yaml
		echo "--> delete deploy phpmyadmin"
		kubectl delete -f mysql.yaml
		echo "--> delete deploy mysql"

		docker rmi -f nginx
		echo "--> rm docker image nginx"
		docker rmi -f phpmyadmin
		echo "--> rm docker image phpmyadmin"
		docker rmi -f wordpress
		echo "--> rm docker image wordpress"
		docker rmi -f mysql
		echo "--> rm docker image mysql"

		docker build -t nginx Container/nginx/.
		echo "--> nginx has beem build"
		docker build -t phpmyadmin Container/phpmyadmin/.
		echo "--> phpmyadmin has beem build"
		docker build -t wordpress Container/wordpress/.
		echo "--> wordpress has beem build"
		docker build -t mysql Container/mysql/.
		echo "--> mysql has beem build"

		kubectl apply -f nginx.yaml
		echo "--> nginx deploy has been started"
		kubectl apply -f wordpress.yaml
		echo "--> wordpress deploy has been started"
		kubectl apply -f phpmyadmin.yaml
		echo "--> phpmyadmin deploy has been started"
		kubectl apply -f ingress.yaml
		echo "--> phpmyadmin deploy has been started"
		kubectl apply -f mysql.yaml
		echo "--> mysql deploy has been started"
	fi
elif [[ $1 == "dockerstart" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		eval $(minikube docker-env)
		echo "--> docker eval nginx running"

		docker build -t nginx Container/nginx/.
		echo "--> nginx has beem build"
		docker build -t phpmyadmin Container/phpmyadmin/.
		echo "--> phpmyadmin has beem build"
		docker build -t wordpress Container/wordpress/.
		echo "--> wordpress has beem build"
		docker build -t wordpress Container/mysql/.
		echo "--> mysql has beem build"
	fi
elif [[ $1 == "dockerstop" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		docker rmi -f nginx
		echo "--> rm docker image nginx"
		docker rmi -f phpmyadmin
		echo "--> rm docker image phpmyadmin"
		docker rmi -f wordpress
		echo "--> rm docker image wordpress"
		docker rmi -f mysql
		echo "--> rm docker image mysql"
	fi
elif [[ $1 == "restartyaml" ]]
then
		kubectl delete -f nginx.yaml
		kubectl delete -f wordpress.yaml
		kubectl delete -f phpmyadmin.yaml
		kubectl delete -f ingress.yaml

		kubectl apply -f nginx.yaml
		kubectl apply -f wordpress.yaml
		kubectl apply -f phpmyadmin.yaml
		kubectl apply -f ingress.yaml
		kubectl apply -f mysql.yaml
fi