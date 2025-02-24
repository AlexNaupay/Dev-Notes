# Deploy to AWS

```bash
# 1. Create eks cluster
eksctl create cluster -f ekscluster.yaml

# 2. Create a RDS DB with a subnet group with cluster subnets OR create a peering:Accept connection (and config SGs) then
# aws ec2 create-vpc-peering-connection --vpc-id REQUESTER --peer-vpc-id ACCEPTER --region <tu-region> OR by console
aws rds create-db-subnet-group \
    --db-subnet-group-name <k8s-subnet-group> \
    --db-subnet-group-description "Subnet group for k8s RDS" \
    --subnet-ids <eks-cluster-id1> <eks-cluster-id2>
# Config SG of RDS 
    
# 3. Create namespaces
kubectl create namespace backend
kubectl create namespace frontend
kubectl create namespace storage

# 4. Create storage objects
k -n storage apply -f 1-external-name.yaml # Access: <nombre-del-service>.<namespace>.svc.cluster.local
k -n backend apply -f 2-secrets.yaml # Cant access to secrets or configmaps of other ns
k apply -f 3-config.yaml # ns inside

# 5. Config DB
k -n backend apply -f db-job-init/config.yaml 
k -n backend apply -f db-job-init/init-job.yaml
k get pods -n backend # View logs from pods
k logs mysql-init-job-clpzp -n backend

# kubectl run -it --rm debug --image=busybox -- sh  ; then ping to resources
# kubectl run -it --rm debug --image=alpine:latest -- sh  ; then ping to resources debian:bookworm-slim

# 6. Login to ECR (in region)
# https://docs.aws.amazon.com/es_es/AmazonECR/latest/userguide/registry_auth.html
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

# 7. Build docker images
docker buildx build --platform linux/amd64 -t backend:v1 .
docker tag backend:v1 <account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1
# OR
docker build --platform linux/amd64,linux/arm64 --push -t <account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1 .
docker build --platform linux/amd64,linux/arm64 --push -t <account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend:v1 .

# 8. Apply manifests of backend-app (We need the backend url)
kubectl -n backend apply -f ./backend-manifests/

# 9. Apply manifests of frontend-app (Set backend url)
kubectl -n frontend apply -f ./frontend-manifests/

```