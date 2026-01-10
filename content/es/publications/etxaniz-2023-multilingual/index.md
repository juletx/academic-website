---
title: Do Multilingual Language Models Think Better in English?

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Julen Etxaniz
- Gorka Azkune
- Aitor Soroa
- Oier Lopez de Lacalle
- Mikel Artetxe

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2023-08-02'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2023-08-02'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*NAACL 2024*'
publication_short: ''

doi: ''

abstract: Translate-test is a popular technique to improve the performance of multilingual
  language models. This approach works by translating the input into English using
  an external machine translation system, and running inference over the translated
  input. However, these improvements can be attributed to the use of a separate translation
  system, which is typically trained on large amounts of parallel data not seen by
  the language model. In this work, we introduce a new approach called self-translate,
  which overcomes the need of an external translation system by leveraging the few-shot
  translation capabilities of multilingual language models. Experiments over 5 tasks
  show that self-translate consistently outperforms direct inference, demonstrating
  that language models are unable to leverage their full multilingual potential when
  prompted in non-English languages. Our code is available at https://github.com/juletx/self-translate.

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality

# Display this page in a list of Featured pages?
featured: true

# Links
links:
  - name: arXiv
    url: https://arxiv.org/abs/2308.01223
  - type: pdf
    url: https://arxiv.org/pdf/2308.01223.pdf
  - type: code
    url: https://github.com/juletx/self-translate
  - type: dataset
    url: https://huggingface.co/juletxara

# Links

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

# Publication image
# Add an image named `featured.jpg/png` to your page's folder then add a caption below.
image:
  caption: ''
  focal_point: ''
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects: ['internal-project']` links to `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: []
---
