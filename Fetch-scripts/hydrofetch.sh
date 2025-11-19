#!/usr/bin/env bash

# Versão
VERSION="2.4.4"

# Cores
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # Sem cor

# Mostrar ajuda
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo -e "${CYAN}\nUso: $(basename "$0") [opção]${NC}"
  echo ""
  echo -e "${GREEN}Opções disponíveis:${NC}"
  echo -e "  ${YELLOW}--help, -h${NC}         Mostra esta mensagem de ajuda"
  echo -e "  ${YELLOW}--version, -v${NC}      Mostra a versão do HydroFetch"
  echo -e "  ${YELLOW}--min, -m${NC}          Mostra as informações em modo mínimo"
  echo -e "  ${YELLOW}--all, -a${NC}          Mostra todas as informações do sistema completas"
  echo -e "  ${YELLOW}--tux${NC}              Mostra um easter egg do Tux"
  echo -e "\n${GREEN}Ajuda:${NC}"
  echo -e "  ${YELLOW}Fonte Customizada${NC}  Para instalar uma fonte customizada, basta colocar o arquivo Custom.flf na pasta ~/.hydrofetch"
  echo -e "  ${YELLOW}Repositório${NC}        ${BLUE}https://github.com/Henriquehnnm/HydroFetch${NC}"
  echo ""
  exit 0
fi

# Mostrar versão
if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    echo -e "  \nHydroFetch ${YELLOW}${VERSION}${NC} created by ${BLUE}Henriquehnnm${NC}"
    exit 0
fi

# Verificar e instalar dependencias
if ! command -v figlet &>/dev/null; then
  echo -e "${YELLOW}Figlet não encontrado. Instalando...${NC}"
  if command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get install -y figlet
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y figlet
  elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm figlet inetutils
  elif command -v zypper &>/dev/null; then
    sudo zypper refresh
    sudo zypper --non-interactive install figlet
  elif command -v apk &>/dev/null; then
    sudo apk add figlet
  else
    echo -e "${RED}Gerenciador de pacotes não suportado! Instale o Figlet manualmente.${NC}"
    exit 1
  fi
fi

# Easter Egg --tux
if [[ "$1" == "--tux" ]]; then
  echo -e "${CYAN}O grande Tux...${NC}"
  echo -e "${BLUE}"
  cat <<'EOF'
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

# Criar diretório .hydrofetch
HYDROFETCH_DIR="$HOME/.hydrofetch"
FONT_PATH="$HYDROFETCH_DIR/Custom.flf"
mkdir -p "$HYDROFETCH_DIR"

# Mostrar todas as infos com --all
if [[ "$1" == "-a" || "$1" == "--all" ]]; then
  echo -e "${MAGENTA}"
  figlet "InfoSistema"
  echo -e "${NC}"
  echo -e "${CYAN}===================== INFORMAÇÕES DO SISTEMA =====================${NC}"
  echo ""
  echo "Este computador se chama: $(hostname)"
  echo "Ele está usando a distribuição: $(source /etc/os-release && echo "$NAME $VERSION")"
  echo "O kernel do sistema está na versão: $(uname -r)"
  echo "A arquitetura da máquina é: $(uname -m), o que diz se ela é 64-bits ou não"
  echo "E o tipo de sistema operacional é: $(uname -o)"
  echo ""

  echo -e "${CYAN}===================== CPU =====================${NC}"
  echo ""
  cpu_model=$(grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ //')
  cpu_cores=$(grep -c ^processor /proc/cpuinfo)
  echo "O processador deste sistema é: ${cpu_model}"
  echo "Ele tem um total de: ${cpu_cores} núcleos"
  echo ""

  echo -e "${CYAN}===================== MEMÓRIA =====================${NC}"
  echo ""
  mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  mem_total_mb=$((mem_total / 1024))
  echo "Este computador tem um total de ${mem_total_mb} MB de memória RAM disponível"
  echo ""

  echo -e "${CYAN}===================== DISCO =====================${NC}"
  echo ""
  echo "Aqui estão os detalhes dos dispositivos de armazenamento montados, com seus tamanhos e usos:"
  echo ""
  df -h --output=source,fstype,size,used,avail,pcent,target | grep -v tmpfs | grep -v loop | while read linha; do
    echo "$linha"
  done
  echo ""

  echo -e "${CYAN}===================== USUÁRIO =====================${NC}"
  echo ""
  echo "O usuário logado agora é: $USER"
  echo "E seu diretório home é: $HOME"
  echo ""

  echo -e "${CYAN}===================== UPTIME =====================${NC}"
  echo ""
  echo "O sistema está ligado há: $(uptime -p)"
  echo ""

  echo -e "${CYAN}===================== REDE =====================${NC}"
  echo ""

  # Pega a interface de rede padrão
  interface=$(ip route | grep default | awk '{print $5}')

  # Pega o endereço IP associado à interface de rede
  ipaddr=$(ip -o -4 addr show "$interface" | awk '{print $4}' | cut -d/ -f1)

  echo "O endereço IP da máquina é: ${ipaddr:-Não encontrado}"
  echo "E a interface de rede padrão é: ${interface:-Desconhecida}"
  echo ""

  exit 0
fi

# Nerd Font Icons (Certifique-se de ter uma fonte Nerd Font instalada!)
ICON_USER=" "
ICON_HOST="󰖟 "
ICON_OS="󰌽 "
ICON_KERNEL=" "
ICON_DE="󰍹 "
ICON_RAM=" "
ICON_COLORS=" "

# Nome da Distro com Figlet
OS_NAME=$(grep -E '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [ -f "$FONT_PATH" ]; then
  echo -e "${CYAN}" # Exibe em ciano
  figlet -f "$FONT_PATH" "$OS_NAME"
else
  echo -e "${CYAN}" # Exibe em ciano
  figlet "$OS_NAME"
fi

# Informações do sistema
USER="$(whoami)"
HOST="$(hostname)"
OS="$OS_NAME"
KERNEL="$(uname -r)"
DE="${XDG_CURRENT_DESKTOP:-N/A}"
RAM=$(free -h --si | awk 'NR==2 {print $3 " / " $2}')

# Min mode
if [[ "$1" == "-m" || "$1" == "--min" ]]; then
    echo -e "${RED}${OS}${NC} • ${YELLOW}${USER}${NC} • ${GREEN}${DE}${NC} "
    exit 0
fi

# Exibir o logo
echo -e "$CYAN$LOGO$NC"

# Exibir informações dentro de uma única caixa
echo -e "${MAGENTA}╭──────────────────────────────────────────╮${NC}"
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
echo -e "${MAGENTA}│    ${MAGENTA}│${WHITE}                                ${MAGENTA}     │${NC}"
printf "${MAGENTA}│${WHITE} $ICON_COLORS${MAGENTA} │${WHITE} Colors: ${RED} ${NC}  ${GREEN} ${NC}  ${YELLOW} ${NC}  ${BLUE} ${NC}  ${MAGENTA} ${NC}  ${CYAN} ${NC}  ${WHITE} ${NC}  ${MAGENTA}│${NC}\n"
echo -e "${MAGENTA}╰──────────────────────────────────────────╯${NC}"
