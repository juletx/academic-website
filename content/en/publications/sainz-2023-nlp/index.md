---
title: 'NLP Evaluation in trouble: On the Need to Measure LLM Data Contamination for
  each Benchmark'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Oscar Sainz
- Jon Ander Campos
- Iker García-Ferrero
- Julen Etxaniz
- Oier Lopez de Lacalle
- Eneko Agirre

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2023-10-27'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2023-10-27'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*EMNLP 2023 Findings*'
publication_short: ''

doi: ''

abstract: In this position paper, we argue that the classical evaluation on Natural
  Language Processing (NLP) tasks using annotated benchmarks is in trouble. The worst
  kind of data contamination happens when a Large Language Model (LLM) is trained
  on the test split of a benchmark, and then evaluated in the same benchmark. The
  extent of the problem is unknown, as it is not straightforward to measure. Contamination
  causes an overestimation of the performance of a contaminated model in a target
  benchmark and associated task with respect to their non-contaminated counterparts.
  The consequences can be very harmful, with wrong scientific conclusions being published
  while other correct ones are discarded. This position paper defines different levels
  of data contamination and argues for a community effort, including the development
  of automatic and semi-automatic measures to detect when data from a benchmark was
  exposed to a model, and suggestions for flagging papers with conclusions that are
  compromised by data contamination.

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Evaluation
- Data Contamination
- Deep Learning

# Display this page in a list of Featured pages?
featured: false

# Links
links:
  - type: pdf
    url: https://arxiv.org/pdf/2308.01223.pdf
  - name: arXiv
    url: https://arxiv.org/abs/2310.18018

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
