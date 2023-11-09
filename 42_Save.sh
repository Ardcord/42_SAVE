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
    local var_names=("SSH_VAR" "ZSHRC_VAR" "OMZSH_VAR" "CLEANER_VAR")
    local pos_var=$((POS_VAR - 1))
    local callback="$1"

    if [ $pos_var -eq 4 ]; then
        start_save
        return
    fi

    # Inverser la valeur de la variable correspondante
    if [ "${!var_names[$pos_var]}" == true ]; then
        eval "${var_names[$pos_var]}=false"
    else
        eval "${var_names[$pos_var]}=true"
    fi

    "$callback"
}


toggle_choice() {
    local pos_var=$((POS_VAR - 1))
    case "$pos_var" in
        1)
            select_option
            ;;
        2)
            toggle_OMZSH_VAR select_option
            ;;
        3)
            exit 0
            ;;
    esac
}

toggle_up() {
    local callback="$1"
    if [ $POS_VAR -gt 1 ]; then
        POS_VAR=$((POS_VAR-1))
        "$callback"
    fi
}

toggle_down() {
    local callback="$1"
    local condition="$2"
    if [ $POS_VAR -lt "$condition" ]; then
        POS_VAR=$((POS_VAR+1))
        "$callback"
    fi
    
}


print_select_option() {
    # Efface les 5 dernières lignes du terminal
    tput cuu 5 && tput el
    options=("Sauvegarde du .ssh   " "Sauvegarde du .zshrc " "Sauvegarde de ohMyZsh" "Sauvegarde de cclean " "Validate")
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
        # if [ $POS_VAR -eq 5 ]; then
        #     echo -e "${color}[ ${status} ]${RESET} - ${option} ${RESET}   ${GREEN}]${RESET}"        
        # fi
    done
}

print_select_mode() {
    # Efface les 3 dernières lignes du terminal
    tput cuu 3 && tput el
    options=("Save my home   " "Restore my home" "Exit           ")

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
                                toggle_up select_option
                            fi
                            ;;
                        "B") # Flèche vers le bas
                            if [ $POS_VAR -lt 5 ]; then
                                toggle_down select_option 5
                            fi
                            ;;
                        "C") # Flèche vers la droite
                            toggle_right select_option
                            
                            ;;
                    esac
                fi
                ;;
            " ") # Barre d'espace
                toggle_space select_option
                ;;
            $'\n') # Touche "Entrée"
                start_save
                ;;
        esac
    done
}

select_mode() {
    print_select_mode
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
                                toggle_up select_mode
                            fi
                            ;;
                        "B") # Flèche vers le bas
                            if [ $POS_VAR -lt 3 ]; then
                                toggle_down select_mode 3
                            fi
                            ;;
                        "C") # Flèche vers la droite
                            toggle_choice
                            ;;
                    esac
                fi
                ;;
            " ") # Barre d'espace
                toggle_space select_option
                ;;
            $'\n') # Touche "Entrée"
                start_save
                ;;
        esac
    done
}

menu() {
    tput civis  # Pour masquer le curseur
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
    # select_mode
    select_option
    echo "debug 3"
}

start_save() {
    echo -e "############################################################"
    echo -e "Activity logs"
    echo -e "############################################################"
    echo "Sauvegarde en cours..."
    if [ "$SSH_VAR" == true ]; then
        
        echo "Sauvegarde du .ssh"
    fi
    if [ "$ZSHRC_VAR" == true ]; then
        echo "Sauvegarde du .zshrc"
    fi
    if [ "$OMZSH_VAR" == true ]; then
        echo "Sauvegarde de ohMyZsh"
    fi
    if [ "$CLEANER_VAR" == true ]; then
        echo "Sauvegarde de cclean"
    fi
    echo -e "############################################################"
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
