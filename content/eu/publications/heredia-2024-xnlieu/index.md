---
title: 'XNLIeu: a dataset for cross-lingual NLI in Basque'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Maite Heredia
- Julen Etxaniz
- Muitze Zulaika
- Xabier Saralegi
- Jeremy Barnes
- Aitor Soroa

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: "2024-04-10"

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2024-04-10'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*NAACL 2024*'
publication_short: ''

doi: ''

abstract: XNLI is a popular Natural Language Inference (NLI) benchmark widely used
  to evaluate cross-lingual Natural Language Understanding (NLU) capabilities across
  languages. In this paper, we expand XNLI to include Basque, a low-resource language
  that can greatly benefit from transfer-learning approaches. The new dataset, dubbed
  XNLIeu, has been developed by first machine-translating the English XNLI corpus
  into Basque, followed by a manual post-edition step. We have conducted a series
  of experiments using mono- and multilingual LLMs to assess a) the effect of professional
  post-edition on the MT system; b) the best cross-lingual strategy for NLI in Basque;
  and c) whether the choice of the best cross-lingual strategy is influenced by the
  fact that the dataset is built by translation. The results show that post-edition
  is necessary and that the translate-train cross-lingual strategy obtains better
  results overall, although the gain is lower when tested in a dataset that has been
  built natively from scratch. Our code and datasets are publicly available under
  open licenses at https://github.com/hitz-zentroa/xnli-eu.

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality
- Basque

# Display this page in a list of Featured pages?
featured: false

# Links
links:
  - name: arXiv
    url: https://arxiv.org/abs/2404.06996
  - type: pdf
    url: https://arxiv.org/pdf/2404.06996
  - type: code
    url: https://github.com/hitz-zentroa/xnli-eu
  - type: dataset
    url: https://huggingface.co/datasets/HiTZ/xnli-eu

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
