import streamlit as st
import requests

# Inicializando estado se não existir
if 'tela' not in st.session_state:
    st.session_state.tela = 'inicio'

# Função para exibir a tela inicial
def tela_inicial():
    st.title('Verificador de Propensão de Inadimplência')

    nome = st.text_input('Nome')
    idade = st.number_input('Idade', min_value=18, max_value=100)
    renda = st.number_input('Renda Mensal', min_value=0.0, format='%f')
    historico_credito = st.selectbox('Histórico de Crédito', ['Excelente', 'Bom', 'Regular', 'Ruim'])

    if st.button('Verificar'):
        dados = {
            'nome': nome,
            'idade': idade,
            'renda': renda,
            'historico_credito': historico_credito
        }

        url_api = 'sua_url_da_api'  # Substitua pela URL real da API

        #resposta = requests.post(url_api, json=dados)
        #if resposta.status_code == 200:
        #    resultado = resposta.json()
        #    st.session_state.resultado = resultado['mensagem']
        #    st.session_state.tela = 'resultado'
        #else:
        #    st.error('Erro ao buscar análise de inadimplência.')
        st.session_state.tela = 'resultado'

## Função para exibir a tela de resultado
#def tela_resultado():
#    st.success(f"Resultado: {st.session_state.resultado}")
#    if st.button('Nova Consulta'):
#        st.session_state.tela = 'inicio'

def tela_resultado():
    # Supondo que `resultado` é um dicionário com as chaves `status` e `classificacao`
    #status = st.session_state.resultado['status']
    #classificacao = st.session_state.resultado['classificacao']
    status = 'aprovado'
    classificacao = 'Bom pagador'

    # Exibindo o resultado com o status de aprovação
    if status == 'aprovado':
        st.success(f"Resultado: Aprovado")
    else:
        st.error(f"Resultado: Reprovado")

    # Exibindo a classificação do usuário
    st.write(f"Classificação do usuário: {classificacao}")

    if st.button('Nova Consulta'):
        st.session_state.tela = 'inicio'


# Controlando qual tela mostrar
if st.session_state.tela == 'inicio':
    tela_inicial()
elif st.session_state.tela == 'resultado':
    tela_resultado()