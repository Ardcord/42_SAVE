import shutil
import subprocess
import getpass
import sys
import os

USER = "42_SAVE_" + os.environ['USER']
BREW = False
ZSH = False
CLEANER = False


def copier_documents():
	# Chemin du répertoire source
	repertoire_source = os.path.expanduser("~/Documents")

	# Chemin du répertoire destination
	repertoire_destination = os.path.expanduser(f"~/goinfre/{USER}/Documents")
	if os.path.exists(repertoire_destination):
		shutil.rmtree(repertoire_destination)

	if not os.path.exists(repertoire_destination):
		os.makedirs(repertoire_destination, exist_ok=True)

	# Vérifier si le répertoire source existe
	if not os.path.exists(repertoire_source):
		print("Le répertoire source n'existe pas.")
		return

	# Parcourir tous les fichiers et dossiers dans le répertoire source
	for element in os.listdir(repertoire_source):
		chemin_source = os.path.join(repertoire_source, element)
		chemin_destination = os.path.join(repertoire_destination, element)

		# Copier le fichier ou le dossier vers la destination
		if os.path.isfile(chemin_source):
			shutil.copy2(chemin_source, chemin_destination)
		elif os.path.isdir(chemin_source):
			shutil.copytree(chemin_source, chemin_destination)

	# Liste des fichiers et dossiers à copier
	elements_a_copier = ['.ssh', '.zshrc', '.vimrc']

	# Chemin du répertoire de destination pour les fichiers spécifiés
	repertoire_destination_hiden = os.path.expanduser(f"~/goinfre/{USER}/hiden")
	if not os.path.exists(repertoire_destination_hiden):
		os.makedirs(repertoire_destination_hiden, exist_ok=True)

	# Copier les fichiers et dossiers spécifiés s'ils existent
	for element in elements_a_copier:
		chemin_source = os.path.expanduser(f"~/{element}")
		chemin_destination = os.path.join(repertoire_destination_hiden, element)
		if os.path.exists(chemin_source):
			if os.path.isfile(chemin_source):
				shutil.copy2(chemin_source, chemin_destination)
			elif os.path.isdir(chemin_source):
				shutil.copytree(chemin_source, chemin_destination)

	print("La copie du dossier \"Documents\" est terminée.")



def copy_mode():
	print("install mode")
	# restaurer les fichier utilisateur du home
	repertoire_source = os.path.expanduser(f"~/goinfre/{USER}")
	if not os.path.exists(repertoire_source):
		print("Le répertoire source n'existe pas.")
		exit (0)
	repertoire_source = os.path.expanduser(f"~/goinfre/{USER}/Documents")
	# Chemin du répertoire destination
	repertoire_destination = os.path.expanduser("~/Documents")
	if os.path.exists(repertoire_destination):
		# Parcourir tous les fichiers et dossiers dans le répertoire source
		for element in os.listdir(repertoire_source):
			chemin_source = os.path.join(repertoire_source, element)
			chemin_destination = os.path.join(repertoire_destination, element)

			# Copier le fichier ou le dossier vers la destination
			if os.path.isfile(chemin_source):
				shutil.copy2(chemin_source, chemin_destination)
			elif os.path.isdir(chemin_source):
				shutil.copytree(chemin_source, chemin_destination)
	# hidden files
	# Liste des fichiers et dossiers à copier
	elements_a_copier = ['.ssh', '.zshrc', '.vimrc']

	# Chemin du répertoire de destination pour les fichiers spécifiés
	repertoire_destination_hiden = os.path.expanduser(f"~/")

	# Copier les fichiers et dossiers spécifiés s'ils existent
	for element in elements_a_copier:
		chemin_source = os.path.expanduser(f"~/goinfre/{USER}/hiden")
		chemin_destination = os.path.join(repertoire_destination_hiden, element)
		if os.path.exists(chemin_source):
			if os.path.isfile(chemin_source):
				shutil.copy2(chemin_source, chemin_destination)
			elif os.path.isdir(chemin_source):
				shutil.copytree(chemin_source, chemin_destination)

	print("La copie du dossier \"Documents\" est terminée.")

