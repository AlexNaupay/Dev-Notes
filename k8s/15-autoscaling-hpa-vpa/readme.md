# 15-autoscaling-hpa-vpa

# Aplicar deployment y HPA

```
kubectl apply -f my-app-deployment.yaml
kubectl apply -f my-hpa.yaml
kubectl describe hpa my-hpa
```


# Enlaces para instalar los CRD de VPA

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-rbac.yaml
```

# Aplicar VPA

```
kubectl apply -f my-vpa.yaml
kubectl describe vpa my-vpa
```