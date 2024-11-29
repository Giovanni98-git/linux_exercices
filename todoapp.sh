#!/bin/bash

# Nom du fichier des tâches
task_file="task.txt"

# Fonction pour afficher le menu principal
afficher_menu() {
    echo "------------------"
    echo "Todo App :"
    echo "1. Ajouter une tâche"
    echo "2. Afficher les tâches"
    echo "3. Supprimer une tâche"
    echo "4. Quitter"
    echo "------------------"
}

# Fonction pour ajouter une tâche
ajouter_tache() {
    echo "Entrez la tâche à ajouter :"
    read task
    echo "$task" >> "$task_file"
    echo "Tâche ajoutée avec succès."
}

# Fonction pour afficher les tâches
afficher_taches() {
    if [ -s "$task_file" ]; then
        echo "Liste des tâches :"
        nl "$task_file"
    else
        echo "Aucune tâche à afficher."
    fi
}

# Fonction pour supprimer une tâche
supprimer_tache() {
    if [ ! -s "$task_file" ]; then
        echo "Aucune tâche à supprimer."
        return
    fi

    afficher_taches
    echo "Entrez le numéro de la tâche à supprimer :"
    read numero

    if [[ "$numero" =~ ^[0-9]+$ ]] && [ "$numero" -le $(wc -l < "$task_file") ] && [ "$numero" -gt 0 ]; then
        sed -i.bak "${numero}d" "$task_file"
        rm -f "$task_file.bak"
        echo "Tâche supprimée avec succès."
    else
        echo "Numéro invalide. Veuillez réessayer."
    fi
}

# Vérifier si le fichier des tâches existe, sinon le créer
if [ ! -e "$task_file" ]; then
    touch "$task_file"
fi

# Boucle principale du menu
while true; do
    afficher_menu
    echo "Choisissez une option (1-4) :"
    read choix

    case $choix in
        1)
            ajouter_tache
            ;;
        2)
            afficher_taches
            ;;
        3)
            supprimer_tache
            ;;
        4)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez réessayer."
            ;;
    esac
done