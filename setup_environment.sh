echo "Creating docker images for all containers"
docker build -t api_part2 -f Parte_2/dockerbuilds/Dockerfile

echo "Creating network"
docker network create plat_network

echo "Deploying containers for predictions"
docker run -d --restart always --network plat_network --name api_part2 api_part2