echo "Creating docker images for all containers"
docker build -t parte2_api -f Parte_2/dockerbuilds/Dockerfile Parte_2/api/
docker build -t modelmanager -f Parte_3/dockerbuilds/Dockerfile Parte_3/api/

echo "Creating network"
docker network create plat_network

echo "Deploying containers for predictions"
docker run -d --restart always --network plat_network --name parte2_api parte2_api

bash ./Parte_3/update_config.sh

echo "Config model manager"
docker run -d --restart always --network plat_network -v $(pwd)/Parte_3/api/config:/myServer/config -v $(pwd)/Parte_3/docker/log:/myServer/log --name modelmanager modelmanager

echo "Waiting for containers to start..."
sleep 10

docker images
docker network ls
docker ps
docker network inspect plat_network