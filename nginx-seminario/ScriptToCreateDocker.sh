# Cronstrói o docker a partir do Dockerfile
docker build -t nginx-seminario .
# Executa o docker previamente criado
docker run -d nginx-seminario
# Definir a porta para execução do docker, neste caso usamos a porta 8080 do host que aponta para a 80 do container
docker run -it --rm -d -p 8080:80 --name web nginx-seminario
# Logar no docker hub para fazermos o upload do nosso Docker caso o teste acima tenha dado certo
docker login
# Criar a tag para o nginx gerado
docker tag nginx-seminario marcelorcastro/nginx-seminario
# Subir o nginx para o docker hub
docker push marcelorcastro/nginx-seminario	
