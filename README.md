# 5DTS-MLOPS
Machine Learning Engeneering- MLOPS

# Procedimentos para execução

## Comandos Shell

Para acessar a VM criada:
```
ssh <usuário>@52.226.67.177
```

### Instalação do Docker
```
sudo apt-get update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo apt install nano
```

### Baixar componentes do GitHub:
```
git clone https://github.com/anapaulalavieri/5DTS-MLOPS.git
```

### Instalação dos componentes:
```
cd 5DTS-MLOPS
sudo bash setup_environment.sh 
```

Obs: Se precisar editar alguma coisa e instalar o ambiente de novo... executar esse:
```
sudo bash reset_environment.sh 
```

Obs.: Se precisar validar o ambiente:
```
sudo docker network inspect plat_network
```

### Para testar:
Obs.: Substituir os IPs de cada parte

**Modelos Parte 1 e Parte 2:**
```
curl http://172.25.0.2:8080/
```
```
curl -X POST -H "Content-Type: application/json" -d '{"model":"parte1_api","features": [{"loan_limit": "cf","approv_in_adv": "nopre","loan_type": "type3","loan_purpose": "p4","Credit_Worthiness": "l1","Interest_rate_spread": 0.39,"Neg_ammortization": "not_neg","interest_only": "not_int","lump_sum_payment": "lpsm","occupancy_type": "ir","total_units": "1U","credit_type": "CRIF","co_applicant_credit_type": "EXP","age": "25-34","submission_of_application": "to_inst","Region": "North"}]}' http://172.25.0.2:8080/predict
```

**Model Manager:**
É possível trocar o modelo no parâmetro "model"
- parte1_api
- parte2_api

```
curl http://172.25.0.4:8080/
```
```
curl -X POST -H "Content-Type: application/json" -d '{"model":"parte1_api","features": [{"loan_limit": "cf","approv_in_adv": "nopre","loan_type": "type3","loan_purpose": "p4","Credit_Worthiness": "l1","Interest_rate_spread": 0.39,"Neg_ammortization": "not_neg","interest_only": "not_int","lump_sum_payment": "lpsm","occupancy_type": "ir","total_units": "1U","credit_type": "CRIF","co_applicant_credit_type": "EXP","age": "25-34","submission_of_application": "to_inst","Region": "North"}]}' http://172.25.0.4:8080/predict?model=parte1_api
```
```
curl -X POST -H "Content-Type: application/json" -d '{"model":"parte1_api","features": [{"loan_limit": "cf","approv_in_adv": "nopre","loan_type": "type3","loan_purpose": "p4","Credit_Worthiness": "l1","Interest_rate_spread": 0.39,"Neg_ammortization": "not_neg","interest_only": "not_int","lump_sum_payment": "lpsm","occupancy_type": "ir","total_units": "1U","credit_type": "CRIF","co_applicant_credit_type": "EXP","age": "25-34","submission_of_application": "to_inst","Region": "North"}]}' http://172.25.0.4:8080/predict?model=parte2_api
```