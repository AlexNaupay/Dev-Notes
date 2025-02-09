# 07-services-ingress

## Habilita el Ingress controller:

```bash
minikube addons enable ingress
```

## Verifica que el NGINX Ingress controller esté funcionando:

```bash
kubectl get pods -n ingress-nginx
```

## Despliega una app "hello, world":

```bash
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
```

## Exposición del Deployment:

```bash
kubectl expose deployment web --type=NodePort --port=8080
```

## Accede al servicio usando la IP proporcionada:

```bash
minikube service web --url
```

## Crea un Ingress:

```bash
kubectl apply -f https://k8s.io/examples/service/networking/example-ingress.yaml
```

## Verifica que el Ingress esté correctamente configurado:

```bash
kubectl get ingress
```