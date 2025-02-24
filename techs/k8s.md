# Kubernetes
# https://pabpereza.dev/blog/instalacion_kubernetes_ubuntu_server_22.04
`minikube start --driver=docker`

## kubectl
```bash
kubectl get --help
kubectl apply -f simple-pod.yaml
kubectl delete -f simple-pod.yaml

kubectl get nodes
kubectl describe RESOURCE <name>

kubectl get pods [-A] [-o wide]
kubectl get namespaces|ns
kubectl get replicaset|rs
kubectl get deployments
kubectl get service
kubectl get pv
kubectl get pvc
kubectl get daemonsets
kubectl get statefulsets
kubectl create namespace backends
kubectl delete namespace backends

kubectl edit secrets <secret-name>

kubectl exec (POD | TYPE/NAME) [-c CONTAINER] [flags] -- COMMAND [args...]
kubectl exec -it <pod-name> -- bash

kubectl delete POD
kubectl delete pod nginx-replicaset-<pod-id>

kubectl run mypod --image=nginx [--restart=Never] [--port=80]

kubectl set image deployment/my-deployment hello-app=google-samples/hello-app:2.0

kubectl rollout status deployment/hello-deployment
kubectl rollout undo deployment/hello-deployment

kubectl port-forward type/name local:resource
kubectl port-forward deployment/my-deployment 8080:8080
kubectl port-forward --address=0.0.0.0 deployment/hello-deployment 8080:80

kubectl get configmap config-name
kubectl describe configmap config-name
kubectl get secret secret-name -o yaml
kubectl get secret my-secret -o jsonpath='{.data.username}'

kubectl get pods demo-pod -o yaml|json > demo-pod2.yml

kubectl config get-contexts
kubectl config use-context <context-name>

kubectl expose pod hello-cloud --type=LoadBalancer --port=8080 --target-port=8080 --name=hello-cloud

kubectl label nodes slave-node kubernetes.io/role=worker

```

## kubeadm
```bash

kubeadm config print init-defaults # join-defaults reset-defaults upgrade-defaults init-defaults

```

## minikube
```bash
minikube start --driver=docker
minikube ssh
minikube profile list

minikube addons list
minikube addons enable registry # Vincula el registro de Docker con MiniKube.
minikube addons enable metrics-server

eval $(minikube docker-env)  # view from docker

minikube dashboard
ssh -L 33609:127.0.0.1:33609 alexh@192.168.18.76

minikube service list
minikube service service-name # Create a tunnel?

# minikube tunnel # create a tunnel from local to minikube (after deploy loadbalancer)
minikube tunnel --bind-address='*'

# k get service # use EXTERNAL-IP
w3m https://google.com

```


## Install tools (on master and workers)

```bash
#https://kubernetes.io/docs/tasks/tools/

# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

## Installer for Debian (v1.32) as root
[Referencia](https://pabpereza.dev/blog/instalacion_kubernetes_ubuntu_server_22.04)

```bash
#!/usr/bin/bash
# echo "IP_HOST k8scp" >> /etc/hosts
apt update
apt install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

#(Optional) Enable the kubelet service before running kubeadm:
# systemctl enable --now kubelet

# /etc/fstab ; comment swap line
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
systemctl stop dev-sda3.swap    # Stop it now, change according to fstab
systemctl disable dev-sda3.swap # Prevent it from starting on boot
systemctl mask dev-sda3.swap
update-initramfs -u
systemctl daemon-reload

mount -a
swapoff -a
free -h

# Enable kernel modules
modprobe overlay
modprobe br_netfilter
# Configure persistent loading of modules
tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Add some settings to sysctl
tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sysctl --system

## Add docker repo
apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y containerd.io
# Configure containerd and start service
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/1' /etc/containerd/config.toml
sed -i 's/pause:3.8/pause:3.10/1' /etc/containerd/config.toml


# restart containerd
systemctl restart containerd
systemctl enable containerd
systemctl status  containerd 

# If you are using containerd, check whether the SystemdCgroup is configured to true 
# in /etc/containerd/config.toml which maybe help you resolve the issue.
# https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd

```

## Setup master and workers
```bash
#### master
kubeadm config images pull # as root
# IP_HOST   k8scp  # /etc/hosts 

sudo kubeadm init --pod-network-cidr=172.24.0.0/16 --cri-socket=unix:///run/containerd/containerd.sock --upload-certs --control-plane-endpoint=k8scp
# kubeadm init --upload-certs --control-plane-endpoint=k8scp # as root
# If you are using containerd, check whether the SystemdCgroup is configured to true 
# in /etc/containerd/config.toml which maybe help you resolve the issue.

kubectl cluster-info

# Install calico with manifest (Not recommended)
# https://github.com/projectcalico/calico/releases
#curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/calico.yaml
#kubectl create -f calico.yaml 

# Install calico with operator (Recommended) : AS normal user
# https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/tigera-operator.yaml
curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/custom-resources.yaml
kubectl create -f tigera-operator.yaml # --save-config  ; too long 
# sed -ie 's/192.168.0.0/CIDR_NET/g' custom-resources.yaml
sed -ie 's$192.168.0.0/16$172.24.0.0/16$g' custom-resources.yaml  # Used on --pod-network-cidr=172.24.0.0/16 or 
# kubectl describe pod kube-controller-manager-<hostname> -n kube-system or
# /etc/kubernetes/manifests/kube-controller-manager.yaml or
# kubectl get installation default -o yaml -n tigera-operator
kubectl create -f custom-resources.yaml --save-config

# Not necesary
# https://docs.tigera.io/calico/latest/getting-started/kubernetes/hardway/install-cni-plugin
# https://github.com/projectcalico/cni-plugin/releases

echo 'source <(kubectl completion bash)' >> ~/.bashrc

# ls /etc/cni/net.d/
# ls /opt/cni/bin/

# Use commands showed for master to join as cp or workers
# To generate new token and discovery-token-ca-cert-hash;
# Run as root onn master(cp) node
kubeadm token create
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

# On worker as root
kubeadm join k8scp:6443 --token <token> --discovery-token-ca-cert-hash sha256:<discovery-token>

# On another cp as root
kubeadm join k8scp:6443 --token <token> --discovery-token-ca-cert-hash sha256:<discovery-token> --control-plane --certificate-key <cert-key>


## Reset
kubeadm reset
rm /etc/cni/net.d/*  # Delete all
iptables -F ; iptables -X ; iptables -t nat -F ; iptables -t nat -X ; iptables -t mangle -F ; iptables -t mangle -X
```

## Install ingress-nginx
```bash
# https://github.com/kubernetes/ingress-nginx
# https://kubernetes.github.io/ingress-nginx/deploy/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
# mv deploy.yaml ingress-nginx-install.yaml
```

## Install metallb
```bash
# https://metallb.io/
# https://metallb.io/installation/; set strictARP: true
# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system

# Installation by manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
```

#### Layer 2 configuration. Create a .yaml
```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: my-first-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.1.240-192.168.1.250
````

#### L2Advertisement. Create a .yaml
```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: my-l2-advertisement
  namespace: metallb-system
spec:
  ipAddressPools:
  - my-first-pool
```