def install_choice():
	print ("install_choice mode")
	# BREW
	print("you need to install brew? [y/n]")
	choix = input()
	# choix = choix.upper()
	while choix != "YES" and choix != "Y" and choix != "NO" and choix != "N" and choix != "yes" and choix != "y" and choix != "no" and choix != "n":
		if choix == "YES" or choix == "Y" or choix == "yes" or choix == "y":
			BREW = True
		elif choix == "NO" or choix == "N" or choix == "no" or choix == "n":
			BREW = False
		else:
			print("Invalide choice, retry please")
	# ZSH
	print("you need to install ZSH? [y/n]")
	choix = input()
	# choix = choix.upper()
	while choix != "YES" and choix != "Y" and choix != "NO" and choix != "N" and choix != "yes" and choix != "y" and choix != "no" and choix != "n":
		if choix == "YES" or choix == "Y" or choix == "yes" or choix == "y":
			ZSH = True
		elif choix == "NO" or choix == "N" or choix == "no" or choix == "n":
			ZSH = False
		else:
			print("Invalide choice, retry please")
	# CLEANER
	print("you need to install CLEANER? [y/n]")
	choix = input()
	# choix = choix.upper()
	while choix != "YES" and choix != "Y" and choix != "NO" and choix != "N" and choix != "yes" and choix != "y" and choix != "no" and choix != "n":
		if choix == "YES" or choix == "Y" or choix == "yes" or choix == "y":
			CLEANER = True
		elif choix == "NO" or choix == "N" or choix == "no" or choix == "n":
			CLEANER = False
		else:
			print("Invalide choice, retry please")
	
	
def install_mode():
    if BREW:
        print("install brew")
        # Ouvrir une nouvelle fenêtre iTerm et exécuter la commande d'installation de brew
        subprocess.run(['open', '-a', 'iTerm', '/bin/bash', '-c', '"$(curl -fsSL https://raw.githubusercontent.com/omimouni/42homebrew/master/install-goinfre.sh | zsh)"'])

    if ZSH:
        print("install zsh")
        # Ouvrir une nouvelle fenêtre iTerm et exécuter la commande d'installation de zsh
        subprocess.run(['open', '-a', 'iTerm', '/bin/bash', '-c', '"$(curl -fsSL https://raw.githubusercontent.com/omimouni/42homebrew/master/install-goinfre.sh | zsh)"'])

    if CLEANER:
        print("install cleaner")
        # Cloner le dépôt
        subprocess.run(['git', 'clone', 'git@github.com:ombhd/Cleaner_42.git'])
        # Exécuter l'installateur nommé ./CleanerInstaller.sh dans une nouvelle fenêtre iTerm
        subprocess.run(['open', '-a', 'iTerm', 'sh', './CleanerInstaller.sh'])
        # Supprimer le dépôt
        subprocess.run(['rm', '-rf', './Cleaner_42'])


def save_state():
	print("save_state mode")
	# sauvegarder les fichier utilisateur du home
	#fonction creant un dossier /home/goinfre/42_SAVE_${user}
	repertoire_destination = os.path.expanduser(f"~/goinfre/{USER}")
	os.makedirs(repertoire_destination, exist_ok=True)
	copier_documents()

def reset_state():
	copy_mode()
	install_choice()
	install_mode()
	


def banner():
	print("#####################################################")
	print("##												 ##")
	print("## 42_reset.py - Reset the device to factory state ##")
	print("##												 ##")
	print("#####################################################")



def choice(isInstall):
	print("##											   ##")
	print("##		You need to install or reset?   	   ##")
	print("##											   ##")
	print("## 	1 - Install	[y]   	   		   ##")
	print("## 	2 - Reset	[n]   	  		   ##")
	choix = input()
	# choix = choix.upper()
	while choix != "YES" and choix != "Y" and choix != "NO" and choix != "N" and choix != "yes" and choix != "y" and choix != "no" and choix != "n":
		if choix == "YES" or choix == "Y" or choix == "yes" or choix == "y":
			isInstall = True
		elif choix == "NO" or choix == "N" or choix == "no" or choix == "n":
			isInstall = False
		else:
			print("Invalide choice, retry please")
	return(isInstall)


def main():
	isInstall = False

	# Banner
	banner()
	choice(isInstall)
	if not isInstall:
		save_state()
	else:
		install()
	return(0)


if __name__ == "__main__":
	main()
