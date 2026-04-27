#!/bin/bash

echo "=========================================="
echo "🚀 Instalando Vivian ERP..."
echo "=========================================="

# 1. Instalar dependências (Java 21 e PostgreSQL)
echo "[1/4] Instalando Java e PostgreSQL..."
sudo apt update
sudo apt install -y openjdk-21-jdk postgresql postgresql-contrib git

# 2. Configurar o Banco de Dados
echo "[2/4] Configurando Banco de Dados (vivian_erp)..."
sudo -u postgres psql -c "CREATE USER lucas WITH PASSWORD 'lucas';"
sudo -u postgres psql -c "CREATE DATABASE vivian_erp OWNER lucas;"

# 3. Compilar a aplicação
echo "[3/4] Compilando o projeto com Maven..."
chmod +x mvnw
./mvnw clean package -DskipTests

# Encontrar o .jar gerado
JAR_PATH=$(find target -name "*.jar" | head -n 1)
CURRENT_DIR=$(pwd)

# 4. Criar serviço no systemd (Para rodar em background automaticamente)
echo "[4/4] Configurando serviço de background..."
sudo bash -c "cat > /etc/systemd/system/vivian-erp.service <<EOF
[Unit]
Description=Vivian ERP Spring Boot App
After=postgresql.service

[Service]
User=$USER
WorkingDirectory=$CURRENT_DIR
ExecStart=/usr/bin/java -jar $CURRENT_DIR/${JAR_PATH#./}
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF"

# Iniciar o serviço
sudo systemctl daemon-reload
sudo systemctl enable vivian-erp
sudo systemctl start vivian-erp

IP_LOCAL=$(hostname -I | awk '{print $1}')
echo "=========================================="
echo "✅ Instalação Concluída com Sucesso!"
echo "🌐 Acesse a aplicação em qualquer PC da rede local:"
echo "👉 http://$IP_LOCAL:8080"
echo "=========================================="