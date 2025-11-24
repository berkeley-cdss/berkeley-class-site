---
layout: page
title: Schedule
description: Course topics, lectures, and assignments schedule.

nav_order: 1
published: true
---

# Schedule

DATA courses typically put this page as thier homepage. 

{% for module in site.modules %}
  {{ module }}
{% endfor %}
