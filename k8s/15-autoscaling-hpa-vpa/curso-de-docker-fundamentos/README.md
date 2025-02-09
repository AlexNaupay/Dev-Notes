# Despliegue de una aplicación de frontend y backend en Kubernetes

## Prerequisitos

- Tener instalado Kubernetes
- Tener instalado Docker
- Tener instalado kubectl
- Minikube instalado

### Asegurar configuracion de minikube para tomar imagenes de registry local

```
minikube addons enable registry
```

### Validar que minikube se ha iniciado correctamente con el driver de docker

```
minikube start --driver=docker
```

### Evaluar el entorno de docker

```
eval $(minikube docker-env)
```

### Habilitar el metrics-server

```
minikube addons enable metrics-server
```

### Verificar que el metrics-server se ha instalado correctamente

Deberiamos ver el pod del metrics-server corriendo
```
kubectl get pods -n kube-system
```

### Verificar que el HPA ya esta instalado y capturando los datos de los pods

```
kubectl get hpa
```

Deberiamos ver los HPA que se han creado para el frontend y el backend

| NAME          | REFERENCE                       | TARGETS      | MINPODS | MAXPODS | REPLICAS | AGE |
|---------------|--------------------------------|--------------|----------|----------|-----------|-----|
| backend-hpa   | Deployment/backend-deployment   | cpu: 2%/80% | 1        | 5        | 1         | 10s |
| frontend-hpa  | Deployment/frontend-deployment  | cpu: 4%/20% | 1        | 3        | 1         | 10s |

