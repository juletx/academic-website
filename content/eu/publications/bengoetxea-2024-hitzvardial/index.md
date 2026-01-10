---
title: 'HiTZ at VarDial 2025 NorSID: Overcoming Data Scarcity with Language Transfer
  and Automatic Data Annotation'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Jaione Bengoetxea
- Mikel Zubillaga
- Ekhi Azurmendi
- Maite Heredia
- Julen Etxaniz
- Markel Ferro
- Jeremy Barnes

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2024-12-13'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2024-12-13'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*COLING 2025*'
publication_short: ''

doi: ''

abstract: 'In this paper we present our submission for the NorSID Shared Task as part
  of the 2025 VarDial Workshop (Scherrer et al., 2025), consisting of three tasks:
  Intent Detection, Slot Filling and Dialect Identification, evaluated using data
  in different dialects of the Norwegian language. For Intent Detection and Slot Filling,
  we have fine-tuned a multitask model in a cross-lingual setting, to leverage the
  xSID dataset available in 17 languages. In the case of Dialect Identification, our
  final submission consists of a model fine-tuned on the provided development set,
  which has obtained the highest scores within our experiments. Our final results
  on the test set show that our models do not drop in performance compared to the
  development set, likely due to the domain-specificity of the dataset and the similar
  distribution of both subsets. Finally, we also report an in-depth analysis of the
  provided datasets and their artifacts, as well as other sets of experiments that
  have been carried out but did not yield the best results. Additionally, we present
  an analysis on the reasons why some methods have been more successful than others;
  mainly the impact of the combination of languages and domain-specificity of the
  training data on the results.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality
- Dialects
- Norwegian

# Display this page in a list of Featured pages?
featured: false

# Links
links:
  - name: arXiv
    url: https://arxiv.org/abs/2412.10095
  - type: pdf
    url: https://arxiv.org/pdf/2412.10095
  - type: code
    url: https://github.com/hitz-zentroa/vardial-2025

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
