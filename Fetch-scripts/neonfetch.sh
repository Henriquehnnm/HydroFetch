#!/bin/bash

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

# Criar diretório .neonfetch e baixar fonte 👤
NEONFETCH_DIR="$HOME/.neonfetch"
FONT_PATH="$NEONFETCH_DIR/ANSI-Shadow.flf"
mkdir -p "$NEONFETCH_DIR"
if [ ! -f "$FONT_PATH" ]; then
    echo -e "${YELLOW}Baixando a fonte ANSI Shadow...${NC}"
    curl -o "$FONT_PATH" -L "https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf"
fi

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
LOGO=$(figlet -f "$FONT_PATH" "$OS_NAME")

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
echo -e "${MAGENTA}┌─────────────────────────────────────┐${NC}"
printf "${MAGENTA}│${WHITE} $ICON_USER ${MAGENTA}│${WHITE} User:   %-22s ${MAGENTA}│${NC}\n" "$USER"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_HOST ${MAGENTA}│${WHITE} Host:   %-22s ${MAGENTA}│${NC}\n" "$HOST"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_OS ${MAGENTA}│${WHITE} OS:     %-22s ${MAGENTA}│${NC}\n" "$OS"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_KERNEL ${MAGENTA}│${WHITE} Kernel: %-22s ${MAGENTA}│${NC}\n" "$KERNEL"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_DE ${MAGENTA}│${WHITE} DE:     %-22s ${MAGENTA}│${NC}\n" "$DE"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_RAM ${MAGENTA}│${WHITE} RAM:    %-22s ${MAGENTA}│${NC}\n" "$RAM"
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}│${NC}"
printf "${MAGENTA}│${WHITE} $ICON_COLORS${MAGENTA} │${WHITE} Colors: ${RED}${NC}  ${GREEN}${NC}  ${YELLOW}${NC}  ${BLUE}${NC}  ${MAGENTA}${NC}  ${CYAN}${NC}  ${WHITE}${NC}    ${MAGENTA}│${NC}\n"
echo -e "${MAGENTA}└─────────────────────────────────────┘${NC}"
