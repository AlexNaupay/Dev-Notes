# Despliegue de una aplicación de frontend y backend en la Nube de AWS

## Prerequisites

- AWS CLI
- kubectl
- eksctl
- RDS Mysql

## En esta clase:

- Crear un cluster en EKS
- Tener un RDS Mysql
- Crear los namespaces en nuestro nuevo cluster
- Create an Service Type ExternalName for RDS
- Create a Secret Object for the RDS
- Configurar ECR
- Build para Arch x86_64 y Taggear la imagen del backend
- Backend
- Revisar el load balancer del servicio backend
- Build para Arch x86_64 y Taggear la imagen del frontend
- Frontend

### Crear un cluster en EKS

La creacion del cluster puede tardar unos minutos.
```
eksctl create cluster -f ekscluster.yaml
```

### Crear un RDS Subnet Group en la VPC del cluster
Ubicar el RDS en las subnets privadas del cluster.
```
aws rds create-db-subnet-group \
    --db-subnet-group-name k8s-subnet-group \
    --db-subnet-group-description "Subnet group for k8s RDS" \
    --subnet-ids subnet-050682d924201a3f0 subnet-029c8f18408230e3e
```

## Crear un rds en aws usando la CLI de AWS

```
aws rds create-db-cluster \
    --db-cluster-identifier k8s-aurora-cluster \
    --engine aurora-mysql \
    --engine-version 8.0.mysql_aurora.3.04.1 \
    --region us-east-1 \
    --master-username admink8s \
    --master-user-password Aggregate4200 \
    --db-subnet-group-name k8s-subnet-group \
    --serverless-v2-scaling-configuration MinCapacity=1,MaxCapacity=4 \
    --database-name k8sdb \
    --tags Key=Environment,Value=Development Key=Project,Value=CourseK8S
```

## Crear un Parameter Group para el cluster

```
aws rds create-db-parameter-group \
    --db-parameter-group-name aurorapg \
    --db-parameter-group-family aurora-mysql8.0 \
    --description "Parameter group for Aurora MySQL 8.0"
```

## Crear una instancia de RDS en el cluster

```
aws rds create-db-instance \
      --db-instance-identifier eks-instance \
      --db-cluster-identifier k8s-aurora-cluster \
      --engine aurora-mysql \
      --db-instance-class db.r4.large \
      --db-parameter-group aurorapg
```

Luego de crear el cluster, se puede ver el endpoint del cluster en la consola de AWS.

### Crear los namespaces en nuestro nuevo cluster

```bash
kubectl create namespace backend
kubectl create namespace frontend
kubectl create namespace storage
```

### Create an Service Type ExternalName for RDS

```
kubectl -n storage create service externalname mysql --external-name k8s-test-course.cluster-criggmwnb5gy.us-east-1.rds.amazonaws.com
```

### Create a Secret Object for the RDS

Con url directa del HOST
```
kubectl -n backend create secret generic mysql --from-literal=DB_PASSWORD=admink8s --from-literal=DB_USER=admink8s --from-literal=DB_HOST=k8s-test-course.cluster-criggmwnb5gy.us-east-1.rds.amazonaws.com --from-literal=DB_NAME=userdb
```


## Crear un job para inicializar la base de datos

```
kubectl -n backend apply -f app/k8s/db-job-init/config.yaml
kubectl -n backend apply -f app/k8s/db-job-init/init-job.yaml
```

## Crear un secret para el job

```
kubectl -n backend create secret generic mysql --from-literal=DB_PASSWORD=admink8s --from-literal=DB_USER=admink8s --from-literal=DB_HOST=mysql.storage.svc.cluster.local --from-literal=DB_NAME=userdb
```


## Configurar ECR

```
aws ecr create-repository --repository-name k8s-backend --region us-east-1
aws ecr create-repository --repository-name k8s-frontend --region us-east-1
```

El resultado de la creación de los repositorios será algo como:

Backend:
```
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-1:<your-account-id>:repository/k8s-backend",
        "registryId": "<your-account-id>",
        "repositoryName": "k8s-backend",
        "repositoryUri": "<your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend",
        ...
    }
}
```

Frontend:
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-1:<your-account-id>:repository/k8s-frontend",
        "registryId": "<your-account-id>",
        "repositoryName": "k8s-frontend",
        "repositoryUri": "<your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend",
        ...
    }
}
```

### Login en ECR

```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.us-east-1.amazonaws.com
```

### Build para Arch x86_64 y Taggear la imagen del backend

```
docker buildx build --platform linux/amd64 -t backend:v1 .
docker tag backend:v1 <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1
docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1
```

### Backend

```
kubectl -n backend apply -f ./app/k8s/backend/
```

### Revisar el load balancer del servicio backend

```
kubectl get svc -n backend
```

### Build para Arch x86_64 y Taggear la imagen del frontend

```
docker buildx build --platform linux/amd64 -t frontend:v1 .
docker tag frontend:v1 <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend:v1
docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend:v1
```

### Frontend

```
kubectl -n frontend apply -f ./app/k8s/frontend/
```

