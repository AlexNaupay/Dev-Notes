docker buildx build --platform linux/amd64 -t frontend:v1 .

docker tag frontend:v1 <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend:v1

docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-frontend:v1
