# Monochrome Music Player - Flatpak

[![Flathub](https://img.shields.io/badge/Flathub-Ready-blue)](https://flathub.org)
[![License](https://img.shields.io/badge/License-ISC-green)](LICENSE)
[![Monochrome](https://img.shields.io/badge/Monochrome-v2.5.0-purple)](https://github.com/monochrome-music/monochrome)

**Monochrome** est un lecteur de musique streaming open-source, respectueux de la vie privée et sans publicité, packagé pour Linux via Flatpak.

![Monochrome Interface](screenshots/screenshot1.png)

---

## 📖 Table des Matières

- [Fonctionnalités](#-fonctionnalités)
- [Installation](#-installation)
- [Build Local](#-build-local)
- [Limitation Connue : OAuth](#-limitation-connue-oauth)
- [Permissions](#-permissions)
- [Structure du Projet](#-structure-du-projet)
- [Développement](#-développement)
- [Soumission Flathub](#-soumission-flathub)
- [Licence](#-licence)

---

## 🎵 Fonctionnalités

- 🎧 **Streaming Hi-Fi/lossless** - Support TIDAL et sources compatibles
- 🌙 **Interface minimaliste** - Design sombre optimisé pour la concentration
- 🎨 **Visualiseurs audio** - Butterchurn (Winamp-style)
- 📝 **Paroles** - Mode karaoké inclus
- 🎭 **Thèmes personnalisables** - Store de thèmes communautaires
- 📊 **Scrobbling** - Last.fm et ListenBrainz
- ⌨️ **Raccourcis clavier** - Pour les utilisateurs avancés
- 📁 **Fichiers locaux** - Support des fichiers musicaux locaux
- 📻 **Podcasts** - Intégration native
- 🎯 **Récemment joués** - Historique de lecture

---

## 🚀 Installation

### Depuis Flathub (recommandé)

```bash
flatpak install flathub com.monochrome.music
flatpak run com.monochrome.music
```

### Build Local

Voir [Build Local](#-build-local) ci-dessous.

---

## 🔨 Build Local

### Prérequis

```bash
# Installer Flatpak et flatpak-builder
# Fedora
sudo dnf install flatpak flatpak-builder

# Ubuntu/Debian
sudo apt install flatpak flatpak-builder

# Arch
sudo pacman -S flatpak flatpak-builder
```

### Installer le SDK

```bash
# Ajouter le repository Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installer le SDK Freedesktop 24.08
flatpak install flathub org.freedesktop.Sdk//24.08
flatpak install flathub org.freedesktop.Sdk.Extension.node22//24.08
```

### Builder

```bash
# Cloner le repository
git clone https://github.com/VOTRE_USERNAME/com.monochrome.music.git
cd com.monochrome.music

# Lancer le build
./flatpak/scripts/build.sh

# Créer le bundle
flatpak build-bundle repo com.monochrome.music.flatpak com.monochrome.music

# Installer
flatpak install --user com.monochrome.music.flatpak

# Lancer
flatpak run com.monochrome.music
```

### Scripts Disponibles

| Script | Description |
|--------|-------------|
| `./flatpak/scripts/build.sh` | Build complet du Flatpak |
| `./flatpak/scripts/run.sh` | Lance l'application |
| `./flatpak/scripts/clean.sh` | Nettoie les fichiers temporaires |
| `./flatpak/scripts/export-bundle.sh` | Crée le bundle .flatpak |

---

## ⚠️ Limitation Connue : OAuth

### Problème

L'authentification via **Google, Discord, GitHub ou Spotify** ne fonctionne **PAS** en version Flatpak.

**Erreur rencontrée :**
```
Error 400: Invalid `success` param: Invalid URI.
Register your new client (127.0.0.1) as a new Web platform
```

### Cause

Ce n'est **pas un bug du Flatpak**, mais une **limitation de PocketBase** (le système d'authentification utilisé par Monochrome) :

- PocketBase nécessite des URI de redirection pré-enregistrées
- Les applications desktop ne peuvent pas utiliser d'URI fixes (port dynamique)
- PocketBase ne supporte pas les wildcards (`http://localhost:*`)

### ✅ Solution : Authentification par Email

1. Cliquez sur **"Email"** au lieu des boutons OAuth
2. Entrez votre email et mot de passe
3. Vos playlists seront synchronisées normalement

### Alternative

1. Connectez-vous sur [monochrome.tf](https://monochrome.tf) (OAuth fonctionne sur le web)
2. Utilisez les mêmes identifiants email/mot de passe dans l'application Flatpak

---

## 🔒 Permissions

| Permission | Justification |
|------------|---------------|
| `--share=network` | Streaming musique en ligne |
| `--socket=wayland` | Support Wayland natif |
| `--socket=fallback-x11` | Support X11 en fallback |
| `--socket=pulseaudio` | Sortie audio |
| `--talk-name=org.freedesktop.Notifications` | Notifications de lecture |
| `--talk-name=org.kde.StatusNotifierWatcher` | Icône system tray |
| `--talk-name=org.freedesktop.ScreenSaver` | Empêcher la veille pendant la lecture |
| `--filesystem=xdg-music:ro` | Accès en lecture aux fichiers musicaux |

**Aucune permission dangereuse** - Toutes les permissions sont justifiées et minimales.

---

## 📁 Structure du Projet

```
com.monochrome.music/
├── flathub/                      # Manifeste et métadonnées Flathub
│   ├── com.monochrome.music.json    # Manifeste principal
│   ├── com.monochrome.music.desktop # Fichier .desktop
│   ├── com.monochrome.music.appdata.xml # Métadonnées AppStream
│   ├── monochrome/                  # Fichiers Electron
│   │   ├── main.js
│   │   ├── spa-server.py
│   │   └── package.json
│   ├── icons/                       # Icônes SVG
│   └── screenshots/                 # Captures d'écran
├── flatpak/                      # Outils de build
│   ├── scripts/
│   │   ├── build.sh
│   │   ├── run.sh
│   │   ├── clean.sh
│   │   └── export-bundle.sh
│   ├── sources/                  # Manifeste dupliqué pour build
│   └── resources/
├── monochrome/                   # Sous-module (app principale)
├── Rapport-Correction/           # Documentation des corrections
├── screenshots/                  # Captures d'écran pour README
├── README.md
├── LICENSE
└── .gitignore
```

---

## 🛠️ Développement

### Modifier le Manifeste

Le fichier principal est `flathub/com.monochrome.music.json`.

**Structure clé :**
- `app-id` : Identifiant unique (com.monochrome.music)
- `runtime` : Runtime Freedesktop 24.08
- `sdk-extensions` : Node.js 22
- `finish-args` : Permissions de l'application
- `modules` : Modules à builder

### Tester les Modifications

```bash
# Après modification du manifeste
./flatpak/scripts/build.sh

# Tester sans installer
flatpak-builder --user --install build-dir flathub/com.monochrome.music.json

# Lancer
flatpak run com.monochrome.music
```

### Validation

```bash
# Valider le fichier .desktop
desktop-file-validate flathub/com.monochrome.music.desktop

# Valider les métadonnées AppStream
appstreamcli validate flathub/com.monochrome.music.appdata.xml
```

---

## 📤 Soumission Flathub

### Checklist Avant Soumission

- [ ] 3 captures d'écran (1280x720, PNG)
- [ ] Fichier `.appdata.xml` valide
- [ ] Fichier `.desktop` valide
- [ ] Icône SVG scalable
- [ ] README.md complet
- [ ] LICENSE inclus
- [ ] Build testé avec succès

### Étapes de Soumission

1. **Fork Flathub**
   ```bash
   # Fork sur GitHub : https://github.com/flathub/flathub/fork
   ```

2. **Ajouter le manifeste**
   ```bash
   mkdir flathub/com.monochrome.music
   cp flathub/com.monochrome.music.json flathub/com.monochrome.music/
   ```

3. **Créer la Pull Request**
   - Remplir le template de PR Flathub
   - Attendre la review (1-2 semaines)
   - Répondre aux feedbacks

4. **Après Approbation**
   - Build automatique sur Flathub
   - Disponible dans quelques heures

### Références

- [Documentation Flathub](https://docs.flathub.org/docs/for-app-authors/)
- [Exigences Flathub](https://docs.flathub.org/docs/for-app-authors/requirements)
- [Manifeste Example](https://github.com/flathub/flathub/tree/master/appdata)

---

## 📸 Captures d'Écran

Les captures d'écran doivent être :
- Format : PNG
- Résolution : 1280x720 minimum
- Contenu :
  1. Interface principale (lecture d'album)
  2. Bibliothèque / Playlist
  3. Visualiseur audio

---

## 🐛 Signaler un Problème

### Problème Flatpak

[Ouvrir une issue sur ce repository](https://github.com/VOTRE_USERNAME/com.monochrome.music/issues)

### Problème Monochrome

[Ouvrir une issue sur monochrome-music/monochrome](https://github.com/monochrome-music/monochrome/issues)

### Limitation OAuth

Voir [Limitation Connue : OAuth](#-limitation-connue-oauth) ci-dessus.

---

## 📄 Licence

- **Monochrome** : [ISC](https://github.com/monochrome-music/monochrome/blob/main/license)
- **Packaging Flatpak** : ISC

---

## 🔗 Liens Utiles

- [Site Officiel Monochrome](https://monochrome.tf)
- [Repository Monochrome](https://github.com/monochrome-music/monochrome)
- [Documentation Flathub](https://docs.flathub.org)
- [Forum Flathub](https://discourse.flathub.org/)

---

## 🤝 Contribuer

Les contributions sont les bienvenues !

1. Fork le projet
2. Créez une branche (`git checkout -b feature/amazing-feature`)
3. Committez (`git commit -m 'Add amazing feature'`)
4. Pushez (`git push origin feature/amazing-feature`)
5. Ouvrez une Pull Request

Voir [CONTRIBUTING.md](CONTRIBUTING.md) pour plus de détails.

---

## 📧 Contact

- **Monochrome Team** : [contact@monochrome.tf](mailto:contact@monochrome.tf)
- **Repository** : [GitHub Issues](https://github.com/VOTRE_USERNAME/com.monochrome.music/issues)

---

<div align="center">

**Monochrome Music Player** - Fait avec ❤️ pour la communauté Linux

[⬆ Retour en haut](#monochrome-music-player---flatpak)

</div>
