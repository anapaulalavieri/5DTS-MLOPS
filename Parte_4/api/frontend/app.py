
import streamlit as st
import requests
import json  # Importando json para simulação

# Inicializando estado se não existir
if 'tela' not in st.session_state:
    st.session_state.tela = 'inicio'

# Função para exibir a tela inicial
def tela_inicial():

    st.title('Quantum Finance - Análise de Clientes')

    # Definindo os campos conforme solicitado
    name = st.text_input('Nome')
    loan_limit = st.selectbox('Limite de Empréstimo', ['cf'], index=0)
    approv_in_adv = st.selectbox('Aprovação Antecipada', ['nopre'], index=0)
    loan_type = st.selectbox('Tipo de Empréstimo', ['type3'], index=0)
    loan_purpose = st.selectbox('Finalidade do Empréstimo', ['p4'], index=0)
    credit_worthiness = st.selectbox('Solvência de Crédito', ['l1'], index=0)
    interest_rate_spread = st.number_input('Spread de Taxa de Juros', value=0.39)
    neg_ammortization = st.selectbox('Amortização Negativa', ['not_neg'], index=0)
    interest_only = st.selectbox('Apenas Juros', ['not_int'], index=0)
    lump_sum_payment = st.selectbox('Pagamento Único', ['lpsm'], index=0)
    occupancy_type = st.selectbox('Tipo de Ocupação', ['ir'], index=0)
    total_units = st.selectbox('Total de Unidades', ['1U'], index=0)
    credit_type = st.selectbox('Tipo de Crédito', ['CRIF'], index=0)
    co_applicant_credit_type = st.selectbox('Tipo de Crédito do Co-solicitante', ['EXP'], index=0)
    age = st.selectbox('Faixa Etária', ['25-34'], index=0)
    submission_of_application = st.selectbox('Submissão de Aplicação', ['to_inst'], index=0)
    region = st.selectbox('Região', ['North'], index=0)

    if st.button('Verificar'):

        dados = {
            'loan_limit': loan_limit,
            'approv_in_adv': approv_in_adv,
            'loan_type': loan_type,
            'loan_purpose': loan_purpose,
            'Credit_Worthiness': credit_worthiness,
            'Interest_rate_spread': interest_rate_spread,
            'Neg_ammortization': neg_ammortization,
            'interest_only': interest_only,
            'lump_sum_payment': lump_sum_payment,
            'occupancy_type': occupancy_type,
            'total_units': total_units,
            'credit_type': credit_type,
            'co_applicant_credit_type': co_applicant_credit_type,
            'age': age,
            'submission_of_application': submission_of_application,
            'Region': region
        }

#         # TESTE INICIO

#         url_api1 = 'sua_url_da_api'  # Substitua pela URL real da API
#         url_api2 = 'sua_url_da_api'  # Substitua pela URL real da API

#         #resposta1 = requests.post(url_api1, json=dados)
#         #if resposta1.status_code == 200:
#         #    resposta_api1 = resposta1.json()

#         #resposta2 = requests.post(url_api1, json=dados)
#         #if resposta2.status_code == 200:
#         #    resposta_api2 = resposta2.json()

        resposta_api1 = {
            "previsoes": 1
        }
        resposta_api2 = {
            "cluster": 1,
            "fraud_propensity": 0.8179657795,
            "persona": "High Risk"
        }

#         # TESTE FIM

        # Armazenando as respostas para uso na tela de resultado
        st.session_state.resposta_api1 = resposta_api1
        st.session_state.resposta_api2 = resposta_api2

        # Mudando para a tela de resultado
        st.session_state.tela = 'resultado'

def tela_resultado():

    # Recuperando as respostas armazenadas
    resposta_api1 = st.session_state.resposta_api1
    resposta_api2 = st.session_state.resposta_api2

    # Formatando previsões e fraud_propensity para exibição
    fraud_propensity = f"{resposta_api2['fraud_propensity']*100:.2f}%"

    # Exibindo resultados como texto

    if resposta_api1['previsoes'] == 1:
        st.error(f"Propensão à Inadimplência: {resposta_api1['previsoes']} - Sim")
    else:
        st.success(f"Propensão à Inadimplência: {resposta_api1['previsoes']} - Não")

    if resposta_api2['fraud_propensity'] > 0.5:
        st.error(f"Propensão à Fraude: {fraud_propensity} - Alta")
    else:
        st.success(f"Propensão à Fraude: {fraud_propensity} - Baixa")

    st.write(f"Persona: {resposta_api2['persona']}")

    if st.button('Nova Consulta'):
        st.session_state.tela = 'inicio'

# Controlando qual tela mostrar
if st.session_state.tela == 'inicio':
    tela_inicial()
elif st.session_state.tela == 'resultado':
    tela_resultado()