# Instalar e carregar o pacote plumber
install.packages("plumber")
library(plumber)

# Criar um objeto plumber
r_api <- plumb("C:/Users/anapa/OneDrive/Área de Trabalho/FIAP/15 - Machine Learning Engeneering - MLOPs/5DTS-MLOPS/Parte_1/api_script.R")

# Definir o endpoint para a função predict_api
r_api$run(port = 9000)