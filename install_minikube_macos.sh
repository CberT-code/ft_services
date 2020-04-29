
#Download the latest version of Kubectl
brew install kubectl 

#test the version 
kubectl version --client

#install MiniKub
brew install minikube

#Confirm install Minikube with virtualbox
minikube start --driver=virtualbox

#Check Minikube status
minikube status
