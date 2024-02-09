# Carregar o modelo
# load("/content/modelo_rlog.RData")
load("C:/Users/anapa/OneDrive/Área de Trabalho/FIAP/15 - Machine Learning Engeneering - MLOPs/MLOPS - Trabalho/modelo_rlog.RData")

# Criar função para a API
#' @post /predict_api
#' Prever resultados usando o modelo treinado
#' @param novos_dados Dados para fazer a previsão
#' @return Lista com as previsões
predict_api <- function(novos_dados) {
  # Efetuando a previsão, utilizando o modelofinal_rlog
  previsoes <- predict(modelofinal_rlog, novos_dados, type = "response")
  return(list(previsoes = previsoes))
}
