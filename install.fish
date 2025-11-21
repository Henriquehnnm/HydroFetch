#!/usr/bin/env fish

# Cores
set RED '\033[1;31m'
set GREEN '\033[1;32m'
set YELLOW '\033[1;33m'
set BLUE '\033[1;34m'
set MAGENTA '\033[1;35m'
set CYAN '\033[1;36m'
set WHITE '\033[1;37m'
set NC '\033[0m'

echo -e "$BLUE == HYDROFETCH INSTALL == $NC"

# Verificar e instalar dependencias
if not command -v figlet &>/dev/null
    and command -v git &>/dev/null
    and command -v jq &>/dev/null
    and command -v wget &>/dev/null
    echo -e "$YELLOW Dependencies not found, installing...$NC"

    if command -v apt &>/dev/null
        sudo apt-get update && sudo apt-get install -y figlet jq wget git
    else if command -v dnf &>/dev/null
        sudo dnf install -y figlet jq wget git
    else if command -v pacman &>/dev/null
        sudo pacman -Sy --noconfirm figlet inetutils jq wget git
    else if command -v zypper &>/dev/null
        sudo zypper refresh
        sudo zypper --non-interactive install figlet jq wget git
    else if command -v apk &>/dev/null
        sudo apk add figlet jq wget git
    else
       echo -e "$RED Package manager not found, install dependencies manually.$NC"
    end
end

set HF_PATH "$HOME/.hydrofetch.fish"
set BIN "$HOME/.local/bin/"
set BIN_PATH "$BIN/hf"
set LOCAL_DIR "$HOME/.local/share/hydrofetch/"

# baixa o hydrofetch
echo -e "$YELLOW Starting the download... $NC."
wget https://raw.githubusercontent.com/Henriquehnnm/HydroFetch/main/src/hydrofetch.fish -O $HF_PATH
if test $status != 0
    echo -e "$RED Something went wrong :( $NC"
    exit 1
else
    echo -e "$GREEN Download completed $NC"
end

echo -e "$YELLOW Giving execution permission... $NC"
chmod +x $HF_PATH
if test $status != 0
    echo -e "$RED Something went wrong :( $NC"
    exit 1
else
   echo -e "$GREEN Execution granted $NC"
end

echo -e "$YELLOW Creating links to facilitate execution... $NC"
if test -f $BIN_PATH
    mkdir -p $BIN
    ln -sf $HF_PATH $BIN_PATH
else
    mkdir -p $BIN
    ln -s $HF_PATH $BIN_PATH
end
if test $status != 0
    echo -e "$RED Something went wrong :( $NC"
    exit 1
else
    echo -e "$GREEN Link created $NC"
end

if not test -d $LOCAL_DIR/translations
    echo -e "$YELLOW Downloading language pack... $NC"
    mkdir -p $LOCAL_DIR
    git clone https://github.com/Henriquehnnm/HydroFetch-translations.git --depth 1 "$LOCAL_DIR/translations"
    if test $status != 0
        echo -e "$RED Something went wrong :( $NC"
        exit 1
    else
        echo -e "$GREEN Downloaded language pack $NC"
    end
end

echo -e "$YELLOW Finishing the installation... $NC"
set -U fish_user_paths $BIN $fish_user_paths
if test $status != 0
    echo -e "$RED Something went wrong :( $NC"
    exit 1
else
    echo -e "$GREEN Installation finished! restart terminal and rose $BLUE hf $GREEN to run hydrofetch :) $NC"
end
