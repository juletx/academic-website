---
title: 'Truth Knows No Language: Evaluating Truthfulness Beyond English'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Blanca Calvo Figueras
- Eneko Sagarzazu
- Julen Etxaniz
- Jeremy Barnes
- Pablo Gamallo
- Iria de-Dios-Flores
- Rodrigo Agerri

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2025-07-27'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: ''

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*ACL 2025*'
publication_short: ''

abstract: We introduce a professionally translated extension of the TruthfulQA benchmark
  designed to evaluate truthfulness in Basque, Catalan, Galician, and Spanish. Truthfulness
  evaluations of large language models (LLMs) have primarily been focused on English.
  However, the ability of LLMs to maintain truthfulness across languages remains under-explored.
  Our study evaluates 12 state-of-the-art open LLMs, comparing base and instruction-tuned
  models using human evaluation, multiple-choice metrics, and LLM-as-a-Judge scoring.
  Our findings reveal that, while LLMs perform best in English and worst in Basque
  (the lowest-resourced language), overall truthfulness discrepancies across languages
  are smaller than anticipated. Furthermore, we show that LLM-as-a-Judge correlates
  more closely with human judgments than multiple-choice metrics, and that informativeness
  plays a critical role in truthfulness assessment. Our results also indicate that
  machine translation provides a viable approach for extending truthfulness benchmarks
  to additional languages, offering a scalable alternative to professional translation.
  Finally, we observe that universal knowledge questions are better handled across
  languages than context- and time-dependent ones, highlighting the need for truthfulness
  evaluations that account for cultural and temporal variability. Datasets, models
  and code are publicly available under open licenses.

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality
- Truthfulness
- Evaluation

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
- name: URL
  url: https://aclanthology.org/2025.acl-long.1507/
- type: pdf
  url: https://aclanthology.org/2025.acl-long.1507.pdf
- type: code
  url: https://github.com/hitz-zentroa/truthfulqa-multi
- type: dataset
  url: https://hf.co/collections/HiTZ/multilingual-truthfulqa
- type: model
  url: https://hf.co/collections/HiTZ/multilingual-truthfulqa
---


