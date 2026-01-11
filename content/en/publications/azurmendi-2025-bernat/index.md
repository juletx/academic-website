---
title: 'BERnaT: Basque Encoders for Representing Natural Textual Diversity'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Ekhi Azurmendi
- Joseba Fernandez de Landa
- Jaione Bengoetxea
- Maite Heredia
- Julen Etxaniz
- Mikel Zubillaga
- Ander Soraluze
- Aitor Soroa

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2025-12-03'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: ''

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*arXiv*'
publication_short: ''

doi: ''

abstract: 'Language models depend on massive text corpora that are often filtered
  for quality, a process that can unintentionally exclude non-standard linguistic
  varieties, reduce model robustness and reinforce representational biases. In this
  paper, we argue that language models should aim to capture the full spectrum of
  language variation (dialectal, historical, informal, etc.) rather than relying solely
  on standardized text. Focusing on Basque, a morphologically rich and low-resource
  language, we construct new corpora combining standard, social media, and historical
  sources, and pre-train the BERnaT family of encoder-only models in three configurations:
  standard, diverse, and combined. We further propose an evaluation framework that
  separates Natural Language Understanding (NLU) tasks into standard and diverse subsets
  to assess linguistic generalization. Results show that models trained on both standard
  and diverse data consistently outperform those trained on standard corpora, improving
  performance across all task types without compromising standard benchmark accuracy.
  These findings highlight the importance of linguistic diversity in building inclusive,
  generalizable language models.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Evaluation
- Multilinguality
- Basque
- Linguistic Diversity

# Display this page in a list of Featured pages?
featured: false

# Links
url_pdf: ''
url_code: ''
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: ''
url_video: ''

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
links:
- name: arXiv
  url: https://arxiv.org/abs/2512.03903
- type: pdf
  url: https://arxiv.org/pdf/2512.03903.pdf
- type: code
  url: https://github.com/hitz-zentroa/BERnaT
- type: dataset
  url: https://huggingface.co/collections/HiTZ/bernat
- type: model
  url: https://huggingface.co/collections/HiTZ/bernat
---
