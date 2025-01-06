---
title: 'GITA4CALAMITA - Evaluating the Physical Commonsense Understanding of Italian
  LLMs in a Multi-layered Approach: A CALAMITA Challenge'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Giulia Pensa
- Ekhi Azurmendi
- Julen Etxaniz
- Begoña Altuna
- Itziar Gonzalez-Dios

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2024-12-06'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2024-12-06'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*CLiC-it 2024*'
publication_short: ''

doi: ''

abstract: 'In the context of the CALAMITA Challenge, we investigate the physical commonsense
  reasoning capabilities of large language models (LLMs) and introduce a methodology
  to assess their understanding of the physical world. To this end, we use a test
  set designed to evaluate physical commonsense reasoning in LLMs for the Italian
  language. We present a tiered dataset, named the Graded Italian Annotated dataset
  (GITA), which is written and annotated by a professional linguist. This dataset
  enables us to focus on three distinct levels of commonsense understanding. Our benchmark
  aims to evaluate three specific tasks: identifying plausible and implausible stories
  within our dataset, identifying the conflict that generates an implausible story,
  and identifying the physical states that make a story implausible. We perform these
  tasks using LLAMA3, Gemma2 and Mistral. Our findings reveal that, although the models
  may excel at high-level classification tasks, their reasoning is inconsistent and
  unverifiable, as they fail to capture intermediate evidence.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Evaluation
- Commonsense Reasoning
- Italian

# Display this page in a list of Featured pages?
featured: true

# Links
url_pdf: https://ceur-ws.org/Vol-3878/127_calamita_long.pdf
url_code: https://github.com/EkhiAzur/GITA4CALAMITA
url_dataset: https://huggingface.co/datasets/juletxara/GITA4CALAMITA
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
---
