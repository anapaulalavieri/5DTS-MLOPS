# Interrompendo os containers
docker stop parte2_api 
docker stop modelmanager

# Removendo os containers
docker rm parte2_api
docker rm modelmanager

# Removendo a network
docker network rm plat_network