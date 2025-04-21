#!/bin/bash

# Suporte ao argumento --update 💧🛠️
if [[ "$1" == "--update" ]]; then
    echo -e "\033[1;36m Atualizando Hydrofetch...\033[0m"

    HYDRO_DIR="$HOME/.hydrofetch"
    LOCAL_SCRIPT="$HOME/.hydrofetch.sh"
    REPO_RAW_URL="https://raw.githubusercontent.com/Henriquehnnm/HydroFetch/main/Fetch-scripts/hydrofetch.sh"

    if command -v wget >/dev/null 2>&1; then
        echo -e "\033[1;34m Wget encontrado! Continuando...\033[0m"
    else
        echo -e "\033[1;31m O comando 'wget' não está instalado! Por favor, instale-o primeiro.\033[0m"
        exit 1
    fi

    if [[ -d "$HYDRO_DIR" && -d "$HYDRO_DIR/.git" ]]; then
        echo -e "\033[1;34m Atualizando via git...\033[0m"
        cd "$HYDRO_DIR" || {
            echo -e "\033[1;31m Não consegui acessar o diretório ~/.hydrofetch!\033[0m"
            exit 1
        }

        git pull origin main || {
            echo -e "\033[1;31m Erro ao atualizar com git!\033[0m"
            exit 1
        }

        echo -e "\033[1;32m Atualizado com sucesso via git!\033[0m"
    else
        echo -e "\033[1;33m Hydrofetch não foi clonado com git. Usando wget para atualizar...\033[0m"

        echo -e "\033[1;34m Baixando nova versão do script...\033[0m"
        wget -c "$REPO_RAW_URL" -O "$LOCAL_SCRIPT" || {
            echo -e "\033[1;31m Falha ao baixar o script! Verifique sua conexão.\033[0m"
            exit 1
        }

        chmod +x "$LOCAL_SCRIPT"
        echo -e "\033[1;32m Script atualizado com sucesso em ~/.hydrofetch.sh!\033[0m"
    fi

    exit 0
fi


# Cores 🌈
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # Sem cor

# Verificar e instalar Figlet 🚀
if ! command -v figlet &> /dev/null; then
    echo -e "${YELLOW}Figlet não encontrado. Instalando...${NC}"
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y figlet
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y figlet
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm figlet
    elif command -v apk &> /dev/null; then
        sudo apk add figlet
    else
        echo -e "${RED}Gerenciador de pacotes não suportado! Instale o Figlet manualmente.${NC}"
        exit 1
    fi
fi

# Easter Egg --tux 🐧
if [[ "$1" == "--tux" ]]; then
    echo -e "${CYAN}Invocando o grande Tux...${NC}"
    echo -e "${BLUE}"
    cat << 'EOF'
         .--.
        |o_o |
        |:_/ |
       //   \ \
      (|     | )
     /'\_   _/`\
     \___)=(___/
EOF
    echo -e "${NC}"
    exit 0
fi

# Criar diretório .hydrofetch 👤
HYDROFETCH_DIR="$HOME/.hydrofetch"
FONT_PATH="$HYDROFETCH_DIR/Custom.flf"
mkdir -p "$HYDROFETCH_DIR"

# 🎭 Nerd Font Icons (Certifique-se de ter uma fonte Nerd Font instalada!)
ICON_USER=" "
ICON_HOST="󰖟 "
ICON_OS="󰌽 "
ICON_KERNEL=" "
ICON_DE="󰍹 "
ICON_RAM=" "
ICON_COLORS=" "

# Nome da Distro com Figlet 🎯
OS_NAME=$(grep -E '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [ -f "$FONT_PATH" ]; then
    echo -e "${CYAN}"  # Exibe em ciano
    figlet -f "$FONT_PATH" "$OS_NAME"
else
    echo -e "${CYAN}"  # Exibe em ciano
    figlet "$OS_NAME"
fi

# Informações do sistema 📊
USER="$(whoami)"
HOST="$(hostname)"
OS="$OS_NAME"
KERNEL="$(uname -r)"
DE="${XDG_CURRENT_DESKTOP:-N/A}"
RAM=$(free -h --si | awk 'NR==2 {print $3 " / " $2}')

# Exibir o logo
echo -e "$CYAN$LOGO$NC"

# Exibir informações dentro de uma única caixa 🏰
echo -e "${MAGENTA}┌──────────────────────────────────────────┐${NC}"
printf "${MAGENTA}│${WHITE} $ICON_USER ${MAGENTA}│${WHITE} User:   %-22s ${MAGENTA}     │${NC}\n" "$USER"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_HOST ${MAGENTA}│${WHITE} Host:   %-22s ${MAGENTA}     │${NC}\n" "$HOST"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_OS ${MAGENTA}│${WHITE} OS:     %-22s ${MAGENTA}     │${NC}\n" "$OS"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_KERNEL ${MAGENTA}│${WHITE} Kernel: %-22s ${MAGENTA}     │${NC}\n" "$KERNEL"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_DE ${MAGENTA}│${WHITE} DE:     %-22s ${MAGENTA}     │${NC}\n" "$DE"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_RAM ${MAGENTA}│${WHITE} RAM:    %-22s ${MAGENTA}     │${NC}\n" "$RAM"
echo -e "${MAGENTA}└──────────────────────────────────────────┘${NC}"
