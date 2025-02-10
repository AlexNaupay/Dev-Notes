# Despliegue de una aplicación de frontend y backend en Kubernetes

## Prerequisitos

- Tener instalado Kubernetes
- Tener instalado Docker
- Tener instalado kubectl
- Minikube instalado

## Configuracion de minikube para tomar imagenes de registry local

minikube start --driver=docker

eval $(minikube docker-env)

docker ps

docker-compose build

## Frontend

## Backend

minikube addons enable metrics-server

```bash
minikube tunnel --bind-address='*'
```