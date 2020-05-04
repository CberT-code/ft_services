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
		eval $(minikube docker-enc)
		echo "--> docker eval running"
		docker build -t nginx nginx/.
		echo "--> nginx has beem build"
		kubectl apply -f deploy.yaml --record
		echo "--> deploy has been started"
	fi
elif [[ $s1 == "stop" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		docker rmi -f nginx
		echo "--> rm docker image nginx"
		minikube stop
		echo "--> minikube was stop"
		minikube delete
		echo "--> minikube was deleted"
	fi
elif [[ $s1 == "restart" ]]
then
	if [[ $(minikube status | grep -c "Running") != 0 ]]
	then
		docker rmi -f nginx
		echo "--> rm docker image nginx"
		minikube stop
		echo "--> minikube was stop"
		minikube delete
		echo "--> minikube was deleted"
	elif [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		minikube start
		minikube addons enable metrics-server
		minikube addons enable ingress
		minikube addons enable dashboard
		export minikubeip=$(minikube ip)
		echo "--> minikube was start"
		docker build -t nginx nginx/.
		kubectl apply -f deploy.yaml
	fi
elif [[ $s1 == "service" ]]
then
	if [[ $s2 == "start" ]]
	then
		kubectl apply -f deploy.yaml
	elif [[ $s2 == "stop" ]]
	then
		kubectl delete service nginx
		kubectl delete deployments.apps nginx
	elif [[ $s2 == "restart" ]]
	then
		kubectl delete service nginx
		kubectl delete deployments.apps nginx
		kubectl apply -f deploy.yaml
	fi
elif [[ $s1 == "ingress" ]]
then
	if [[ $s2 == "start" ]]
	then
		kubectl apply -f ingress-deploy.yaml
	elif [[ $s2 == "stop" ]]
	then
		kubectl delete ingress ingress-nginx
	elif [[ $s2 == "restart" ]]
	then
		kubectl delete ingress ingress-nginx
		kubectl apply -f ingress-deploy.yaml
	fi
elif [[ $s1 == "all" ]]
then
	if [[ $s2 == "start" ]]
	then
		kubectl apply -f deploy.yaml
		kubectl apply -f ingress-deploy.yaml
	elif [[ $s2 == "stop" ]]
	then
		kubectl delete ingress ingress-nginx
		kubectl delete service nginx
		kubectl delete deployments.apps nginx
	elif [[ $s2 == "restart" ]]
	then
		kubectl delete service nginx
		kubectl delete ingress ingress-nginx
		kubectl delete deployments.apps nginx
		kubectl apply -f deploy.yaml
		kubectl apply -f ingress-deploy.yaml
	fi	
fi
