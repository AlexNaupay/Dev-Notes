# 05-declarative-vs-imperative

# Imperative

## Create a pod imperatively
```bash
kubectl run mypod --image=nginx
```

## Get a pod imperatively
```bash
kubectl get pods
```

## Delete a pod imperatively
```bash
kubectl delete pod mypod
```

# Declarative

## Create a pod declaratively
```bash
kubectl apply -f mypod.yaml
```

## Delete a pod declaratively
```bash
kubectl delete -f mypod.yaml
```
