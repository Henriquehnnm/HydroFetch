#!/usr/bin/env fish

# Versão
set VERSION "2.5.2 Fish Edition"

# Criar diretórios e path's
# Dirs
set HYDROFETCH_DIR "$HOME/.config/hydrofetch"
set PLUGINS_DIR "$HYDROFETCH_DIR/Plugins"
set LOCAL_DIR "$HOME/.local/share/hydrofetch/"

# Path's
set CONFIG_PATH "$HYDROFETCH_DIR/Config.json"
set LOGOS_PATH "$PLUGINS_DIR/Logos.json"
set FONT_PATH "$HYDROFETCH_DIR/Custom.flf"

# Mkdir
mkdir -p "$HYDROFETCH_DIR"
mkdir -p "$PLUGINS_DIR"

if test -f $CONFIG_PATH
    and test -s $CONFIG_PATH
    set ICON_USER (jq -r '.ICON_USER // " "' $CONFIG_PATH)
    set ICON_HOST (jq -r '.ICON_HOST // "󰖟 "' $CONFIG_PATH)
    set ICON_OS (jq -r '.ICON_OS // "󰌽 "' $CONFIG_PATH)
    set ICON_KERNEL (jq -r '.ICON_KERNEL // " "' $CONFIG_PATH)
    set ICON_DE (jq -r '.ICON_DE // "󰍹 "' $CONFIG_PATH)
    set ICON_RAM (jq -r '.ICON_RAM // " "' $CONFIG_PATH)
    set ICON_COLORS (jq -r '.ICON_COLORS // " "' $CONFIG_PATH)
else
    set ICON_USER " "
    set ICON_HOST "󰖟 "
    set ICON_OS "󰌽 "
    set ICON_KERNEL " "
    set ICON_DE "󰍹 "
    set ICON_RAM " "
    set ICON_COLORS " "
end

# Cores
set RED '\033[1;31m'
set GREEN '\033[1;32m'
set YELLOW '\033[1;33m'
set BLUE '\033[1;34m'
set MAGENTA '\033[1;35m'
set CYAN '\033[1;36m'
set WHITE '\033[1;37m'
set NC '\033[0m'

# Língua
set LANG_CODE (string split '.' $LANG | head -n1)
set TRANSLATIONS_FILE "$LOCAL_DIR/translations/$LANG_CODE.json"

if test -f $TRANSLATIONS_FILE
    for key in (jq -r 'keys[]' $TRANSLATIONS_FILE)
        set -g $key (jq -r ".$key" $TRANSLATIONS_FILE)
    end
else
    ## Help
    set HF_HELP_USAGE 'Usage:'
    set HF_HELP_OPTION '[option]'
    set HF_HELP_OPTIONS "Available options:"
    set HF_HELP_SHOW_HELP "Show this help message"
    set HF_HELP_SHOW_VERSION "Shows the HydroFetch version"
    set HF_HELP_MINIMAL_MODE "Shows information in minimal mode"
    set HF_HELP_ALL_INFO "Shows all complete system information"
    set HF_HELP_HELP "Help:"
    set HF_HELP_CUSTOM_FONT_TITLE "Custom fonts"
    set HF_HELP_CUSTOM_FONT "To install a custom font, simply place the Custom.flf file in the ~/.config/hydorfetch folder"
    set HF_HELP_REPOSITORY "Repository"

    ## Msg
    set HF_MSG_DEPS_NOT_FOUND "Dependencies not found, install figlet and jq"

    ## Infos
    set HF_INFO_SI_TITLE "SYSTEM INFORMATION"
    set HF_INFO_HOSTNAME "Hostname"
    set HF_INFO_OS "Operating system"
    set HF_INFO_KERNEL "Kernel Version"
    set HF_INFO_ARCH "Architecture"
    set HF_INFO_OS_TYPE "Operating system type"

    set HF_INFO_CPU_GPU_TITLE "CPU and GPU"
    set HF_INFO_CPU "CPU"
    set HF_INFO_CPU_CORES "CPU cores"
    set HF_INFO_GPU "GPU"

    set HF_INFO_MEMORY_TITLE "MEMORY"
    set HF_INFO_RAM "RAM memory"

    set HF_INFO_USER_TITLE "USER"
    set HF_INFO_USER "User"
    set HF_INFO_HOME "Home"

    set HF_INFO_UPTIME_TITLE "UPTIME"
    set HF_INFO_UPTIME "The system has been on for"

    set HF_INFO_NETWORK_TITLE "NETWORK"
    set HF_INFO_IP "IP"
    set HF_INFO_NETWORK "Network Interface"
end

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

    echo -e "$CYAN\n$HF_HELP_USAGE $SCRIPT_NAME $HF_HELP_OPTION$NC"
    echo ""
        echo -e "$GREEN$HF_HELP_OPTIONS$NC"
        echo -e "  $YELLOW--help, -h$NC          $HF_HELP_SHOW_HELP"
        echo -e "  $YELLOW--version, -v$NC       $HF_HELP_SHOW_VERSION"
        echo -e "  $YELLOW--min, -m$NC           $HF_HELP_MINIMAL_MODE"
        echo -e "  $YELLOW--all, -a$NC           $HF_HELP_ALL_INFO"
        echo -e "\n$GREEN$HF_HELP_HELP$NC"
        echo -e "  $YELLOW$HF_HELP_CUSTOM_FONT_TITLE$NC  $HF_HELP_CUSTOM_FONT"
        echo -e "  $YELLOW$HF_HELP_REPOSITORY$NC       $BLUE   https://github.com/Henriquehnnm/HydroFetch$NC"
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
    or command -v git &>/dev/null
    or command -v jq &>/dev/null
    or command -v wget &>/dev/null
    echo -e "$YELLOW $HF_MSG_DEPS_NOT_FOUND."
    exit 1
