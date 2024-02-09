echo "Creating docker images for all containers"
sudo docker build -t api_parte2 -f Parte_2/dockerbuilds/Dockerfile Parte_2/docker/

echo "Creating network"
docker network create plat_network

echo "Deploying containers for predictions"
docker run -d --restart always --network plat_network --name api_parte2 api_parte2