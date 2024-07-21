---
# Leave the homepage title empty to use the site title
title:
date: 2023-01-22
type: landing

sections:
  - block: about.biography
    id: about
    content:
      title: <i class='fas fa-book'></i>&nbsp;Biography
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: julen-etxaniz
  - block: experience
    id: experience
    content:
      title: <i class='fas fa-briefcase'></i>&nbsp;Experience
      # Date format for experience
      #   Refer to https://wowchemy.com/docs/customization/#date-format
      date_format: Jan 2006
      # Experiences.
      #   Add/remove as many `experience` items below as you like.
      #   Required fields are `title`, `company`, and `date_start`.
      #   Leave `date_end` empty if it's your current employer.
      #   Begin multi-line descriptions with YAML's `|2-` multi-line prefix.
      items:
        - title: PhD Student in Language Analysis and Processing
          company: UPV/EHU
          company_url: 'https://ehu.eus/en'
          company_logo: upv_ehu
          location: Donostia
          date_start: '2023-01-31'
          date_end: ''
          description: ""
    design:
      columns: '2'
  - block: experience
    id: education
    content:
      title: <i class='fas fa-graduation-cap'></i>&nbsp;Education
      # Date format for experience
      #   Refer to https://wowchemy.com/docs/customization/#date-format
      date_format: Jan 2006
      # Experiences.
      #   Add/remove as many `experience` items below as you like.
      #   Required fields are `title`, `company`, and `date_start`.
      #   Leave `date_end` empty if it's your current employer.
      #   Begin multi-line descriptions with YAML's `|2-` multi-line prefix.
      items:
        - title: Degree in Computer Engineering
          company: UPV/EHU
          company_url: 'https://ehu.eus/en'
          company_logo: upv_ehu
          location: Donostia
          date_start: '2017-09-10'
          date_end: '2021-09-10'
          description: ""
        - title: Master in Language Analysis and Processing
          company: UPV/EHU
          company_url: 'https://ehu.eus/en'
          company_logo: upv_ehu
          location: Donostia
          date_start: '2021-10-25'
          date_end: '2021-10-25'
          description: ""
        - title: PhD in Language Analysis and Processing
          company: UPV/EHU
          company_url: 'https://ehu.eus/en'
          company_logo: upv_ehu
          location: Donostia
          date_start: '2023-01-31'
          date_end: ''
          description: ""
    design:
      columns: '2'
  - block: accomplishments
    id: certificates
    content:
      title: <i class='fas fa-award'></i>&nbsp;Certificates
      subtitle:
      # Date format: https://wowchemy.com/docs/customization/#date-format
      date_format: Jan 2006
      # Accomplishments.
      #   Add/remove as many `item` blocks below as you like.
      #   `title`, `organization`, and `date_start` are the required parameters.
      #   Leave other parameters empty if not required.
      #   Begin multi-line descriptions with YAML's `|2-` multi-line prefix.
      items:
        - organization: Platzi
          organization_url: 'https://platzi.com/'
          title: Curso de Machine Learning Aplicado con Python
          url: 'https://platzi.com/cursos/scikit/'
          certificate_url: 'https://platzi.com/@juletx/curso/1178-scikit/diploma/detalle/'
          date_start: '2020-10-31'
          date_end: ''
          description: ''
        - organization: Platzi
          organization_url: 'https://platzi.com/'
          title: Curso de Redes Neuronales en Keras y Scikit-Learn
          url: 'https://platzi.com/cursos/keras-neural-networks/'
          certificate_url: >-
            https://platzi.com/@juletx/curso/1866-keras-neural-networks/diploma/detalle/
          date_start: '2020-10-31'
          date_end: ''
          description: ''
        - organization: Platzi
          organization_url: 'https://platzi.com/'
          title: Curso Práctico de Regresión Lineal con Python
          url: 'https://platzi.com/cursos/regresion-python/'
          certificate_url: 'https://platzi.com/@juletx/curso/1766-regresion-python/diploma/detalle/'
          date_start: '2020-10-30'
          date_end: ''
          description: ''
        - organization: Universidad Complutense de Madrid
          organization_url: 'https://www.ucm.es/'
          title: Curso de Desarrollo de Apps Móviles
          url: 'https://learndigital.withgoogle.com/activate/course/apps'
          certificate_url: 'https://learndigital.withgoogle.com/activate/validate-certificate-code'
          date_start: '2020-01-23'
          date_end: ''
          description: ''
        - organization: Cambridge Assessment English
          organization_url: 'https://www.cambridgeenglish.org/'
          title: Certificate in Advanced English
          url: 'https://www.cambridgeenglish.org/exams-and-tests/advanced/'
          certificate_url: 'https://www.cambridgeenglish.org/cmp/verifiers/'
          date_start: '2017-02-01'
          date_end: ''
          description: ''
        - organization: Eusko Jaurlaritza
          organization_url: 'https://www.euskadi.eus/hasiera/'
          title: Euskararen Gaitasun Agiria
          url: 'https://eu.wikipedia.org/wiki/Euskararen_Gaitasun_Agiria'
          certificate_url: >-
            https://www.euskadi.eus/euskara-tituluen-eta-ziurtagirien-erregistro-bateratua/web01-a2etzeb/eu/
          date_start: '2016-06-24'
          date_end: ''
          description: ''
    design:
      columns: '2'
  - block: features
    id: skills
    content:
      title: <i class='fas fa-check'></i>&nbsp;Skills
      items:
        - icon: language
          icon_pack: fas
          name: '[Languages](#languages)'
          description: ''
        - icon: code
          icon_pack: fas
          name: '[Programming Languages](#programming-languages)'
          description: ''
        - icon: globe
          icon_pack: fas
          name: '[Web Development](#web-development)'
          description: ''
        - icon: project-diagram
          icon_pack: fas
          name: '[Software Engineering](#software-engineering)'
          description: ''
        - icon: robot
          icon_pack: fas
          name: '[Machine Learning](#machine-learning)'
          description: ''
        - icon: tools
          icon_pack: fas
          name: '[Tools](#tools)'
          description: ''
  - block: features
    id: languages
    content:
      title: <i class='fas fa-language'></i>&nbsp;Languages
      items:
      - icon: basque-country
        icon_pack: custom
        name: Euskara
        description: ''
      - icon: spain
        icon_pack: custom
        name: Español
        description: ''
      - icon: united-kingdom
        icon_pack: custom
        name: English
        description: ''
  - block: features
    id: programming-languages
    content:
      title: <i class='fas fa-code'></i>&nbsp;Programming Languages
      items:
      - icon: python
        icon_pack: fab
        name: Python
        description: ''
      - icon: r-project
        icon_pack: fab
        name: R
        description: ''
      - icon: java
        icon_pack: fab
        name: Java
        description: ''
      - icon: js
        icon_pack: fab
        name: JavaScript
        description: ''
      - icon: php
        icon_pack: fab
        name: PHP
        description: ''
      - icon: database
        icon_pack: fas
        name: SQL
        description: ''
  - block: features
    id: web-development
    content:
      title: <i class='fas fa-globe'></i>&nbsp;Web Development
      items:
      - icon: html5
        icon_pack: fab
        name: HTML5
        description: ''
      - icon: css3-alt
        icon_pack: fab
        name: CSS3
        description: ''
      - icon: bootstrap
        icon_pack: fab
        name: Bootstrap
        description: ''
      - icon: hugo
        icon_pack: custom
        name: Hugo
        description: ''
      - icon: django
        icon_pack: custom
        name: Django
        description: ''
      - icon: dotnet
        icon_pack: custom
        name: .NET
        description: ''
  - block: features
    id: software-engineering
    content:
      title: <i class='fas fa-project-diagram'></i>&nbsp;Software Engineering
      items:
        - icon: file-alt
          icon_pack: fas
          name: Requirements
          description: ''
        - icon: edit
          icon_pack: fas
          name: Design
          description: ''
        - icon: laptop-code
          icon_pack: fas
          name: Develop
          description: ''
        - icon: bug
          icon_pack: fas
          name: Test
          description: ''
        - icon: clipboard-list
          icon_pack: fas
          name: Methodologies
          description: ''
        - icon: code-branch
          icon_pack: fas
          name: Source Control
          description: ''
  - block: features
    id: machine-learning
    content:
      title: <i class='fas fa-robot'></i>&nbsp;Machine Learning
      items:
      - icon: chart-bar
        icon_pack: fas
        name: Classification
        description: ''
      - icon: chart-line
        icon_pack: fas
        name: Regression
        description: ''
      - icon: sitemap
        icon_pack: fas
        name: Neural Networks
        description: ''
      - icon: jupyter
        icon_pack: custom
        name: Jupyter Notebook
        description: ''
      - icon: scikit-learn
        icon_pack: custom
        name: Scikit-Learn
        description: ''
      - icon: tensorflow
        icon_pack: custom
        name: Tensorflow
        description: ''
  - block: features
    id: tools
    content:
      title: <i class='fas fa-tools'></i>&nbsp;Tools
      items:
      - icon: git-alt
        icon_pack: fab
        name: Git
        description: ''
      - icon: github
        icon_pack: fab
        name: GitHub
        description: ''
      - icon: xamarin
        icon_pack: custom
        name: Xamarin
        description: ''
      - icon: eclipse
        icon_pack: custom
        name: Eclipse
        description: ''
      - icon: visual-studio-code
        icon_pack: custom
        name: Visual Studio Code
        description: ''
      - icon: visual-studio
        icon_pack: custom
        name: Visual Studio
        description: ''
  - block: collection
    id: publications
    content:
      title: "[<i class='fas fa-book'></i>&nbsp;Publications](publication)"
      text: ""
      filters:
        folders:
          - publication
        tag: ''
        category: ''
        publication_type: ''
        author: ''
        publication_type: ""
        exclude_featured: false
        exclude_future: false
        exclude_past: false
      # Choose how many pages you would like to offset by
      offset: 0
      # Page order: descending (desc) or ascending (asc) date.
      order: desc
    design:
      columns: '2'
      view: card
  - block: portfolio
    id: projects
    content:
      title: Projects
      filters:
        folders:
          - project
      # Default filter index (e.g. 0 corresponds to the first `filter_button` instance below).
      default_button_index: 0
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
      view: masonry
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
  - block: tag_cloud
    id: tags
    content:
      title: "[<i class='fas fa-tags'></i>&nbsp;Tags](tags)"
      # Choose the taxonomy from `config.toml` to display (e.g. tags, categories)
      taxonomy: tags
      # Choose how many tags you would like to display (0 = all tags)
      count: 20
    design:
      columns: '2'
      # Minimum and maximum font sizes (1.0 = 100%).
      font_size_min: 0.7
      font_size_max: 2.0
  - block: contact
    id: contact
    content:
      title: <i class='fas fa-envelope'></i>&nbsp;Contact
      subtitle:
      text: 
      # Contact (add or remove contact options as necessary)
      email: juletxara@gmail.com
      # phone: 888 888 88 88
      address:
        street: 'Faculty of Informatics, Manuel Lardizabal Ibilbidea, 1'
        city: Donostia
        region: Gipuzkoa
        postcode: '20018'
        country: Spain
        country_code: ES
      # coordinates:
      #   latitude: '43.307205'
      #   longitude: '-2.010843'
      directions: Office 314 on floor 3
      office_hours:
        - 'Monday - Thursday 10:00 - 17:00'
      # appointment_url: 'https://calendly.com'
      contact_links:
        - icon: linkedin
          icon_pack: fab
          name: linkedin.com/in/juletxara
          link: 'https://www.linkedin.com/in/juletxara'
        - icon: x-twitter
          icon_pack: fab
          name: twitter.com/juletxara
          link: 'https://twitter.com/juletxara'
        - icon: instagram
          icon_pack: fab
          name: instagram.com/juletxara
          link: 'https://www.instagram.com/juletxara'
      # Automatically link email and phone or display as text?
      autolink: true
      # Email form provider
      form:
        provider: netlify
        formspree:
          id:
        netlify:
          # Enable CAPTCHA challenge to reduce spam?
          captcha: true
    design:
      columns: '2'
---
