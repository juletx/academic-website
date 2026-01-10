---
# Leave the homepage title empty to use the site title
title:
date: 2023-01-22
type: landing

sections:
  # Developer Hero - Gradient background with name, role, social, and CTAs
  - block: dev-hero
    id: biography
    content:
      username: julen-etxaniz-en
      greeting: ""
      show_status: true
      show_scroll_indicator: false
      typewriter:
        enable: true
        prefix: "I research on"
        strings:
          - "NLP"
          - "LLMs"
          - "Evaluation"
          - "Multilinguality"
          - "Low-resource languages"
        type_speed: 70
        delete_speed: 40
        pause_time: 2500
      cta_buttons:
        - text: Publications
          url: "#publications"
          icon: book-open
        - text: Projects
          url: "#projects"
          icon: arrow-down
    design:
      style: centered
      avatar_shape: circle
      animations: true
  - block: resume-experience
    id: experience
    content:
      username: julen-etxaniz-en
    design:
      # Hugo date format
      date_format: 'January 2006'
      # Education or Experience section first?
      is_education_first: false
  - block: resume-awards
    id: awards
    content:
      title: Awards
      username: julen-etxaniz-en
  - block: tech-stack
    id: skills
    content:
      title: "Skills"
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
      title: Featured Publications
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
      title: Recent Publications
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
      title: Projects
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
      - name: All
        tag: '*'
      - name: Programming
        tag: Programming
      - name: Web Development
        tag: Web Development
      - name: Software Engineering
        tag: Software Engineering
      - name: Machine Learning
        tag: Machine Learning
      - name: Deep Learning
        tag: Deep Learning
      - name: Natural Language Processing
        tag: Natural Language Processing
    design:
      # Choose how many columns the section has. Valid values: '1' or '2'.
      columns: '1'
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
  - block: knowledge-tags
    id: tags
    content:
      title: "Tags"
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
      title: Contact
      visit_title: "Visit Us"
      address:
        lines:
          - 'Faculty of Informatics, Manuel Lardizabal Ibilbidea, 1'
          - 'Office 314 on floor 3'
          - 'Donostia, Gipuzkoa 20018'
      office_hours:
        - 'Monday - Friday 10:00 - 17:00'
      email: juletxara@gmail.com
      connect_title: "Connect"
      social:
        - icon: 'brands/linkedin'
          url: 'https://www.linkedin.com/in/juletxara'
        - icon: 'brands/x'
          url: 'https://twitter.com/juletxara'
      show_form: true
      form_action: '/.netlify/functions/form'
      map_url: 'https://share.google/zmEvCk6CRWF6mz3tR'
      map_embed: '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4033.6816906915433!2d-2.0129922875113557!3d43.30706597462742!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd51b16a3b4f813f%3A0xfd77ae37aee1c102!2sHiTZ%20zentroa!5e1!3m2!1ses!2ses!4v1767793336033!5m2!1ses!2ses" width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>'
    design:
      columns: '2'
---
