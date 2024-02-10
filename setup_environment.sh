echo "Creating docker images for all containers"
echo "Building Parte_1 --------------------------------------------------------------------"
docker build -t parte1_api -f Parte_1/dockerbuilds/Dockerfile Parte_1/api/
echo "Building Parte_2 --------------------------------------------------------------------"
docker build -t parte2_api -f Parte_2/dockerbuilds/Dockerfile Parte_2/api/
echo "Building Parte_3 --------------------------------------------------------------------"
docker build -t modelmanager -f Parte_3/dockerbuilds/Dockerfile Parte_3/api/
echo "Building Parte_4 --------------------------------------------------------------------"
docker build -t frontendstreamlit -f Parte_4/dockerbuilds/Dockerfile Parte_4/api/

echo "Creating network --------------------------------------------------------------------"
docker network create plat_network

echo "Deploying containers for predictions ------------------------------------------------"
docker run -d --restart always --network plat_network --name parte1_api parte1_api
docker run -d --restart always --network plat_network --name parte2_api parte2_api

echo "Updanting config file ---------------------------------------------------------------"
bash ./Parte_3/update_config.sh

echo "Config model manager ----------------------------------------------------------------"
docker run -d --restart always --network plat_network -v $(pwd)/Parte_3/api/config:/myServer/config -v $(pwd)/Parte_3/docker/log:/myServer/log --name modelmanager modelmanager

echo "Updating microservices.json for access API from Frontend ----------------------------"
bash ./Parte_4/update_config.sh

echo "Config FrontEnd ---------------------------------------------------------------------"
docker run -d --restart always --network plat_network -p 80:8501 -v $(pwd)/Parte_4/api/config:/myServer/config --name frontendstreamlit frontendstreamlit

echo "Conferindo os containers criados ----------------------=-----------------------------"
sleep 10
docker network inspect plat_network