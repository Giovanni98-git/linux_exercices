# Partie A : les fichiers et permissions

## Objectif

Créez un script Bash nommé `script.sh` qui permet de manipuler des fichiers et des répertoires tout en gérant les permissions avec le bit SGID. Le script devra être interactif et proposer plusieurs options à l'utilisateur.

---

### Fonctionnalités attendues

1. **Afficher un menu interactif** qui propose les options suivantes :
   - 1 : Créer un fichier.
   - 2 : Lister les fichiers dans un répertoire.
   - 3 : Afficher le contenu d’un fichier.
   - 4 : Afficher le contenu du fichier `/etc/shadow`.
   - 5 : Quitter le script.

2. **Implémenter les actions suivantes pour chaque option :**
   - **Option 1 : Créer un fichier**  
     - Demander à l'utilisateur d'entrer un nom de fichier.
     - Vérifier si le fichier existe déjà.
     - Si le fichier n'existe pas, le créer et afficher un message confirmant sa création.
     - Sinon, afficher une erreur signalant que le fichier existe déjà.

   - **Option 2 : Lister les fichiers dans un répertoire**  
     - Demander à l'utilisateur d'entrer le chemin d'un répertoire.
     - Vérifier si le répertoire existe.
     - Si le répertoire existe, lister les fichiers qu'il contient.
     - Sinon, afficher une erreur signalant que le répertoire n'existe pas.

   - **Option 3 : Afficher le contenu d'un fichier**  
     - Demander à l'utilisateur d'entrer le nom d'un fichier.
     - Vérifier si le fichier existe et n'est pas vide.
     - Si le fichier existe, afficher son contenu.
     - Sinon, afficher une erreur indiquant que le fichier est vide ou n'existe pas.

   - **Option 4 : Afficher le contenu du fichier `/etc/shadow`**  
     - Afficher le contenu du fichier `/etc/shadow` sans demander le mot de passe administrateur.
     - **Attention :** Vous devrez modifier les permissions du script pour qu'il puisse être exécuté avec des droits administratifs sans passer en mode `root` (voir consignes supplémentaires).

   - **Option 5 : Quitter le script**  
     - Afficher un message d'au revoir et quitter le programme.

3. **Continuer à afficher le menu** jusqu'à ce que l'utilisateur choisisse de quitter (option 5).

---

### Consignes supplémentaires

1. Modifiez les permissions de votre fichier `script.sh` avant de l'exécuter :
   - **Changer le groupe du fichier** :
     ```bash
     sudo chgrp root script.sh
     ```
   - **Rendre le fichier exécutable** :
     ```bash
     chmod +x script.sh
     ```
   - **Activer le bit SGID** pour exécuter le script avec les permissions du groupe `root` :
     ```bash
     sudo chmod g+s script.sh
     ```

2. Assurez-vous que le script fonctionne correctement lorsqu'il est exécuté par un utilisateur non `root`.

---

### Exemple d'interaction utilisateur

```text
------------------
Menu :
1. Créer un fichier
2. Lister les fichiers dans un répertoire
3. Afficher le contenu d’un fichier
4. Afficher le contenu du fichier /etc/shadow
5. Quitter
------------------
Choisissez une option (1-5) : 1
Entrez le nom du fichier à créer : notes.txt
Fichier 'notes.txt' créé avec succès.

------------------
Menu :
1. Créer un fichier
2. Lister les fichiers dans un répertoire
3. Afficher le contenu d’un fichier
4. Afficher le contenu du fichier /etc/shadow
5. Quitter
------------------
Choisissez une option (1-5) : 4
Contenu du fichier /etc/shadow :
root:*:19376:0:99999:7:::
daemon:*:19376:0:99999:7:::
...

------------------
Menu :
1. Créer un fichier
2. Lister les fichiers dans un répertoire
3. Afficher le contenu d’un fichier
4. Afficher le contenu du fichier /etc/shadow
5. Quitter
------------------
Choisissez une option (1-5) : 5
Au revoir !
```

---

### Critères d'évaluation

- Le script est fonctionnel et respecte les consignes.
- Le menu interactif est clair et les options fonctionnent correctement.
- Le script gère les erreurs (fichier ou répertoire inexistant, options invalides, etc.).
- Les permissions du fichier sont correctement configurées pour exécuter l'option 4 sans demander le mot de passe administrateur.
- Le code est bien organisé et commenté.

