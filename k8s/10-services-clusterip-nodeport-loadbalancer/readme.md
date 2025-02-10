Clase 10: Tipos de servicios: NodePort, ClusterIP, LoadBalancer, ExternalName


```bash
#my-service
port: 80 # Port of service to be used for other services
targetPort: 8080 # Port of app (container) inside of pod
nodePort: # Es el puerto en el que el Service estará disponible en cada nodo del clúster. Solo se usa en Services de tipo NodePort o LoadBalancer.

# Dentro del clúster: Otros servicios pueden acceder a my-service usando http://my-service:80; El Service redirige el tráfico al puerto 8080 del contenedor dentro del pod
# Desde fuera: Puedes acceder a la aplicación usando la IP de cualquier nodo del clúster y el puerto 30007
# nodePort ((NodePort/LoadBalancer)) http://<NodeIP>:30007
```

## NodePort

Un servicio de tipo NodePort expone un Pod en un puerto específico en cada nodo del clúster. Esto permite que las aplicaciones sean accesibles desde fuera del clúster, a través de la IP del nodo y el puerto asignado.


**Crear un Deployment**

```
kubectl apply -f deployment-nodeport.yaml
```

## ClusterIP

Es el tipo de Servicio predeterminado en Kubernetes. Expone el Servicio dentro del clúster, asignándole una dirección IP interna accesible solo desde dentro del clúster. No es accesible desde fuera del clúster.

** Casos de uso **

Ideal para aplicaciones internas que solo necesitan ser consumidas por otros Pods dentro del clúster. Tales, como microservicios que se comunican entre sí.


```
kubectl apply -f deployment-clusterip.yaml
```



## LoadBalancer

Este tipo crea un balanceador de carga externo en proveedores de nube, asignando una dirección IP externa que permite el acceso al servicio.

Casos de uso:
Ideal para aplicaciones en producción que requieren alta disponibilidad y distribución del tráfico entre múltiples Pods.

Ejemplo: Aplicaciones web o APIs que necesitan ser accesibles desde Internet.

En nuestro cluster en local, podemos simular el servicio de tipo LoadBalancer con el siguiente comando:

```
minikube tunnel
```

## ExternalName

No redirige el tráfico a Pods, sino que actúa como un alias para un nombre de dominio externo. Resuelve el nombre del Servicio a un nombre DNS externo especificado. Simplifica la gestión y mantenimiento de conexiones a recursos externos

### Casos de uso:
Útil para integrar servicios externos (fuera del clúster) con aplicaciones dentro del clúster.


```
apiVersion: v1
kind: Service
metadata:
  name: my-database-service
spec:
  type: ExternalName
  externalName: my-database.cluster-abcdef123456.us-west-2.rds.amazonaws.com
```


# Documentación

- https://minikube.sigs.k8s.io/docs/handbook/accessing/