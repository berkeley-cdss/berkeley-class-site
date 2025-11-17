---
layout: page
title: Staff
description: A listing of all the course staff members.
nav_order: 4
---

# Staff

Staff information is stored in the `_staffers` directory and rendered according to the layout file, `_layouts/staffer.html`. In `staffer.html`, to reference an attribute from a staff member's md file, we use the syntax `page.{attribute}`. For example, if we write `role: Instructor`, then `page.role` will be assigned to `Instructor`. Below is an example md file for a staff member named Kevin Lin:

```yaml
name: Kevin Lin
role: Instructor
email: me@example.com
website: https://kevinl.info
photo: kevin.jpg
pronouns: he/him
section: Soda 380 Tue 3-4 PM
office_hours: Warren Hall Tue 2-3 PM
team: Pedagogy # Go to course_overrides to add colors for different team badges
access_email: true
access_dsp: true
```

To add a Pedagogy badge and change its color, we can add 
```css
.staffer-badge.label-Pedagogy {
    background-color: #9C3848 !important;
    color: white !important;
  }
```
to `course_overrides`.


Kevin's file is then generated below:

## Instructors

{% assign instructors = site.staffers | where: 'role', 'Instructor' %}
{% for staffer in instructors %}
{{ staffer }}
{% endfor %}

{% assign head_teaching_assistants = site.staffers | where: 'role', 'Head Teaching Assistant' %}
{% assign num_head_teaching_assistants = head_teaching_assistants | size %}
{% if num_head_teaching_assistants != 0 %}
## Head Teaching Assistants

{% for staffer in head_teaching_assistants %}
{{ staffer }}
{% endfor %}
{% endif %}

{% assign teaching_assistants = site.staffers | where: 'role', 'Teaching Assistant' %}
{% assign num_teaching_assistants = teaching_assistants | size %}
{% if num_teaching_assistants != 0 %}
## Teaching Assistants

{% for staffer in teaching_assistants %}
{{ staffer }}
{% endfor %}
{% endif %}

{% assign tutors = site.staffers | where: 'role', 'Tutor' %}
{% assign num_tutors = tutors | size %}
{% if num_tutors != 0 %}
## Tutors

{% for staffer in tutors %}
{{ staffer }}
{% endfor %}
{% endif %}

{% assign academic_interns = site.staffers | where: 'role', 'Academic Intern' %}
{% assign num_academic_interns = academic_interns | size %}
{% if num_academic_interns != 0 %}
## Academic Interns

{% for staffer in academic_interns %}
{{ staffer }}
{% endfor %}
{% endif %}
