# Carregar o modelo
load("./modelo_rlog.RData")

# Criar função para a API
#' @post /predict
#' Prever resultados usando o modelo treinado
#' @param novos_dados Dados para fazer a previsão
#' @return Lista com as previsões

predict_api <- function(features) {
  # Efetuando a previsão, utilizando o modelofinal_rlog
  previsoes <- predict(modelofinal_rlog, features, type = "response")
  return(list(previsoes = previsoes))
}
