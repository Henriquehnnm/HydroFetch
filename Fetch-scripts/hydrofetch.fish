#!/usr/bin/env fish

# Versão
set VERSION "2.4.8 Fish Edition"

# Cores
set RED '\033[1;31m'
set GREEN '\033[1;32m'
set YELLOW '\033[1;33m'
set BLUE '\033[1;34m'
set MAGENTA '\033[1;35m'
set CYAN '\033[1;36m'
set WHITE '\033[1;37m'
set NC '\033[0m'

# Informações do sistema
set USER (whoami)
set HOST $hostname
set OS (grep -E '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
set KERNEL (uname -r)
set DE (string replace -r '^$' N/A (set -q XDG_CURRENT_DESKTOP; and echo $XDG_CURRENT_DESKTOP; or echo N/A))
set RAM (free -h --si | awk 'NR==2 {print $3 " / " $2}')

# Mostrar ajuda
if test "$argv[1]" = "-h"
   or test "$argv[1]" = "--help"

   set -l SCRIPT_NAME (basename (status current-filename))

    echo -e "$CYAN\nUsage: $SCRIPT_NAME [option]$NC"
    echo ""
        echo -e "$GREEN Available options:$NC"
        echo -e "  $YELLOW--help, -h$NC          Show this help message"
        echo -e "  $YELLOW--version, -v$NC       Shows the HydroFetch version"
        echo -e "  $YELLOW--min, -m$NC           Shows information in minimal mode"
        echo -e "  $YELLOW--all, -a$NC           Shows all complete system information"
        echo -e "\n$GREEN Help:$NC"
        echo -e "  $YELLOW Custom fonts$NC  To install a custom font, simply place the Custom.flf file in the ~/.hydrofetch folder"
        echo -e "  $YELLOW Repository$NC       $BLUE https://github.com/Henriquehnnm/HydroFetch$NC"
        echo ""
        exit 0
end

# Mostrar versão
if test "$argv[1]" = "-v"
    or test "$argv[1]" = "--version"
    echo -e "  \nHydroFetch $YELLOW$VERSION$NC created by$BLUE Henriquehnnm$NC"
    exit 0
end

# Verificar e instalar dependencias
if not command -v figlet &>/dev/null
    echo -e "$YELLOW Dependencies not found. Installing..."

    if command -v apt &>/dev/null
        sudo apt-get update && sudo apt-get install -y figlet jq
    else if command -v dnf &>/dev/null
        sudo dnf install -y figlet jq
    else if command -v pacman &>/dev/null
        sudo pacman -Sy --noconfirm figlet inetutils jq
    else if command -v zypper &>/dev/null
        sudo zypper refresh
        sudo zypper --non-interactive install figlet jq
    else if command -v apk &>/dev/null
        sudo apk add figlet jq
    else
       echo -e "$RED Package manager not supported! Install dependencies manually. (Figlet, jq and inetutils for arch)"
    end
end

# Mostrar todas as infos com --all
if test "$argv[1]" = "-a"
    or test "$argv[1]" = "--all"
    echo -e "$MAGENTA"
    figlet "InfoSystem"
    echo -e "$NC"

    echo -e "$CYAN──────────────────── SYSTEM INFORMATION ────────────────────$NC"
    echo ""
    echo "Hostname: $HOST"
    echo "Operating system: $OS"
    echo "Kernel Version: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Operating system type: $(uname -o)"
    echo ""

    echo -e "$CYAN──────────────────── CPU and GPU ────────────────────$NC"
    echo ""
    set cpu_model (grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ //')
    set cpu_cores (grep -c ^processor /proc/cpuinfo)
    set gpu_model (lspci | grep -i vga)
    echo "CPU: $cpu_model"
    echo "CPU cores: $cpu_cores"
    echo "GPU: $gpu_model"
    echo ""

    echo -e "$CYAN──────────────────── MEMORY ────────────────────$NC"
      echo ""
      set mem_total (grep MemTotal /proc/meminfo | awk '{print $2}')
      set mem_total_mb (math "$mem_total / 1024")
      echo "RAM memory: $mem_total_mb mb"
      echo ""

      echo -e "$CYAN─────────────────── USUÁRIO ────────────────────$NC"
      echo ""
      echo -e "User: $USER"
      echo "Home: $HOME"
      echo ""

      echo -e "$CYAN──────────────────── UPTIME ────────────────────$NC"
      echo ""
      echo "The system has been on for: $(uptime -p)"
      echo ""

      echo -e "$CYAN──────────────────── REDE ────────────────────$NC"
      echo ""

      # Pega a interface de rede padrão
      set interface (ip route | grep default | awk '{print $5}'; or echo N/A)

      # Pega o endereço IP associado à interface de rede
      set ipaddr (ip -o -4 addr show $interface | awk '{print $4}' | cut -d/ -f1; or echo N/A)

      echo "IP: $(string replace -r '^$' N/A $ipaddr)"
      echo "Network Interface: $(string replace -r '^$' N/A $interface)"
      echo ""

      exit 0
end

# Criar diretório ~/.hydrofetch
# Dirs
set HYDROFETCH_DIR "$HOME/.hydrofetch"
set PLUGINS_DIR "$HYDROFETCH_DIR/Plugins"

# Path's
set LOGOS_PATH "$PLUGINS_DIR/Logos.json"
set FONT_PATH "$HYDROFETCH_DIR/Custom.flf"

# Mkdir
mkdir -p "$HYDROFETCH_DIR"
mkdir -p "$PLUGINS_DIR"

set ICON_USER " "
set ICON_HOST "󰖟 "
set ICON_OS "󰌽 "
set ICON_KERNEL " "
set ICON_DE "󰍹 "
set ICON_RAM " "
set ICON_COLORS " "

if test -f $LOGOS_PATH

    set LOGO (jq -r --arg os_name "$OS" '.[$os_name] // [] | .[]' "$LOGOS_PATH")

    if test -n "$LOGO"
        for line in $LOGO
            echo -e "$CYAN$line$NC"
        end
    else
        if test -f $FONT_PATH
            echo -e "$CYAN"
            figlet -f "$FONT_PATH" "$OS"
            echo -e "$NC"
        else
            echo -e "$CYAN"
            figlet "$OS"
            echo -e "$NC"
        end
    end

else
    if test -f $FONT_PATH
        echo -e "$CYAN"
        figlet -f "$FONT_PATH" "$OS"
        echo -e "$NC"
    else
        echo -e "$CYAN"
        figlet "$OS"
        echo -e "$NC"
    end
end

# Min mode
if test "$argv[1]" = '-m'
    or test "$argv[1]" = '--min'

    if test -f $LOGOS_PATH
        echo -e "\n$RED $OS $NC•$YELLOW $USER $NC•$GREEN $DE $NC "
    else
        echo -e "$RED $OS $NC•$YELLOW $USER $NC•$GREEN $DE $NC "
    end

    exit 0
end

# Exibir informações dentro de uma única caixa
echo -e "$MAGENTA╭──────────────────────────────────────────╮$NC"
printf "$MAGENTA│$WHITE $ICON_USER $MAGENTA│$WHITE User:   %-22s $MAGENTA     │$NC\n" "$USER"
printf "$MAGENTA│$WHITE $ICON_HOST $MAGENTA│$WHITE Host:   %-22s $MAGENTA     │$NC\n" "$HOST"
printf "$MAGENTA│$WHITE $ICON_OS $MAGENTA│$WHITE OS:     %-22s $MAGENTA     │$NC\n" "$OS"
printf "$MAGENTA│$WHITE $ICON_KERNEL $MAGENTA│$WHITE Kernel: %-22s $MAGENTA     │$NC\n" "$KERNEL"
printf "$MAGENTA│$WHITE $ICON_DE $MAGENTA│$WHITE DE:     %-22s $MAGENTA     │$NC\n" "$DE"
printf "$MAGENTA│$WHITE $ICON_RAM $MAGENTA│$WHITE RAM:    %-22s $MAGENTA     │$NC\n" "$RAM"
printf "$MAGENTA│$WHITE $ICON_COLORS$MAGENTA │$WHITE Colors: $RED $NC  $GREEN $NC  $YELLOW $NC  $BLUE $NC  $MAGENTA $NC  $CYAN $NC  $WHITE $NC  $MAGENTA│$NC\n"
echo -e "$MAGENTA╰──────────────────────────────────────────╯$NC"
