Clase 6: Pods, ReplicaSets y Deployments

## Que es un pod?

Un Pod es la unidad más pequeña y básica de Kubernetes. Representa una instancia de una aplicación en ejecución en el clúster. Un Pod puede contener uno o más contenedores que comparten:

- Red: Todos los contenedores dentro de un Pod comparten la misma dirección IP y puerto.
- Almacenamiento: Los contenedores pueden compartir volúmenes montados.
- Ciclo de vida: Los contenedores dentro de un Pod se crean, ejecutan y eliminan juntos.

### Forma imperativa (CLI)

**Crear un pod de nginx**

```
kubectl run nginx-nodeport --image=nginx --restart=Never --port=80
```

**Ver pods existentes**

```
kubectl get pods
```

**Exponer un servicio con port-forward**

```
kubectl port-forward pod/nginx-nodeport 8080:80
```

# Que significa Stateless vs statefull: tener o no tener estado, ahí está el dilema.

En Kubernetes, las aplicaciones pueden ser stateless (sin estado) o stateful (con estado). Esto afecta cómo se diseñan y gestionan los Pods.

#### Stateless (sin estado):
- No guardan datos persistentes entre reinicios.
- Ejemplo: Servidores web como Nginx o aplicaciones que procesan solicitudes HTTP.
- Escalabilidad sencilla: Puedes agregar o eliminar réplicas sin preocuparte por la consistencia de datos.
#### Stateful (con estado):
- Guardan datos persistentes y necesitan mantener el estado entre reinicios.
- Ejemplo: Bases de datos como MySQL o Redis.
- Requieren volúmenes persistentes (Persistent Volumes) para almacenar datos.

## ReplicaSets: Garantizar la disponibilidad de Pods.

### Forma declarativa

**Crear un ReplicaSet**

```
kubectl apply -f replicaset.yaml
```

**Ver pods existentes**

```
kubectl get pods
```

**Ver ReplicaSet existentes**

```
kubectl get replicaset
```

**Eliminar un Pod**

```
kubectl delete pod nginx-replicaset-<pod-id>
```

## Deployments: Gestión declarativa de aplicaciones.

Un Deployment es una capa superior que gestiona ReplicaSets y proporciona una forma declarativa de implementar aplicaciones. Es la forma más común de gestionar aplicaciones en Kubernetes.


### Forma declarativa

**Crear un Deployment**

```
kubectl apply -f deployment.yaml
```

**Ver pods existentes**

```
kubectl get pods
```

**Ver Deployment existentes**

```
kubectl get deployment
```

**Eliminar un Pod**

```
kubectl delete pod hello-deployment-<pod-id>
```

**Actualizar la imagen del Deployment**

```
kubectl set image deployment/hello-deployment hello-app=gcr.io/google-samples/hello-app:2.0
```

**Verificar el progreso de la actualización**

```
kubectl rollout status deployment/hello-deployment
```

**Verificar los Pods actualizados**

```
kubectl get pods
```

**Revertir la última actualización**

```
kubectl rollout undo deployment/hello-deployment
```

**Verificar los Pods actualizados**

```
kubectl get pods
```

**Exponer un Deployment**

```
kubectl port-forward deploy/hello-deployment 8080:8080
```







