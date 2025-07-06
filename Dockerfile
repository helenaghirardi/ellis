# 1. Imagem Base
# Utiliza uma imagem oficial do Python. A tag 'slim' é uma versão menor,
# ideal para produção pois reduz o tamanho final da imagem.
FROM python:3.10-slim

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner. Todos os comandos
# subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Instalação de Dependências
# Copia o arquivo de dependências primeiro e instala os pacotes.
# Isso aproveita o cache do Docker: se o requirements.txt não mudar,
# esta camada não será reconstruída, acelerando o processo de build.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar Código da Aplicação
COPY . .

# 5. Comando de Execução
# Define o comando para iniciar a aplicação com Uvicorn.
# O host '0.0.0.0' é essencial para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

