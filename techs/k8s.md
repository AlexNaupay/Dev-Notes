# Kubernetes

`minikube start --driver=docker`

## kubectl
```bash
kubectl get --help
kubectl apply -f simple-pod.yaml

kubectl get nodes
kubectl describe NODE

kubectl config get-contexts
kubectl config use-context "nombre-contexto"

kubectl get pods [-A] [-o wide]
kubectl get namespaces|ns
kubectl get replicaset|rs
kubectl get deployments
kubectl get service
kubectl create namespace backends
kubectl delete namespace backends

kubectl delete POD
kubectl delete pod nginx-replicaset-<pod-id>

kubectl run mypod --image=nginx [--restart=Never] [--port=80]

kubectl set image deployment/my-deployment hello-app=google-samples/hello-app:2.0

kubectl rollout status deployment/hello-deployment
kubectl rollout undo deployment/hello-deployment

kubectl port-forward type/name local:resource
kubectl port-forward deployment/my-deployment 8080:8080

kubectl get configmap config-name
kubectl describe configmap config-name
kubectl get secret secret-name -o yaml
kubectl get secret my-secret -o jsonpath='{.data.username}'

kubectl get pods demo-pod -o yaml|json > demo-pod2.yml

```

## minikube
```bash
minikube start --driver=docker
minikube profile list

minikube addons list
minikube addons enable registry # Vincula el registro de Docker con MiniKube.
minikube addons enable metrics-server

eval $(minikube docker-env)  # view from docker

minikube dashboard
ssh -L 33609:127.0.0.1:33609 alexh@192.168.18.76

minikube service service-name # Create a tunnel
w3m https://google.com
```