# Solution
### Contenu du fichier script.sh
```bash
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
```
### Utiliser ces commandes sur le fichier avant exécution
```bash
# Pour changer le groupe du fichier 
sudo chgrp root script.sh
# Rendre le fichier exécutable
chmod +x script.sh
# Pour passer le bit SGID 
sudo chmod g+s script.sh 
```

## Partie B : Créer une Todo-App en Bash
### Objectif : Rédige un script Bash qui fonctionne comme une application de gestion de tâches. Le script doit répondre aux spécifications suivantes :

---

### Fonctionnalités principales
1. **Menu interactif** : 
   - À chaque exécution, affiche un menu proposant quatre options :
     ```
     ------------------
     Todo App :
     1. Ajouter une tâche
     2. Afficher les tâches
     3. Supprimer une tâche
     4. Quitter
     ------------------
     ```

2. **Ajout de tâches** :
   - Si l'utilisateur choisit l'option **1**, le script demande une description de la tâche à ajouter.
   - La tâche est ajoutée à un fichier nommé `task.txt`.
   - Si le fichier n'existe pas, il doit être créé automatiquement.
   - Confirme que la tâche a été ajoutée avec succès.

3. **Affichage des tâches** :
   - Si l'utilisateur choisit l'option **2**, le script affiche les tâches enregistrées dans `task.txt`.
   - Chaque tâche doit être numérotée automatiquement (par exemple, en utilisant la commande `nl`).
   - Si le fichier est vide ou n'existe pas, affiche un message indiquant qu'il n'y a aucune tâche.

4. **Suppression de tâches** :
   - Si l'utilisateur choisit l'option **3**, le script affiche d'abord la liste des tâches existantes (comme à l'option **2**).
   - Il demande ensuite à l'utilisateur de saisir le **numéro de la tâche** à supprimer.
   - Le numéro saisi doit être validé pour s'assurer qu'il correspond à une tâche existante :
     - S'il est valide, la tâche est supprimée.
     - Sinon, affiche un message d'erreur.
   - Si le fichier est vide ou n'existe pas, affiche un message disant qu'il n'y a aucune tâche à supprimer.

5. **Quitter l'application** :
   - Si l'utilisateur choisit l'option **4**, le script affiche un message d'au revoir et se termine proprement.

---

#### **Contraintes et attentes**
- Le fichier des tâches s'appelle **task.txt** et se trouve dans le même répertoire que le script.
- Le script doit fonctionner de manière robuste, avec des validations pour éviter les erreurs :
  - Gestion des entrées non valides (par exemple, des lettres au lieu de chiffres).
  - Gestion des fichiers absents ou vides.
- Le script doit utiliser les commandes Bash standards (`touch`, `nl`, `read`, `sed`, etc.).
- Ajoute des messages clairs pour confirmer les actions réussies ou indiquer les erreurs.

---

#### **Exemple d’exécution attendu**

**Menu affiché :**
```
------------------
Todo App :
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
------------------
Choisissez une option (1-4) :
```

**Ajout d'une tâche :**
- Saisie utilisateur : "Acheter du lait"
- Résultat affiché :
  ```
  Tâche ajoutée avec succès.
  ```

**Affichage des tâches :**
- Contenu de `task.txt` :
  ```
  Acheter du lait
  Faire le ménage
  ```
- Résultat affiché :
  ```
  Liste des tâches :
  1	 Acheter du lait
  2	 Faire le ménage
  ```

**Suppression d'une tâche :**
- Liste affichée :
  ```
  Liste des tâches :
  1	 Acheter du lait
  2	 Faire le ménage
  ```
- Saisie utilisateur : "2"
- Résultat affiché :
  ```
  Tâche supprimée avec succès.
  ```

**Quitter l'application :**
- Saisie utilisateur : "4"
- Résultat affiché :
  ```
  Au revoir !
  ```

---

### **Livrable attendu**
- Un fichier nommé `todoapp.sh` contenant le script Bash répondant aux spécifications.
- Le script doit être testé et fonctionner correctement dans un environnement Bash.

# Solution
```bash
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
```