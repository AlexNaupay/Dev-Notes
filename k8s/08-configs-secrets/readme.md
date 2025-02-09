# 08-configs-secrets

## Apply ConfigMap
```bash
# Creates or updates the ConfigMap from the auth-config.yaml file
kubectl apply -f auth-config.yaml
```

## Apply Secret
```bash
# Creates or updates the Secret from the auth-secret.yaml file
kubectl apply -f auth-secret.yaml
```

## View ConfigMap
```bash
# Lists the ConfigMap named 'auth-config' in the current namespace
kubectl get configmap auth-config
```

## View Secret
```bash
# Lists the Secret named 'auth-secret' in the current namespace
kubectl get secret auth-secret
```

## Other links

- https://external-secrets.io/latest/
