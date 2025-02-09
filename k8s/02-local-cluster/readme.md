# 02-local-cluster

## Instalar minikube y kubectl desde la documentación oficial


## Iniciar minikube

```
minikube start --driver=docker

minikube start --nodes 2 -p twonodes --driver=docker
```
minikube addons list
minikube addons enable registry
eval $(minikube docker-env)
minikube addons enable metrics-server


## Evaluar el entorno de docker

```
eval $(minikube docker-env)
```

## Ver los contenedores de docker

```
docker ps
```

## Conocer info y los contextos del cluster y kubectl

```
kubectl cluster-info
kubectl config get-contexts
```

## Cambiar el contexto del kubectl

```
kubectl config use-context <context-name>
```

## Crear un pod de prueba

```
kubectl run hello-cloud --image=gcr.io/google-samples/hello-app:2.0 --restart=Never --port=8080
```
