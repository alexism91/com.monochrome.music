---
name: Pull Request
description: Propose changes to the Monochrome Flatpak packaging
labels: [enhancement]
body:
  - type: markdown
    attributes:
      value: |
        Merci de votre contribution ! Veuillez remplir ce formulaire pour nous aider à reviewer votre PR.

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Décrivez clairement les changements apportés.
      placeholder: Cette PR ajoute/modifie...
    validations:
      required: true

  - type: dropdown
    id: change-type
    attributes:
      label: Type de changement
      options:
        - Bug fix
        - Nouvelle fonctionnalité
        - Amélioration
        - Documentation
        - Refactoring
        - Autre (préciser)
    validations:
      required: true

  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      options:
        - label: J'ai testé le build localement (`./flatpak/scripts/build.sh`)
          required: true
        - label: Les fichiers sont valides (desktop-file-validate, appstreamcli validate)
          required: true
        - label: J'ai mis à jour la documentation si nécessaire
          required: false

  - type: textarea
    id: testing
    attributes:
      label: Comment tester ?
      description: Étapes pour tester vos changements.
      placeholder: |
        1. Builder avec ./flatpak/scripts/build.sh
        2. Installer avec flatpak install ...
        3. Lancer et vérifier que...

  - type: textarea
    id: screenshots
    attributes:
      label: Captures d'écran (si applicable)
      description: Ajoutez des captures d'écran pour illustrer vos changements.

  - type: textarea
    id: additional-context
    attributes:
      label: Contexte additionnel
      description: Toute information complémentaire utile.
