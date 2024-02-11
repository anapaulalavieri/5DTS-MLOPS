# Instalar e carregar o pacote plumber
install.packages("plumber")
library(plumber)
library(rstudioapi)

# Criar um objeto plumber
r_api <- plumb(file.path(dirname(getActiveDocumentContext()$path), 'api_script.R'))
  
# Definir o endpoint para a função predict_api
r_api$run(port = 9000)