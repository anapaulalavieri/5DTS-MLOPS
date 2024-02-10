# Interrompendo os containers
docker stop parte1_api 
docker stop parte2_api 
docker stop modelmanager
docker stop frontendstreamlit

# Removendo os containers
docker rm parte1_api
docker rm parte2_api
docker rm modelmanager
docker rm frontendstreamlit

# Removendo a network
docker network rm plat_network