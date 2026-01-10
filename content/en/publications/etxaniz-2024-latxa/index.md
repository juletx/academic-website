---
title: 'Latxa: An Open Language Model and Evaluation Suite for Basque'

# Authors
# A YAML list of author names
# If you created a profile for a user (e.g. the default `admin` user at `content/authors/admin/`), 
# write the username (folder name) here, and it will be replaced with their full name and linked to their profile.
authors:
- Julen Etxaniz
- Oscar Sainz
- Naiara Perez
- Itziar Aldabe
- German Rigau
- Eneko Agirre
- Aitor Ormazabal
- Mikel Artetxe
- Aitor Soroa

# Author notes (such as 'Equal Contribution')
# A YAML list of notes for each author in the above `authors` list
author_notes: []

date: '2024-03-29'

# Date to publish webpage (NOT necessarily Bibtex publication's date).
publishDate: '2024-03-29'

# Publication type.
# A single CSL publication type but formatted as a YAML list (for Hugo requirements).
publication_types:
- article-journal

# Publication name and optional abbreviated publication name.
publication: '*ACL 2024*'
publication_short: ''

doi: ''

abstract: 'We introduce Latxa, a family of large language models for Basque ranging
  from 7 to 70 billion parameters. Latxa is based on Llama 2, which we continue pretraining
  on a new Basque corpus comprising 4.3M documents and 4.2B tokens. Addressing the
  scarcity of high-quality benchmarks for Basque, we further introduce 4 multiple
  choice evaluation datasets: EusProficiency, comprising 5,169 questions from official
  language proficiency exams; EusReading, comprising 352 reading comprehension questions;
  EusTrivia, comprising 1,715 trivia questions from 5 knowledge areas; and EusExams,
  comprising 16,774 questions from public examinations. In our extensive evaluation,
  Latxa outperforms all previous open models we compare to by a large margin. In addition,
  it is competitive with GPT-4 Turbo in language proficiency and understanding, despite
  lagging behind in reading comprehension and knowledge-intensive tasks. Both the
  Latxa family of models, as well as our new pretraining corpora and evaluation datasets,
  are publicly available under open licenses at https://github.com/hitz-zentroa/latxa.
  Our suite enables reproducible research on methods to build LLMs for low-resource
  languages.'

# Summary. An optional shortened abstract.
summary: ''

tags:
- Natural Language Processing
- Large Language Models
- Deep Learning
- Multilinguality
- Basque

# Display this page in a list of Featured pages?
featured: true

# Links
links:
  - type: pdf
    url: https://arxiv.org/pdf/2403.20266
  - type: code
    url: https://github.com/hitz-zentroa/latxa
  - type: dataset
    url: https://huggingface.co/collections/HiTZ/latxa-65a697e6838b3acc53677304
  - name: arXiv
    url: https://arxiv.org/abs/2403.20266

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
