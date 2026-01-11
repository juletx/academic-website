---
title: 'Multimodal Large Language Models for Low-Resource Languages: A Case Study
  for Basque'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Lukas Arana
- Julen Etxaniz
- Ander Salaberria
- Gorka Azkune

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2025-11-12'

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

abstract: 'Current Multimodal Large Language Models exhibit very strong performance
  for several demanding tasks. While commercial MLLMs deliver acceptable performance
  in low-resource languages, comparable results remain unattained within the open
  science community. In this paper, we aim to develop a strong MLLM for a low-resource
  language, namely Basque. For that purpose, we develop our own training and evaluation
  image-text datasets. Using two different Large Language Models as backbones, the
  Llama-3.1-Instruct model and a Basque-adapted variant called Latxa, we explore several
  data mixtures for training. We show that: i) low ratios of Basque multimodal data
  (around 20%) are already enough to obtain solid results on Basque benchmarks, and
  ii) contrary to expected, a Basque instructed backbone LLM is not required to obtain
  a strong MLLM in Basque. Our results pave the way to develop MLLMs for other low-resource
  languages by openly releasing our resources.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Evaluation
- Multilinguality
- Basque
- Multimodal

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
  url: https://arxiv.org/abs/2511.09396
- type: pdf
  url: https://arxiv.org/pdf/2511.09396.pdf
- type: dataset
  url: https://huggingface.co/collections/lukasArana
---


