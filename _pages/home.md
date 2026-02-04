---
layout: splash
permalink: /
header:
  overlay_color: "#667eea"
  overlay_filter: "0.5"
  overlay_image: /assets/images/header-bg.jpg
  actions:
    - label: "View My Projects"
      url: "/projects/"
    - label: "Read My Blog"
      url: "/blog/"
excerpt: "Director of Embedded and System Design Center at VinFast | 15+ Years Architecting Vehicle Compute Platforms, Intelligent Cockpit Systems & Safety-Critical Embedded Software"

intro: 
  - excerpt: 'Proven expertise in AUTOSAR architecture, functional safety (ISO 26262, ISO 21434), and managing large-scale technical organizations delivering mission-critical automotive solutions.'

feature_row:
  - image_path: /assets/images/ev-charging.jpg
    alt: "Electric Vehicle Systems"
    title: "Electric Vehicle Platforms"
    excerpt: "Leading development of intelligent cockpit systems, battery management, and EV charging infrastructure with ISO 15118 V2G protocols."
    url: "/projects/#electric-vehicle-charging-infrastructure"
    btn_label: "Learn More"
    btn_class: "btn--primary"
  - image_path: /assets/images/embedded-systems.jpg
    alt: "Embedded Systems"
    title: "Embedded Systems Architecture"
    excerpt: "15+ years architecting safety-critical software for automotive, military communications, and IoT platforms using AUTOSAR and RTOS."
    url: "/projects/#professional-projects"
    btn_label: "Explore Projects"
    btn_class: "btn--primary"
  - image_path: /assets/images/leadership.jpg
    title: "Technical Leadership"
    excerpt: "Managing 50+ engineers across firmware, system architecture, and application development teams with ASPICE governance."
    url: "/about/"
    btn_label: "About Me"
    btn_class: "btn--primary"

feature_row2:
  - image_path: /assets/images/blog-tech.jpg
    alt: "Technical Blog"
    title: "Technical Insights & Blog"
    excerpt: 'Sharing expertise on embedded systems, EV technology, AUTOSAR, functional safety, and engineering leadership. Latest post: **Building the Future: My Journey in EV Technology**'
    url: "/blog/"
    btn_label: "Read Blog"
    btn_class: "btn--primary"

feature_row3:
  - image_path: /assets/images/certifications.jpg
    alt: "Professional Certifications"
    title: "Certifications & Expertise"
    excerpt: "**ISO 26262 Functional Safety** | **ASPICE Certified Assessor** | **AUTOSAR Architecture** | **ISO 21434 Cybersecurity**"
    url: "/resume/#certifications--training"
    btn_label: "View Resume"
    btn_class: "btn--primary"

feature_row4:
  - image_path: /assets/images/contact.jpg
    alt: "Get in Touch"
    title: "Let's Connect"
    excerpt: "Interested in discussing embedded systems, EV technology, or collaboration opportunities? I'm always open to meaningful conversations."
    url: "mailto:hoa.luu@vinfast.com"
    btn_label: "Contact Me"
    btn_class: "btn--primary"
---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="center" %}

## Recent Blog Posts

<div class="entries-list">
{% for post in site.posts limit:3 %}
  {% include archive-single.html %}
{% endfor %}
</div>

<div style="text-align: center; margin-top: 30px;">
  <a href="/blog/" class="btn btn--primary btn--large">View All Posts</a>
</div>
