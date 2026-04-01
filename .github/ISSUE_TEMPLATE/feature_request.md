---
name: Feature Request
description: Suggérer une nouvelle fonctionnalité
labels: [enhancement]
body:
  - type: markdown
    attributes:
      value: |
        Merci de votre suggestion ! Veuillez remplir ce formulaire pour décrire votre idée.

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Décrivez la fonctionnalité souhaitée.
      placeholder: J'aimerais que...
    validations:
      required: true

  - type: textarea
    id: problem
    attributes:
      label: Problème associé
      description: Est-ce lié à un problème ? Décrivez-le.
      placeholder: Je suis frustré quand...

  - type: textarea
    id: solution
    attributes:
      label: Solution souhaitée
      description: Comment devrait fonctionner cette fonctionnalité ?
    validations:
      required: true

  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives envisagées
      description: Autres solutions possibles.

  - type: textarea
    id: additional-context
    attributes:
      label: Contexte additionnel
      description: Toute information complémentaire utile.
