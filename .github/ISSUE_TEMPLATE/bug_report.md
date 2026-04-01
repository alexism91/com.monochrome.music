---
name: Bug Report
description: Signaler un bug dans le packaging Flatpak
labels: [bug]
body:
  - type: markdown
    attributes:
      value: |
        Merci de signaler un bug ! Veuillez remplir ce formulaire pour nous aider à identifier le problème.

  - type: textarea
    id: description
    attributes:
      label: Description du bug
      description: Une description claire et concise du bug.
      placeholder: Le bug se produit quand...
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: Étapes pour reproduire
      description: Liste d'étapes pour reproduire le bug.
      placeholder: |
        1. Lancer l'application
        2. Cliquer sur...
        3. Observer l'erreur...
    validations:
      required: true

  - type: textarea
    id: expected
    attributes:
      label: Comportement attendu
      description: Ce qui aurait dû se produire.
    validations:
      required: true

  - type: textarea
    id: actual
    attributes:
      label: Comportement réel
      description: Ce qui s'est réellement produit.
    validations:
      required: true

  - type: textarea
    id: screenshots
    attributes:
      label: Captures d'écran
      description: Ajoutez des captures d'écran si applicable.

  - type: input
    id: distribution
    attributes:
      label: Distribution
      description: Votre distribution Linux et version.
      placeholder: Fedora 38, Ubuntu 22.04, etc.
    validations:
      required: true

  - type: input
    id: flatpak-version
    attributes:
      label: Version de Flatpak
      description: Résultat de `flatpak --version`
    validations:
      required: true

  - type: textarea
    id: additional-context
    attributes:
      label: Contexte additionnel
      description: Toute information complémentaire utile.
