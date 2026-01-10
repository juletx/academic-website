---
title: 'BertaQA: How Much Do Language Models Know About Local Culture?'

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

date: '2024-06-11'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2024-06-11'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*NeurIPS Datasets and Benchmarks 2024*'
publication_short: ''

doi: ''

abstract: Large Language Models (LLMs) exhibit extensive knowledge about the world,
  but most evaluations have been limited to global or anglocentric subjects. This
  raises the question of how well these models perform on topics relevant to other
  cultures, whose presence on the web is not that prominent. To address this gap,
  we introduce BertaQA, a multiple-choice trivia dataset that is parallel in English
  and Basque. The dataset consists of a local subset with questions pertinent to the
  Basque culture, and a global subset with questions of broader interest. We find
  that state-of-the-art LLMs struggle with local cultural knowledge, even as they
  excel on global topics. However, we show that continued pre-training in Basque significantly
  improves the models' performance on Basque culture, even when queried in English.
  To our knowledge, this is the first solid evidence of knowledge transfer from a
  low-resource to a high-resource language. Our analysis sheds light on the complex
  interplay between language and knowledge, and reveals that some prior findings do
  not fully hold when reassessed on local topics. Our dataset and evaluation code
  are available under open licenses at https://github.com/juletx/BertaQA.

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Evaluation
- Multilinguality
- Culture
- Basque

# Display this page in a list of Featured pages?
featured: true

# Links
links:
  - type: pdf
    url: https://arxiv.org/pdf/2406.07302
  - type: code
    url: https://github.com/juletx/BertaQA
  - type: dataset
    url: https://huggingface.co/datasets/HiTZ/BertaQA
  - name: arXiv
    url: https://arxiv.org/abs/2406.07302

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
