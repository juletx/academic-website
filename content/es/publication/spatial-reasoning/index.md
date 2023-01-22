---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Grounding Language Models for Compositional and Spatial Reasoning"
authors: ["julen-etxaniz"]
date: 2022-10-21
doi: ""

# Schedule page publish date (NOT publication's date).
publishDate: ""

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["7"]

# Publication name and optional abbreviated publication name.
publication: "ADDI"
publication_short: ""

abstract: 'Humans can learn to understand and process the distribution of space, and one of the initial tasks of Artificial Intelligence has been to show machines the relationships between space and the objects that appear in it. Humans naturally combine vision and textual information to acquire compositional and spatial relationships among objects, and when reading a text, we are able to mentally depict the spatial relationships that may appear in it. Thus, the visual differences between images depicting "a person sits and a dog stands" and "a person stands and a dog sits" are obvious for humans, but still not clear for automatic systems.

In this project, we propose to evaluate grounded Neural Language models that can perform compositional and spatial reasoning. Neural Language models (LM) have shown impressive capabilities on many NLP tasks but, despite their success, they have been criticized for their lack of meaning. Vision-and-Language models (VLM), trained jointly on text and image data, have been offered as a response to such criticisms, but recent work has shown that these models struggle to ground spatial concepts properly. In the project, we evaluate state-of-the-art pre-trained and fine-tuned VLMs to understand their grounding level on compositional and spatial reasoning. We also propose a variety of methods to create synthetic datasets specially focused on compositional reasoning.

We managed to accomplish all the objectives of this work. First, we improved the state-of-the-art in compositional reasoning. Next, we performed some zero-shot experiments on spatial reasoning. Finally, we explored three alternatives for synthetic dataset creation: text-to-image generation, image captioning and image retrieval. Code is released at https://github.com/juletx/spatial-reasoning and models are released at https://huggingface.co/juletxara.'

# Summary. An optional shortened abstract.
summary: ""

tags: 
- Machine Learning
- Deep Learning
- Natural Language Processing
categories: []
featured: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

url_pdf: https://github.com/juletx/spatial-reasoning/blob/master/thesis/thesis.pdf
url_code: https://github.com/juletx/spatial-reasoning
url_dataset:
url_poster:
url_project:
url_slides: https://github.com/juletx/spatial-reasoning/blob/master/slides/master_thesis_slides_julen_etxaniz.pdf
url_source:
url_video:

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: ["spatial-reasoning"]

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: ""
---
