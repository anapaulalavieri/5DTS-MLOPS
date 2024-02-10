from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import joblib

# Funções de apoio 
# -------------------------------------------------------------------------------------------------------
def init():
    global clusters_result
    global kmeans
    global scaler
    global n_clusters

    # Carregar a média de propensão de risco dos clusters
    clusters_result = pd.read_json('./config/clusters_result.json')
    # Carregar o modelo K-means
    kmeans = joblib.load('./config/kmeans_model.pkl')
    # Carregar o scaler
    scaler = joblib.load('./config/scaler.pkl')
    # Carregar o número de clusters
    with open('./config/n_clusters.txt', 'r') as f: n_clusters = int(f.read())


def assign_persona(cluster):
    # # Obter o nível de risco correspondente ao cluster
    risk_level = clusters_result.loc[clusters_result['Cluster'] == cluster, 'Risk Level'].iloc[0]
    fraud_propensity = clusters_result.loc[clusters_result['Cluster'] == cluster, 'Status'].iloc[0]
    
    return risk_level, fraud_propensity

def one_hot_encode_columns(df, columns):
    for column in columns:
        df = pd.get_dummies(df, columns=[column])
    return df  

# Definições da API
# -------------------------------------------------------------------------------------------------------
app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    # Obter os dados do cliente do request
    data = request.get_json()
    features = data['features']  # Supondo que as características do cliente sejam fornecidas como uma lista
    loans_data_classif = pd.DataFrame(features)

    # Tratando as colunas categóricas
    columns_to_encode = ['loan_limit', 'approv_in_adv', 'loan_type', 'loan_purpose', 'Credit_Worthiness',
                         'Neg_ammortization', 'interest_only', 'lump_sum_payment', 'occupancy_type',
                         'credit_type', 'total_units', 'co_applicant_credit_type', 'age',
                         'submission_of_application', 'Region']    
    loans_data_classif = one_hot_encode_columns(loans_data_classif, columns_to_encode)


    # Garantindo que todas as colunas necessárias estão no dataset
    columns_to_check = ['loan_limit_cf', 'loan_limit_ncf',
                        'approv_in_adv_nopre', 'approv_in_adv_pre',
                        'loan_type_type1', 'loan_type_type2', 'loan_type_type3',
                        'loan_purpose_p1', 'loan_purpose_p2', 'loan_purpose_p3', 'loan_purpose_p4',
                        'Credit_Worthiness_l1', 'Credit_Worthiness_l2',
                        'Neg_ammortization_neg_amm', 'Neg_ammortization_not_neg',
                        'interest_only_int_only', 'interest_only_not_int',
                        'lump_sum_payment_lpsm', 'lump_sum_payment_not_lpsm',
                        'occupancy_type_ir', 'occupancy_type_pr', 'occupancy_type_sr',
                        'credit_type_CIB', 'credit_type_CRIF', 'credit_type_EQUI', 'credit_type_EXP',
                        'total_units_1U', 'total_units_2U', 'total_units_3U', 'total_units_4U',
                        'co_applicant_credit_type_CIB', 'co_applicant_credit_type_EXP',
                        'age_25-34', 'age_35-44', 'age_45-54', 'age_55-64', 'age_65-74', 'age_<25', 'age_>74',
                        'submission_of_application_not_inst', 'submission_of_application_to_inst',
                        'Region_North', 'Region_North-East', 'Region_central', 'Region_south'
                        ]
    
    # Verificar se as colunas estão presentes, atribuindo False para as colunas ausentes
    missing_columns = [col for col in columns_to_check if col not in loans_data_classif.columns]
    for col in missing_columns:
        loans_data_classif[col] = False
    
    # Padronizar as características e prever o cluster do cliente
    scaled_features = scaler.transform(loans_data_classif)
    cluster = kmeans.predict(scaled_features)[0]
    
    # Atribuir a persona com base no cluster (esta parte você precisa implementar)
    persona, fraud_propensity = assign_persona(cluster)
    
    # Retornar os resultados como JSON
    return jsonify({
        'cluster': int(cluster),
        'persona': persona,
        'fraud_propensity': fraud_propensity
    })

# Definir a rota raiz
@app.route("/", methods=['GET', 'POST'])
def call_home(request = request):
    print(request.values)
    return "Server is ready to be used!\n"

if __name__ == '__main__':
    init()
    app.run(port=8080, host = '0.0.0.0')