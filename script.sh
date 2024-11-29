
#!/bin/bash

# Fonction pour afficher le menu principal
afficher_menu() {
    echo "------------------"
    echo "Menu :"
    echo "1. Créer un fichier"
    echo "2. Lister les fichiers dans un répertoire"
    echo "3. Afficher le contenu d’un fichier"
    echo "4. Afficher le contenu du fichier /etc/shadow"
    echo "5. Quitter"
    echo "------------------"
}

# Fonction pour créer un fichier
creer_fichier() {
    echo "Entrez le nom du fichier à créer :"
    read nom_fichier
    if [ -e "$nom_fichier" ]; then
        echo "Erreur : Le fichier '$nom_fichier' existe déjà."
    else
        touch "$nom_fichier"
        echo "Fichier '$nom_fichier' créé avec succès."
    fi
}

# Fonction pour lister les fichiers dans un répertoire
lister_fichiers() {
    echo "Entrez le nom du répertoire :"
    read nom_repertoire
    if [ -d "$nom_repertoire" ]; then
        echo "Liste des fichiers dans '$nom_repertoire' :"
        ls "$nom_repertoire"
    else
        echo "Erreur : Le répertoire '$nom_repertoire' n'existe pas."
    fi
}

# Fonction pour afficher le contenu d’un fichier
afficher_contenu() {
    echo "Entrez le nom du fichier à afficher :"
    read nom_fichier
    if [ -s "$nom_fichier" ]; then
        cat "$nom_fichier"
    else
        echo "Erreur : Le fichier est vide ou n'existe pas."
    fi
}

# Fonction pour afficher le contenu du fichier /etc/shadow
afficher_shadow() {
        echo "Contenu du fichier /etc/shadow :"
        sudo cat /etc/shadow
}

# Boucle principale du menu
while true; do
    afficher_menu
    echo "Choisissez une option (1-5) :"
    read choix

    case $choix in
        1)
            creer_fichier
            ;;
        2)
            lister_fichiers
            ;;
        3)
            afficher_contenu
            ;;
        4)
            afficher_shadow
            ;;
        5)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez réessayer."
            ;;
    esac

done