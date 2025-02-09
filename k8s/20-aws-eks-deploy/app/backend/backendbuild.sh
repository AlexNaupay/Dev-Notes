docker buildx build --platform linux/amd64 -t backend:v1 .

docker tag backend:v1 <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1

docker push <your-account-id>.dkr.ecr.us-east-1.amazonaws.com/k8s-backend:v1