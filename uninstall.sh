#!/bin/bash

echo "=========================================="
echo "🗑️ Desinstalando Vivian ERP..."
echo "=========================================="

# 1. Parar e remover o serviço
echo "Parando a aplicação..."
sudo systemctl stop vivian-erp
sudo systemctl disable vivian-erp
sudo rm /etc/systemd/system/vivian-erp.service
sudo systemctl daemon-reload

# 2. Remover o banco de dados (Opcional e com aviso)
read -p "⚠️ Deseja APAGAR o banco de dados 'vivian_erp' e todos os registros de clientes/OS? (s/n): " resp
if [ "$resp" = "s" ]; then
    echo "Removendo banco de dados..."
    sudo -u postgres psql -c "DROP DATABASE vivian_erp;"
    sudo -u postgres psql -c "DROP USER lucas;"
    echo "✅ Banco de dados removido."
else
    echo "✅ Banco de dados mantido intacto."
fi

echo "=========================================="
echo "✅ Desinstalação do sistema concluída!"
echo "O código fonte ainda está nesta pasta. Você pode apagá-la manualmente com 'cd .. && rm -rf Cambi'."
echo "=========================================="