end

# Mostrar todas as infos com --all
if test "$argv[1]" = "-a"
    or test "$argv[1]" = "--all"
    echo -e "$MAGENTA"
    figlet "InfoSystem"
    echo -e "$NC"

    echo -e "$CYAN──────────────────── $HF_INFO_SI_TITLE ────────────────────$NC"
    echo ""
    echo "$HF_INFO_HOSTNAME: $HOST"
    echo "$HF_INFO_OS: $OS"
    echo "$HF_INFO_KERNEL: $(uname -r)"
    echo "$HF_INFO_ARCH: $(uname -m)"
    echo "$HF_INFO_OS_TYPE: $(uname -o)"
    echo ""

    echo -e "$CYAN──────────────────── $HF_INFO_CPU_GPU_TITLE ────────────────────$NC"
    echo ""
    set cpu_model (grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2 | sed 's/^ //')
    set cpu_cores (grep -c ^processor /proc/cpuinfo)
    set gpu_model (lspci | grep -i vga)
    echo "$HF_INFO_CPU: $cpu_model"
    echo "$HF_INFO_CPU_CORES: $cpu_cores"
    echo "$HF_INFO_GPU: $gpu_model"
    echo ""

    echo -e "$CYAN──────────────────── $HF_INFO_MEMORY_TITLE ────────────────────$NC"
      echo ""
      set mem_total (grep MemTotal /proc/meminfo | awk '{print $2}')
      set mem_total_mb (math "$mem_total / 1024")
      echo "$HF_INFO_RAM: $mem_total_mb mb"
      echo ""

      echo -e "$CYAN─────────────────── $HF_INFO_USER_TITLE ────────────────────$NC"
      echo ""
      echo -e "$HF_INFO_USER: $USER"
      echo "$HF_INFO_HOME: $HOME"
      echo ""

      echo -e "$CYAN──────────────────── $HF_INFO_UPTIME_TITLE ────────────────────$NC"
      echo ""
      echo "$HF_INFO_UPTIME: $(uptime -p)"
      echo ""

      echo -e "$CYAN──────────────────── $HF_INFO_NETWORK_TITLE ────────────────────$NC"
      echo ""

      # Pega a interface de rede padrão
      set interface (ip route | grep default | awk '{print $5}'; or echo N/A)

      # Pega o endereço IP associado à interface de rede
      set ipaddr (ip -o -4 addr show $interface | awk '{print $4}' | cut -d/ -f1; or echo N/A)

      echo "$HF_INFO_IP: $(string replace -r '^$' N/A $ipaddr)"
      echo "$HF_INFO_NETWORK: $(string replace -r '^$' N/A $interface)"
      echo ""

      exit 0
end

# Min mode
if test "$argv[1]" = '-m'
    or test "$argv[1]" = '--min'
        echo -e "$RED $OS $NC•$YELLOW $USER $NC•$GREEN $DE $NC "
    exit 0
end


if test -f $LOGOS_PATH

    set LOGO (jq -r --arg os_name "$OS" '.[$os_name] // .Tux // [] | .[]' "$LOGOS_PATH")
    set -p LOGO ""

    if test -n "$LOGO"
        set BOX_LINES
        set -a BOX_LINES (printf "$MAGENTA╭──────────────────────────────────────────╮$NC")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_USER $MAGENTA│$WHITE User:   %-22s $MAGENTA     │$NC" "$USER")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_HOST $MAGENTA│$WHITE Host:   %-22s $MAGENTA     │$NC" "$HOST")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_OS $MAGENTA│$WHITE OS:     %-22s $MAGENTA     │$NC" "$OS")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_KERNEL $MAGENTA│$WHITE Kernel: %-22s $MAGENTA     │$NC" "$KERNEL")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_DE $MAGENTA│$WHITE DE:     %-22s $MAGENTA     │$NC" "$DE")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_RAM $MAGENTA│$WHITE RAM:    %-22s $MAGENTA     │$NC" "$RAM")
        set -a BOX_LINES (printf " $MAGENTA│$WHITE $ICON_COLORS$MAGENTA │$WHITE Colors: $RED $NC  $GREEN $NC  $YELLOW $NC  $BLUE $NC  $MAGENTA $NC  $CYAN $NC  $WHITE $NC  $MAGENTA│$NC")
        set -a BOX_LINES (printf "$MAGENTA╰──────────────────────────────────────────╯$NC")

        set LOGO_COUNT (count $LOGO)
        set BOX_COUNT (count $BOX_LINES)

        set MAX_LINES (math "max($LOGO_COUNT, $BOX_COUNT)")

        # Loop sincronizado
        for i in (seq 1 $MAX_LINES)
            if test $i -le $LOGO_COUNT
                set LOGO_LINE $LOGO[$i]
                if test -z "$LOGO_LINE"
                    set LOGO_LINE (printf "%-21s" "")
                end
            else
                set LOGO_LINE (printf "%-21s" "")
            end

            if test $i -le $BOX_COUNT
                set BOX_LINE $BOX_LINES[$i]
            else
                set BOX_LINE ""
            end

            echo -e "$CYAN$LOGO_LINE$NC$BOX_LINE"
        end
        exit 0
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
