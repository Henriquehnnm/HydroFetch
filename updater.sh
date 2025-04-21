#!/bin/bash

# Script de atualização do Hydrofetch 🌀

LOCAL_SCRIPT="$HOME/.hydrofetch.sh"
REPO_RAW_URL="https://raw.githubusercontent.com/Henriquehnnm/HydroFetch/main/Fetch-scripts/hydrofetch.sh"

echo -e "\033[1;36m Atualizando Hydrofetch...\033[0m"

# Remover o script antigo
echo -e "\033[1;33m Removendo script antigo...\033[0m"
rm -f "$LOCAL_SCRIPT" && echo -e "\033[1;33m Script antigo removido com sucesso!\033[0m"

# Baixar o novo script
echo -e "\033[1;34m Baixando nova versão do script...\033[0m"
wget "$REPO_RAW_URL" -O "$LOCAL_SCRIPT" || {
    echo -e "\033[1;31m Falha ao baixar o script! Verifique sua conexão.\033[0m"
    exit 1
}

# Tornar o script executável
chmod +x "$LOCAL_SCRIPT" && echo -e "\033[1;32m Script baixado e tornado executável com sucesso!\033[0m"

# Mensagem de sucesso
echo -e "\033[1;32m Hydrofetch atualizado com sucesso em ~/.hydrofetch.sh!\033[0m"
