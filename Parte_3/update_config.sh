echo '{                                                     ' >  $(pwd)/Parte_3/docker/config/microservices.json
echo '  "models": {                                         ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '    "default_propensity": {                                     ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect defaultpropensityapi | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '    },                                                ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '    "customer_clustering": {                                     ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect customerclusteringapi | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '    }                                                 ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '  }                                                   ' >> $(pwd)/Parte_3/docker/config/microservices.json
echo '}                                                     ' >> $(pwd)/Parte_3/docker/config/microservices.json

echo "[PART 3] Arquivo de configuração atualizado com sucesso. Veja seu conteúdo: "

cat $(pwd)/Parte_3/docker/config/microservices.json