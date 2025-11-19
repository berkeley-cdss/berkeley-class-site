---
title: Staff
permalink: /docs/staff/
published: true
layout: page
parent: Documentation
---

# Staff

Staff information is stored in the `_staffers` directory and rendered on the [Staff]({% link staff.md %}) page according to the layout file, `_layouts/staffer.html`. In `staffer.html`, to reference an attribute from a staff member's `md` file, we use the syntax `page.{attribute}`. For example, if we write `role: Instructor`, then `page.role` will be assigned to `Instructor`. Below is an example of the [front matter](https://jekyllrb.com/docs/step-by-step/03-front-matter/) of the `md` file for a staff member named Kevin Lin:

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

```scss
.staffer-badge.label-Pedagogy {
  background-color: #9C3848 !important;
  color: white !important;
}
```

to `course_overrides`.

All of the content after the front matter will be rendered in the bio section for that staffer.
Typically this will be text, but you are free to use other UI elements, such as buttons.

## Staffer Front Matter Schema

```yaml
name:
  type: string
  required: true
role:
  type: string enum
  required: true
  enum_values:
    - Instructor
    - Head Teaching Assistant
    - Teaching Assistant
    - Tutor
    - Reader
    - Academic Intern
email:
  type: string
  required: false
  note: Must be a valid email address to provide to mailto in hyperlink (see https://en.wikipedia.org/wiki/Mailto)
website:
  type: string
  required: false
  note: Must be a valid URL
photo:
  type: string
  required: false
  note: Must be relative path from assets/images/
pronouns:
  type: string
  required: false
section:
  type: string
  required: false
office_hours:
  type: string
  required: false
team:
  type: string
  required: false
access_email:
  type: boolean
  required: false
  note: Whether or not this staff member can access the course email
access_dsp:
  type: boolean
  required: false
  note: Whether or not this staff member can access the course email
```
