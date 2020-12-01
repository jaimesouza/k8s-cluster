# atualiza o sistema 
sudo apt update
sudo apt upgrade -y

# adiciona o repositorio do  Kubernetes para o Ubuntu 20.04
sudo apt update
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# instala kubelet, kubeadm e kubectl e outros pacotes
sudo apt update
sudo apt -y install vim git curl wget kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# confirma a instalacao, verificando a versao do kubectl e kubeadm
kubectl version --client && kubeadm version

# desabilita o swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

# configura sysctl
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

# instala o docker
bash install-docker.sh

# certifica que o modeulo br_netfilter esta carregado
lsmod | grep br_netfilter

# habilita o servico kubelet
sudo systemctl start kubelet
sudo systemctl enable kubelet

# Pull container images
sudo kubeadm config images pull

# inicia o cluster kubernetes 
# rede 10.244.0.0/16 padrao do flannel
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# configura o kubectl usando os comandos do outup
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# verifica o status do cluster
kubectl cluster-info

# instala o plugin flannel para gerenciar a rede de overlay no Kubernetes
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# verifica os pods core do kubernets
kubectl get pods --all-namespaces

# verifica se o no master esta pronto
kubectl get nodes -o wide

