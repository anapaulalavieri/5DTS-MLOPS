# Use a imagem base do Python
FROM python:3.11-slim

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o código da aplicação para o contêiner
COPY requirements.txt /requirements.txt
COPY . .

# Instala as dependências especificadas no arquivo requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expõe para o HOST algumas portas, por padrão
EXPOSE 5001
EXPOSE 80
EXPOSE 8080

