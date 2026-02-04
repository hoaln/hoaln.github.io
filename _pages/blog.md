---
layout: archive
title: "Blog Posts"
permalink: /blog/
author_profile: true
---

{% assign posts = site.posts %}
<div class="entries-list">
  {% for post in posts %}
    {% include archive-single.html %}
  {% endfor %}
</div>
