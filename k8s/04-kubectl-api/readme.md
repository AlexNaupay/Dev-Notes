# Introducción a la API de Kubernetes y kubectl

Kubernetes es una plataforma de orquestación de contenedores que permite gestionar aplicaciones distribuidas. La API de Kubernetes es el núcleo de Kubernetes y actúa como la interfaz principal para interactuar con el clúster. Todos los componentes de Kubernetes (como el kube-scheduler, kube-controller-manager, etc.) y las herramientas externas (como kubectl) se comunican con el clúster a través de esta API.

## ¿Qué es la API de Kubernetes?

Es una interfaz RESTful que permite a los usuarios y componentes interactuar con el clúster.
Permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre los recursos del clúster, como Pods, Deployments, Services, ConfigMaps, etc.
Es extensible, lo que significa que puedes agregar recursos personalizados (CRDs - Custom Resource Definitions).
Por ejemplo, cuando ejecutas un comando como kubectl get pods, kubectl envía una solicitud HTTP a la API Server para obtener información sobre los Pods.

Por otro lado, kubectl es la herramienta de línea de comandos que permite interactuar con la API de Kubernetes. Con kubectl, puedes consultar, crear, actualizar y eliminar recursos en el clúster.

Comandos básicos de kubectl:

### Consultar recursos:
```
kubectl get <recurso>
```
Ejemplo: kubectl get pods muestra todos los Pods en el namespace actual.

Describir recursos:
```
kubectl describe <recurso> <nombre>
```

Crear o actualizar recursos con un archivo YAML:
```
kubectl apply -f <archivo.yaml>
kubectl apply -f simple-pod.yaml
```

Eliminar recursos:
```
kubectl delete <recurso> <nombre>
kubectl delete pod lonely-pod
```

## Concepto de Namespaces

Un namespace en Kubernetes es una forma de dividir y gestionar los recursos dentro de un clúster, permitiendo:
- crear entornos aislados para diferentes proyectos o equipos.
- Esta característica es especialmente útil en situaciones donde varios grupos de trabajo utilizan el mismo clúster, ya que ayuda a evitar conflictos de nombres y a organizar los recursos de manera más efectiva.

### Características Clave de los Namespaces

- Aislamiento Lógico: Los namespaces permiten que los recursos como pods, servicios y deployments se agrupen y gestionen de manera separada. Esto significa que puedes tener recursos con el mismo nombre en diferentes namespaces sin que haya conflictos.

- Recursos Compartidos: Aunque los namespaces proporcionan aislamiento, los recursos del clúster (como el CPU y la memoria) pueden ser compartidos entre ellos. Sin embargo, se pueden establecer cuotas de recursos para limitar el uso por parte de cada namespace, mejorando así la gestión y seguridad del clúster.

### Namespaces por Defecto: Kubernetes crea tres namespaces por defecto:
- default: Espacio donde se crean los objetos que no especifican un namespace.
- kube-system: Utilizado para componentes internos del sistema Kubernetes.
- kube-public: Accesible por todos los usuarios, reservado para recursos que deben ser visibles públicamente dentro del clúster

### Crear un Namespace (imperativo)
```
kubectl create namespace my-namespace
```

### Listar Namespaces
```
kubectl get namespaces
```


### Crear un Namespace (declarativo)
```
apiVersion: v1
kind: Namespace
metadata:
  name: <nombre-del-namespace>
```

### Aplicar el archivo YAML

```
kubectl apply -f <archivo.yaml>
```
