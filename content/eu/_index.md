---
# Leave the homepage title empty to use the site title
title:
date: 2023-01-22
type: landing

sections:
  # Developer Hero - Gradient background with name, role, social, and CTAs
  - block: dev-hero
    id: hero
    content:
      username: julen-etxaniz-eu
      greeting: ""
      show_status: true
      show_scroll_indicator: false
      typewriter:
        enable: true
        prefix: "Ikerketa egiten dut"
        strings:
          - "HP"
          - "LLMak"
          - "Ebaluazioa"
          - "Eleaniztasuna"
          - "Baliabide gutxiko hizkuntzak"
        type_speed: 70
        delete_speed: 40
        pause_time: 2500
      cta_buttons:
        - text: Argitalpenak
          url: "#publications"
          icon: book-open
        - text: Proiektuak
          url: "#projects"
          icon: arrow-down
    design:
      style: centered
      avatar_shape: circle
      animations: true
      spacing:
        padding: ["6rem", "0", "4rem", "0"]
  - block: resume-experience
    id: experience
    content:
      username: julen-etxaniz-eu
    design:
      # Hugo date format
      date_format: 'January 2006'
      # Education or Experience section first?
      is_education_first: false
  - block: resume-awards
    id: awards
    content:
      title: Sariak
      username: julen-etxaniz-eu
  - block: tech-stack
    id: skills
    content:
      title: "Trebetasunak"
      subtitle: ""
      categories:
        - name: Programming Languages
          items:
            - name: Python
              icon: devicon/python
            - name: R
              icon: devicon/r
            - name: Java
              icon: devicon/java
            - name: JavaScript
              icon: devicon/javascript
            - name: PHP
              icon: devicon/php
            - name: C
              icon: devicon/c
        - name: Web Development
          items:
            - name: Bootstrap
              icon: devicon/bootstrap
            - name: Tailwind CSS
              icon: devicon/tailwindcss
            - name: Hugo
              icon: devicon/hugo
            - name: Alpine.js
              icon: devicon/alpinejs
            - name: jQuery
              icon: devicon/jquery
            - name: Netlify
              icon: devicon/netlify
        - name: Machine Learning
          items:
            - name: Scikit-Learn
              icon: devicon/scikitlearn
            - name: TensorFlow
              icon: devicon/tensorflow
            - name: PyTorch
              icon: devicon/pytorch
            - name: Keras
              icon: devicon/keras
            - name: Kaggle
              icon: devicon/kaggle
            - name: Hugging Face
              icon: brands/huggingface
        - name: Data
          items:
            - name: MySQL
              icon: devicon/mysql
            - name: SQLite
              icon: devicon/sqlite
            - name: PostgreSQL
              icon: devicon/postgresql
            - name: XML
              icon: devicon/xml 
            - name: JSON
              icon: devicon/json
            - name: YAML
              icon: devicon/yaml
        - name: Editors & Source Control
          items:
            - name: VS Code
              icon: devicon/vscode
            - name: LaTeX
              icon: devicon/latex
            - name: Jupyter
              icon: devicon/jupyter
            - name: Git
              icon: devicon/git
            - name: GitHub
              icon: devicon/github
            - name: GitHub Actions
              icon: devicon/githubactions
        - name: Other Tools
          items:
            - name: Matplotlib
              icon: devicon/matplotlib
            - name: Numpy
              icon: devicon/numpy
            - name: Pandas
              icon: devicon/pandas
            - name: Docker
              icon: devicon/docker
            - name: PyPI
              icon: devicon/pypi
            - name: PNPM
              icon: devicon/pnpm
    design:
      style: grid
      show_levels: false
  - block: collection
    id: publications
    content:
      title: Argitalpen Nabarmenak
      filters:
        folders:
          - publications
        featured_only: true
      count: 6
    design:
      view: article-grid
      columns: 2
  - block: collection
    content:
      title: Argitalpen Berriak
      text: ''
      filters:
        folders:
          - publications
        exclude_featured: true
      count: 6
    design:
      view: article-grid
  - block: portfolio
    id: projects
    content:
      title: Proiektuak
      filters:
        folders:
          - projects
      # Default filter index (e.g. 0 corresponds to the first `filter_button` instance below).
      default_button_index: 0
      count: 100
      # Filter toolbar (optional).
      # Add or remove as many filters (`filter_button` instances) as you like.
      # To show all items, set `tag` to "*".
      # To filter by a specific tag, set `tag` to an existing tag name.
      # To remove the toolbar, delete the entire `filter_button` block.
      buttons:
      - name: Denak
        tag: '*'
      - name: Programazioa
        tag: Programming
      - name: Web Garapena
        tag: Web Development
      - name: Software Ingeniaritza
        tag: Software Engineering
      - name: Ikasketa Automatikoa
        tag: Machine Learning
      - name: Ikasketa Sakona
        tag: Deep Learning
      - name: Hizkuntzaren Prozesamendua
        tag: Natural Language Processing
    design:
      # Choose how many columns the section has. Valid values: '1' or '2'.
      columns: '1'
      view: masonry
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
  - block: knowledge-tags
    id: tags
    content:
      title: "Etiketak"
      # Choose the taxonomy from `config.toml` to display (e.g. tags, categories)
      taxonomy: tags
      # Choose how many tags you would like to display (0 = all tags)
      count: 20
    design:
      columns: '2'
      # Minimum and maximum font sizes (1.0 = 100%).
      font_size_min: 0.7
      font_size_max: 2.0
  - block: contact-info
    id: contact
    content:
      title: Kontaktua
      visit_title: "Bisitatu gaitzazu"
      address:
        lines:
          - 'Informatika Fakultatea, Manuel Lardizabal Ibilbidea, 1'
          - '314 bulegoa 3. pisuan'
          - 'Donostia, Gipuzkoa 20018'
      office_hours:
        - 'Astelehena - Osteguna 10:00 - 17:00'
      email: juletxara@gmail.com
      connect_title: "Konektatu"
      social:
        - icon: 'brands/linkedin'
          url: 'https://www.linkedin.com/in/juletxara'
        - icon: 'brands/x'
          url: 'https://twitter.com/juletxara'
      show_form: true
      form_action: '/.netlify/functions/form'
    design:
      columns: '2'
---
