# Definindo meu projeto
gcloud config set project "ID"

# Definindo a variável para a zona do GCP, no meu caso: us-central1-a
export MY_ZONE=us-central1-a

# Criando um CLUSTER chamado "seminario" com 4 nós
gcloud container clusters create seminario --zone $MY_ZONE --num-nodes 4

# Verifica a versão do k8s
kubectl version

# Criando um deploy manual da imagem do Docker previamente criada
kubectl create deploy nginx-seminario --image=marcelorcastro/nginx-seminario

# Verificando os pods
kubectl get pods

# Expondo o serviço para acesso externo
kubectl expose deployment nginx-seminario --port 80 --type LoadBalancer

# Verifica como está o deploy e o IP público para acesso
kubectl get services

# Aplicando escala para 3 replicas (pods)
kubectl scale deployment nginx-seminario --replicas 3

# Testando autoescala
kubectl autoscale deployment nginx-seminario --cpu-percent=50 --min=1 --max=10

# Verificando como está o escalonamento
kubectl get hpa

# Simulando tráfego para aumentar os pods
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://35.184.122.224/; done"

# Gerando o arquivo YAML para possíveis edições
kubectl get deploy nginx-seminario -o yaml

# Gerando o arquivo YAML v3 com autoescala
kubectl get hpa.v2beta2.autoscaling -o yaml