echo "Creating docker images for all containers"
docker build -t parte2_api -f Parte_2/dockerbuilds/Dockerfile Parte_2/api/

echo "Creating network"
docker network create plat_network

echo "Deploying containers for predictions"
docker run -d --restart always --network plat_network --name parte2_api parte2_api