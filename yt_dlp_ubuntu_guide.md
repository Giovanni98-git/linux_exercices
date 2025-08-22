Manuel d'installation et d'utilisation de yt-dlp sur Ubuntu

---

# 1. Introduction
`yt-dlp` est un fork moderne de `youtube-dl`, permettant de télécharger des vidéos depuis YouTube et d'autres sites, avec gestion avancée des formats, des sous-titres et des playlists. Il offre aussi la possibilité d’extraire l’audio, d’intégrer les sous-titres dans la vidéo (hardsub), et de gérer des téléchargements massifs.

---

# 2. Installation

## 2.1 Installer pipx
```
sudo apt update
sudo apt install pipx -y
pipx ensurepath
```
> Ouvrir un nouveau terminal après pour que le PATH soit pris en compte.

## 2.2 Installer yt-dlp avec pipx
```
pipx install yt-dlp
```

## 2.3 Vérification
```
yt-dlp --version
```

## 2.4 Optionnel : alias `youtube-dl`
```
sudo ln -s ~/.local/bin/yt-dlp /usr/local/bin/youtube-dl
```

---

# 3. Téléchargement de base
```
yt-dlp "URL_DE_LA_VIDEO"
```

---

# 4. Formats vidéo et audio

## 4.1 Lister les formats disponibles
```
yt-dlp -F "URL_DE_LA_VIDEO"
```

## 4.2 Télécharger un format précis
```
yt-dlp -f 22 "URL_DE_LA_VIDEO"
```

## 4.3 Fusionner vidéo et audio séparés
```
yt-dlp -f 137+140 "URL_DE_LA_VIDEO"
```

## 4.4 Meilleur format automatique
```
yt-dlp -f "bestvideo+bestaudio/best" "URL_DE_LA_VIDEO"
```

## 4.5 Extraire uniquement l’audio
```
yt-dlp -x --audio-format mp3 "URL_DE_LA_VIDEO"
```

---

# 5. Téléchargement de playlists

## 5.1 Télécharger toute la playlist
```
yt-dlp --yes-playlist "URL_DE_LA_PLAYLIST"
```

## 5.2 Télécharger un format précis pour chaque vidéo
```
yt-dlp -f 22 --yes-playlist "URL_DE_LA_PLAYLIST"
```

## 5.3 Télécharger toute une playlist en audio
```
yt-dlp -x --audio-format mp3 --yes-playlist "URL_DE_LA_PLAYLIST"
```

## 5.4 Continuer un téléchargement de playlist partiellement téléchargée
```
yt-dlp -i -c --yes-playlist "URL_DE_LA_PLAYLIST"
```

## 5.5 Télécharger un sous-ensemble de la playlist (index spécifique)
```
yt-dlp --playlist-start 5 --playlist-end 10 --yes-playlist "URL_DE_LA_PLAYLIST"
```

---

# 6. Options avancées

## 6.1 Télécharger dans un dossier spécifique
```
yt-dlp -o "/chemin/vers/dossier/%(playlist_index)s - %(title)s.%(ext)s" "URL"
```

## 6.2 Limiter la vitesse de téléchargement
```
yt-dlp --limit-rate 1M "URL"
```

## 6.3 Reprendre un téléchargement interrompu (vidéo unique)
```
yt-dlp -c "URL"
```

## 6.4 Ignorer les vidéos déjà téléchargées dans une playlist
```
yt-dlp --download-archive archive.txt --yes-playlist "URL_DE_LA_PLAYLIST"
```

## 6.5 Ignorer les erreurs et continuer automatiquement
```
yt-dlp -i "URL_DE_LA_PLAYLIST"
```

## 6.6 Ajouter des métadonnées et miniatures
```
yt-dlp --write-info-json --write-thumbnail "URL_DE_LA_VIDEO"
```

## 6.7 Limiter la taille des fichiers
```
yt-dlp --max-filesize 50M "URL_DE_LA_VIDEO"
```

## 6.8 Modifier le nom du fichier avec des métadonnées
```
yt-dlp -o "/chemin/%(uploader)s/%(title)s.%(ext)s" "URL_DE_LA_VIDEO"
```

## 6.9 Limiter le nombre de tentatives
```
yt-dlp --retries 5 "URL"
```

## 6.10 Ajouter un délai entre téléchargements
```
yt-dlp --sleep-interval 5 --min-sleep-interval 2 --max-sleep-interval 10 "URL_DE_LA_PLAYLIST"
```

## 6.11 Filtrer les vidéos selon des critères
```
yt-dlp --match-filter "duration<600 & view_count>1000" "URL_DE_LA_PLAYLIST"
```
> Télécharge uniquement les vidéos de moins de 10 minutes avec plus de 1000 vues.

## 6.12 Utiliser un proxy
```
yt-dlp --proxy "http://127.0.0.1:8080" "URL"
```

## 6.13 Utiliser des cookies pour l’authentification
```
yt-dlp --cookies cookies.txt "URL"
```

---

# 7. Gestion des sous-titres

## 7.1 Lister les langues disponibles
```
yt-dlp --list-subs "URL_DE_LA_VIDEO"
```

## 7.2 Télécharger des sous-titres
```
yt-dlp --write-subs --sub-lang fr "URL_DE_LA_VIDEO"
```

## 7.3 Convertir en SRT
```
yt-dlp --write-subs --sub-lang fr --convert-subs srt "URL_DE_LA_VIDEO"
```

## 7.4 Sous-titres intégrés (hardsub)
```
yt-dlp --embed-subs --sub-lang fr "URL_DE_LA_VIDEO"
```

## 7.5 Plusieurs langues
```
yt-dlp --write-subs --sub-lang fr,en --convert-subs srt "URL_DE_LA_VIDEO"
```

## 7.6 Télécharger seulement les sous-titres
```
yt-dlp --skip-download --write-subs --sub-lang fr "URL_DE_LA_VIDEO"
```

## 7.7 Sous-titres automatiques si pas dispo et hardsub
```
yt-dlp --write-auto-subs --sub-langs "fr,en.*" --embed-subs --merge-output-format mp4 "URL_DE_LA_VIDEO_OU_PLAYLIST"
```

## 7.8 Garder les fichiers `.srt` séparés
```
yt-dlp --write-subs --sub-langs "fr,en.*" --convert-subs srt -o "/chemin/vers/dossier/%(title)s.%(ext)s" "URL_DE_LA_VIDEO"
```

## 7.9 Télécharger et fusionner sous-titres avec audio pour karaoke
```
yt-dlp --write-subs --sub-lang fr --convert-subs srt -x --audio-format mp3 "URL_DE_LA_VIDEO"
```

---

# 8. Mise à jour
```
pipx upgrade yt-dlp
```

---

# 9. Aide et documentation
```
yt-dlp --help
```
Documentation officielle : [https://github.com/yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp)

---

Ce manuel couvre maintenant :
- Vidéo et audio uniques
- Playlists vidéo ou audio
- Choix de format, fusion audio/vidéo
- Sous-titres : français, anglais, automatiques, hardsub, softsub
- Téléchargement dans des dossiers précis
- Reprise et limitation de vitesse
- Continuer une playlist partiellement téléchargée
- Ignorer les erreurs et gérer les archives
- Télécharger un sous-ensemble de playlist (index spécifique)
- Métadonnées, miniatures et organisation avancée
- Options avancées : retries, délais, filtres, proxy, cookies

