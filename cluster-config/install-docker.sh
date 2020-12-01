# atualiza a lista de repositorios
sudo apt-get update

# instala pacotes extras para o APT utilizar repositorios HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent gnupg2 software-properties-common

#bBaixa e adiciona a chave publica do docker no sistema
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# adiciona o repositorio que contem os pacotes para a instalacao do docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# instala os pacotes docker
sudo apt update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# adiciona o usuario ubuntu ao grupo docker
sudo usermod -aG docker $USER

# cria diretorios necessarios para configurar o docker com systemd
sudo mkdir -p /etc/systemd/system/docker.service.d

# cria arquivo de configuracao daemon.json
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# inicia e habilita os servicos
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

# Executa um teste de instalacao
sudo docker run hello-world
 
