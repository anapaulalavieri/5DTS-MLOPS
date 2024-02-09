# plumber.R
#* @apiTitle Propensão à Inadimplência API
#* @get /predict
function(
  loan_limit = "default_value1",
  Gender = "default_value2",
  approv_in_adv = "default_value3",
  loan_type = "default_value4",
  loan_purpose = "default_value5",
  Credit_Worthiness = "default_value6",
  open_credit = "default_value7",
  business_or_commercial = "default_value8",
  loan_amount = "default_value9",
  rate_of_interest = "default_value10",
  Interest_rate_spread = "default_value11",
  Upfront_charges = "default_value12",
  term = "default_value13",
  Neg_ammortization = "default_value14",
  interest_only = "default_value15",
  lump_sum_payment = "default_value16",
  property_value = "default_value17",
  construction_type = "default_value18",
  occupancy_type = "default_value19",
  total_units = "default_value20",
  income = "default_value21",
  credit_type = "default_value22",
  Credit_Score = "default_value23",
  co_applicant_credit_type = "default_value24",
  age = "default_value25",
  submission_of_application = "default_value26",
  LTV = "default_value27",
  Region = "default_value28",
  dtir1 = "default_value29"
) {
  # Carregar bibliotecas e modelo
  library(plumber)
  library(bigrquery)

  # Carregar o modelo treinado
  load("/content/modelo_rlog.RData")

  # Transformar os parâmetros em um dataframe
  input_data <- data.frame(
    loan_limit = as.factor(loan_limit),
    Gender = as.factor(Gender),
    approv_in_adv = as.factor(approv_in_adv),
    loan_type = as.factor(loan_type),
    loan_purpose = as.factor(loan_purpose),
    Credit_Worthiness = as.factor(Credit_Worthiness),
    open_credit = as.factor(open_credit),
    business_or_commercial = as.factor(business_or_commercial),
    loan_amount = as.numeric(loan_amount),
    rate_of_interest = as.numeric(rate_of_interest),
    Interest_rate_spread = as.numeric(Interest_rate_spread),
    Upfront_charges = as.numeric(Upfront_charges),
    term = as.numeric(term),
    Neg_ammortization = as.factor(Neg_ammortization),
    interest_only = as.factor(interest_only),
    lump_sum_payment = as.factor(lump_sum_payment),
    property_value = as.numeric(property_value),
    construction_type = as.factor(construction_type),
    occupancy_type = as.factor(occupancy_type),
    total_units = as.factor(total_units),
    income = as.numeric(income),
    credit_type = as.factor(credit_type),
    Credit_Score = as.numeric(Credit_Score),
    co_applicant_credit_type = as.factor(co_applicant_credit_type),
    age = as.factor(age),
    submission_of_application = as.factor(submission_of_application),
    LTV = as.numeric(LTV),
    Region = as.factor(Region),
    dtir1 = as.numeric(dtir1)
  )

  # Faça as previsões usando o modelo treinado
  predictions <- predict(modelo_rlog, newdata = input_data, type = "response")

  # Retornar as previsões como um JSON
  return(list(predictions = as.numeric(predictions)))
}