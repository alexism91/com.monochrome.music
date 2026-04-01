# Contribuer à Monochrome Flatpak

Merci de votre intérêt pour contribuer au packaging Flatpak de Monochrome !

Ce document couvre les contributions au **packaging Flatpak uniquement**. Pour contribuer à l'application Monochrome elle-même, voir [monochrome-music/monochrome/CONTRIBUTING.md](https://github.com/monochrome-music/monochrome/blob/main/CONTRIBUTING.md).

---

## 📖 Table des Matières

- [Comment Contribuer](#comment-contribuer)
- [Prérequis](#prérequis)
- [Structure du Projet](#structure-du-projet)
- [Guide de Développement](#guide-de-développement)
- [Standards de Code](#standards-de-code)
- [Pull Requests](#pull-requests)
- [Rapporter un Bug](#rapporter-un-bug)
- [Demandes de Fonctionnalités](#demandes-de-fonctionnalités)

---

## Comment Contribuer

### 1. Fork et Clone

```bash
# Fork sur GitHub puis clone
git clone https://github.com/VOTRE_USERNAME/com.monochrome.music.git
cd com.monochrome.music

# Initialiser le sous-module
git submodule update --init --recursive
```

### 2. Créer une Branche

```bash
git checkout -b feature/ma-super-fonctionnalite
```

### 3. Faire les Modifications

Suivez le [Guide de Développement](#guide-de-développement) ci-dessous.

### 4. Tester

```bash
./flatpak/scripts/build.sh
flatpak run com.monochrome.music
```

### 5. Commit et Push

```bash
git add .
git commit -m "feat: ajouter ma super fonctionnalité"
git push origin feature/ma-super-fonctionnalite
```

### 6. Ouvrir une Pull Request

Sur GitHub, ouvrez une PR depuis votre branche.

---

## Prérequis

### Outils Requis

- **Flatpak** : `flatpak` et `flatpak-builder`
- **Git** : Pour cloner et gérer le repository
- **Node.js** : Inclus dans le SDK Flatpak (node22)

### Installation des Outils

#### Fedora

```bash
sudo dnf install flatpak flatpak-builder git
```

#### Ubuntu/Debian

```bash
sudo apt install flatpak flatpak-builder git
```

#### Arch Linux

```bash
sudo pacman -S flatpak flatpak-builder git
```

### Configuration du SDK

```bash
# Ajouter Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installer le SDK
flatpak install flathub org.freedesktop.Sdk//24.08
flatpak install flathub org.freedesktop.Sdk.Extension.node22//24.08
```

---

## Structure du Projet

```
com.monochrome.music/
├── flathub/                    # Fichiers pour Flathub
│   ├── com.monochrome.music.json    # Manifeste principal
│   ├── com.monochrome.music.desktop # Fichier .desktop
│   ├── com.monochrome.music.appdata.xml # Métadonnées AppStream
│   ├── monochrome/                  # Fichiers Electron
│   ├── icons/                       # Icônes
│   └── screenshots/                 # Captures d'écran
├── flatpak/                    # Scripts et ressources
│   ├── scripts/
│   ├── sources/
│   └── resources/
├── monochrome/                 # Sous-module (app principale)
├── README.md
├── LICENSE
└── CONTRIBUTING.md
```

### Fichiers Clés

| Fichier | Description |
|---------|-------------|
| `flathub/com.monochrome.music.json` | Manifeste Flatpak principal |
| `flathub/com.monochrome.music.desktop` | Fichier .desktop pour le menu |
| `flathub/com.monochrome.music.appdata.xml` | Métadonnées AppStream |
| `flatpak/scripts/build.sh` | Script de build |
| `flatpak/sources/com.monochrome.music.json` | Manifeste pour le build |

---

## Guide de Développement

### Modifier le Manifeste

Le fichier `flathub/com.monochrome.music.json` est le manifeste principal.

**Exemple : Ajouter une permission**

```json
{
    "finish-args": [
        "--share=network",
        "--socket=wayland",
        // Ajouter votre permission ici
        "--talk-name=org.example.Service"
    ]
}
```

### Build et Test

```bash
# Build complet
./flatpak/scripts/build.sh

# Installer et tester
flatpak install --user build/com.monochrome.music.flatpak
flatpak run com.monochrome.music
```

### Débogage

```bash
# Lancer avec logs
flatpak run com.monochrome.music --enable-logging

# Voir les logs
journalctl -f | grep -i monochrome
```

### Validation

```bash
# Valider le fichier .desktop
desktop-file-validate flathub/com.monochrome.music.desktop

# Valider AppStream
appstreamcli validate flathub/com.monochrome.music.appdata.xml
```

---

## Standards de Code

### Scripts Shell

- Utiliser `set -euo pipefail` en début de script
- Utiliser des variables pour les chemins
- Commenter les étapes importantes

**Exemple :**

```bash
#!/bin/bash
set -euo pipefail

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Vérifier les prérequis
command -v flatpak-builder >/dev/null 2>&1 || {
    echo "❌ ERROR: flatpak-builder not installed"
    exit 1
}
```

### JSON

- Utiliser 4 espaces pour l'indentation
- Une clé par ligne
- Virgule trailing autorisée pour les listes

### XML (AppStream)

- Suivre la [spécification AppStream](https://www.freedesktop.org/software/appstream/docs/)
- Valider avec `appstreamcli validate`

### Commits

Suivre [Conventional Commits](https://www.conventionalcommits.org/) :

```
feat: ajouter le support des notifications
fix: corriger le chemin de l'icône
docs: mettre à jour le README
chore: nettoyer les fichiers de build
```

---

## Pull Requests

### Avant de Soumettre

- [ ] Le build fonctionne sans erreur
- [ ] Les fichiers sont validés (`desktop-file-validate`, `appstreamcli validate`)
- [ ] Le README est à jour si nécessaire
- [ ] Les commits suivent les standards

### Template de PR

```markdown
## Description

Brève description des changements.

## Type de Changement

- [ ] Bug fix
- [ ] Nouvelle fonctionnalité
- [ ] Amélioration
- [ ] Documentation
- [ ] Autre (préciser)

## Checklist

- [ ] J'ai testé le build localement
- [ ] Les fichiers sont valides
- [ ] J'ai mis à jour la documentation si nécessaire
```

---

## Rapporter un Bug

### Template de Bug Report

```markdown
**Description du bug**
Une description claire du bug.

**Étapes pour reproduire**
1. Étape 1
2. Étape 2
3. Étape 3

**Comportement attendu**
Ce qui aurait dû se produire.

**Captures d'écran**
Si applicable.

**Environnement :**
- Distribution : [Fedora 38, Ubuntu 22.04, etc.]
- Version Flatpak : `flatpak --version`
- Version de l'app : 2.5.0
```

### Bugs Connus

| Bug | Statut | Workaround |
|-----|--------|------------|
| OAuth ne fonctionne pas | ⚠️ Limitation PocketBase | Utiliser Email/Mot de passe |

---

## Demandes de Fonctionnalités

### Template de Feature Request

```markdown
**Description**
Une description claire de la fonctionnalité souhaitée.

**Problème associé**
Est-ce lié à un problème ? Décrivez-le.

**Solution souhaitée**
Comment devrait fonctionner cette fonctionnalité ?

**Alternatives envisagées**
Autres solutions possibles.

**Contexte additionnel**
Autres informations utiles.
```

---

## Ressources Utiles

- [Documentation Flathub](https://docs.flathub.org/docs/for-app-authors/)
- [Exigences Flathub](https://docs.flathub.org/docs/for-app-authors/requirements)
- [Flatpak Documentation](https://docs.flatpak.org/)
- [AppStream Specification](https://www.freedesktop.org/software/appstream/docs/)

---

## Contact

- **Issues** : [GitHub Issues](https://github.com/VOTRE_USERNAME/com.monochrome.music/issues)
- **Discussions** : [GitHub Discussions](https://github.com/VOTRE_USERNAME/com.monochrome.music/discussions)

---

Merci de contribuer à Monochrome Flatpak ! 🎵
