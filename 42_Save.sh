#!/bin/bash

# 42_save by Tvanbael

banner () {
    echo -e "#  ██╗  ██╗██████╗         ███████╗ █████╗ ██╗   ██╗███████╗"
    echo -e "#  ██║  ██║╚════██╗        ██╔════╝██╔══██╗██║   ██║██╔════╝"
    echo -e "#  ███████║ █████╔╝        ███████╗███████║██║   ██║█████╗"
    echo -e "#  ╚════██║██╔═══╝         ╚════██║██╔══██║╚██╗ ██╔╝██╔══╝"
    echo -e "#       ██║███████╗███████╗███████║██║  ██║ ╚████╔╝ ███████╗"
    echo -e "#       ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝"
    echo -e "############################################################"
    echo -e "                                               By Tvanbael"
    echo -e "############################################################"
    echo -e ""
}

# Codes de couleur ANSI
RESET="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

# Emoji Unicode
CHECK_MARK="\xE2\x9C\x85"  # Emoji de coche verte
CROSS_MARK="\xE2\x9D\x8C"  # Emoji de croix rouge
RIGHT_ARROW="\xe2\x9e\x9c"

UP_ARROW="\xE2\xAC\x86"
DOWN_ARROW="\xE2\xAC\x87"

# Variables
SSH_VAR=false
ZSHRC_VAR=false
OMZSH_VAR=false
CLEANER_VAR=false
POS_VAR=1

# Tableau d'actions
# actions=("toggle_ssh_var" "toggle_ZSHRC_VAR" "toggle_OMZSH_VAR" "toggle_CLEANER_VAR" "start_save")

toggle_right() {
    case $POS_VAR in
        1)
            if [ "$SSH_VAR" == true ]; then
                SSH_VAR=false
            else
                SSH_VAR=true
            fi
            ;;
        2)
            if [ "$ZSHRC_VAR" == true ]; then
                ZSHRC_VAR=false
            else
                ZSHRC_VAR=true
            fi
            ;;
        3)
            if [ "$OMZSH_VAR" == true ]; then
                OMZSH_VAR=false
            else
                OMZSH_VAR=true
            fi
            ;;
        4)
            if [ "$CLEANER_VAR" == true ]; then
                CLEANER_VAR=false
            else
                CLEANER_VAR=true
            fi
            ;;
    esac
}

toggle_up() {
    if [ $POS_VAR -gt 1 ]; then
        POS_VAR=$((POS_VAR-1))
        select_option
    fi
}

toggle_down() {
    if [ $POS_VAR -lt 4 ]; then
        POS_VAR=$((POS_VAR+1))
        select_option
    fi
}

# Fonctions pour les actions
toggle_ssh_var() {
    ssh_var=!ssh_var
}

toggle_ZSHRC_VAR() {
    ZSHRC_VAR=!ZSHRC_VAR
}

toggle_OMZSH_VAR() {
    OMZSH_VAR=!OMZSH_VAR
}

toggle_CLEANER_VAR() {
    CLEANER_VAR=!CLEANER_VAR
}


print_select_option() {
    # Efface les 4 dernières lignes du terminal
    tput cuu 4 && tput el
    options=("Sauvegarde du .ssh   " "Sauvegarde du .zshrc " "Sauvegarde de ohMyZsh" "Sauvegarde de cclean ")
    vars=("$SSH_VAR" "$ZSHRC_VAR" "$OMZSH_VAR" "$CLEANER_VAR")

    for i in "${!options[@]}"; do
        option="${options[$i]}"
        var="${vars[$i]}"
        color="${WHITE}"

        if [ $POS_VAR -eq $((i+1)) ]; then
            color="${GREEN}"
            option="${GREEN}[${RESET} ${RIGHT_ARROW}  ${option}"
        else
            option="[    ${option}"
        fi

        if [ "$var" == true ]; then
            status="${CHECK_MARK}"
        else
            status="${CROSS_MARK}"
        fi
        if [ $POS_VAR -eq $((i+1)) ]; then
            echo -e "${color}[ ${status} ]${RESET} - ${option} ${RESET}   ${GREEN}]${RESET}"
        else
            echo -e "${color}[ ${status} ]${RESET} - ${option} ${RESET}   ]"
        fi
    done
}


select_option() {
    print_select_option
    while true; do
        read -s -n 1 key
        case "$key" in
            $'\x1b') # Touche Échappement (pour les codes de flèches)
                read -s -n 1 key
                if [[ "$key" == "[" ]]; then
                    read -s -n 1 key
                    case "$key" in
                        "A") # Flèche vers le haut
                            if [ $POS_VAR -gt 1 ]; then
                                toggle_up
                            fi
                            ;;
                        "B") # Flèche vers le bas
                            if [ $POS_VAR -lt 4 ]; then
                                toggle_down
                            fi
                            ;;
                        "C") # Flèche vers la droite
                            toggle_right
                            select_option
                            ;;
                    esac
                fi
                ;;
            " ") # Barre d'espace
                toggle_right
                ;;
            $'\n') # Touche "Entrée"
                start_save
                ;;
        esac
    done
}

menu() {
    tput civis  # Pour masquer le curseur
    # ssh_var=false;
    # ZSHRC_VAR=false;
    # OMZSH_VAR=false;
    # CLEANER_VAR=false;
    # POS_VAR=1;
    clear
    banner
    echo -e "For navigation in menu, use arrow $UP_ARROW and $DOWN_ARROW"
    echo -e ""
    echo -e "Select an option with space"
    echo -e ""
    echo -e "Confirm selection with Enter"
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    select_option
    echo "debug 3"
}

start_save() {
    echo "Sauvegarde en cours..."
    # Ajoutez ici votre code de sauvegarde
    sleep 2  # Exemple: Attente de 2 secondes pour simuler la sauvegarde
    echo "Sauvegarde terminée."
    exit 0
}

# Vérifier si le script est exécuté directement
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    # Appeler la fonction menu si le script est exécuté directement
    menu
fi
