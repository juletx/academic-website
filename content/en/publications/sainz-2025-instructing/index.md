---
title: 'Instructing Large Language Models for Low-Resource Languages: A Systematic
  Study for Basque'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Oscar Sainz
- Naiara Perez
- Julen Etxaniz
- Joseba Fernandez de Landa
- Itziar Aldabe
- Iker García-Ferrero
- Aimar Zabala
- Ekhi Azurmendi
- German Rigau
- Eneko Agirre
- Mikel Artetxe
- Aitor Soroa

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2025-11-04'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: ''

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*EMNLP 2025*'
publication_short: ''

abstract: 'Instructing language models with user intent requires large instruction
  datasets, which are only available for a limited set of languages. In this paper,
  we explore alternatives to conventional instruction adaptation pipelines in low-resource
  scenarios. We assume a realistic scenario for low-resource languages, where only
  the following are available: corpora in the target language, existing open-weight
  multilingual base and instructed backbone LLMs, and synthetically generated instructions
  sampled from the instructed backbone. We present a comprehensive set of experiments
  for Basque that systematically study different combinations of these components
  evaluated on benchmarks and human preferences from 1,680 participants. Our conclusions
  show that target language corpora are essential, with synthetic instructions yielding
  robust models, and, most importantly, that using as backbone an instruction-tuned
  model outperforms using a base non-instructed model. Scaling up to Llama 3.1 Instruct
  70B as backbone, our model comes near frontier models of much larger sizes for Basque,
  without using any Basque instructions. We release code, models, instruction datasets,
  and human preferences to support full reproducibility in future research on low-resource
  language adaptation.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality
- Basque
- Instruction Tuning

# Display this page in a list of Featured pages?
featured: true

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
  url: https://aclanthology.org/2025.emnlp-main.1484/
- type: pdf
  url: https://aclanthology.org/2025.emnlp-main.1484.pdf
- type: code
  url: https://github.com/hitz-zentroa/latxa-instruct
- type: dataset
  url: https://huggingface.co/collections/HiTZ/latxa-instruct
- type: model
  url: https://huggingface.co/collections/HiTZ/latxa-instruct
- type: site
  url: https://latxa.hitz.eus/
---


