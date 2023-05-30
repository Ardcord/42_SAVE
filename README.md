WARNING (Projet toujours en cours de developpement, certaines fonctionalitées décrites plus bas ne sont pas encore mise en place)
Si vous souhaitez participer au projet contacter moi.


Projet de sauvegarde des données utilisateur

Ce projet en Python permet de sauvegarder les données utilisateur en fonction de ses choix,
en utilisant le module pickle pour la sérialisation et la désérialisation des données.
Installation

    Assurez-vous d'avoir Python 3.x installé sur votre système.
    Clonez ou téléchargez le projet sur votre machine.

Utilisation

    Ouvrez un terminal ou une ligne de commande.
    Accédez au répertoire du projet.
    Exécutez le fichier 42_reset.py en utilisant la commande suivante :

    python 42_reset.py

    Suivez les instructions affichées à l'écran :
        Lorsque le programme est lancé, il affiche un menu demandant à l'utilisateur s'il souhaite
        installer (I) sa session ou sauvegarder (S) sa session.
        Si l'utilisateur choisit l'option d'installation, le programme exécute les instructions spécifiques
        à l'installation de la session, notamment la copie des données à leurs emplacements d'origine.
        Si l'utilisateur choisit l'option de sauvegarde, le programme recherche les fichiers personnels
        de l'utilisateur sur son répertoire principal (home), ainsi que certains fichiers à la racine du
        home tels que:
        -.zshrc
        -.ssh
        -.vimrc
        
        Toutes ces données seront sauvegardées dans /goinfre en attendant
        la création du fichier ~/.reset et la réinitialisation de la session utilisateur.
        L'utilisateur n'aura ensuite qu'à relancer le programme depuis son répertoire principal avec la commande
        python 42_reset.py
        et sélectionner l'option "installer".

Structure du projet

    42_reset.py: Fichier principal du programme contenant le menu et les appels aux fonctions.
    README.md: Ce fichier, fournissant des informations sur le projet.

Dépendances

Le projet ne nécessite aucune dépendance externe en dehors de la bibliothèque standard de Python.
Auteur

[tvanbael]
