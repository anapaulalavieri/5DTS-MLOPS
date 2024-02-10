echo '{                                                     ' >  $(pwd)/Parte_3/api/config/microservices.json
echo '  "models": {                                         ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '    "parte1_api": {                                     ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect parte1_api | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '    },                                                ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '    "parte2_api": {                                     ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect parte2_api | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '    }                                                 ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '  }                                                   ' >> $(pwd)/Parte_3/api/config/microservices.json
echo '}                                                     ' >> $(pwd)/Parte_3/api/config/microservices.json

echo "[PART 3] Arquivo de configuração atualizado com sucesso. Veja seu conteúdo: "

cat $(pwd)/Parte_3/api/config/microservices.json