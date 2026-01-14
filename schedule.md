---
layout: page
title: Schedule
description: Course topics, lectures, and assignments schedule.

nav_order: 1
published: true
---

# Schedule

DATA courses typically put this page as thier homepage. 

To set this up for your course, edit the YML files in `_data/`. Start with `syllabus.yml` to set up basic information about the calendar (semester start and end dates, holidays, when lectures are held, etc.). Then edit the other YML files to add the course components to the schedule. 

We assume that lectures, labs, discussions, readings, and homeworks happen with a regular weekly cadence whereas projects are more sparse. If you want to set dates specifically for course components, examine how projects are set up in `_data/projects.yml` and `_inclides/schedule.html`. Note that projects are the only course component that does not have `project_days` (project equivalent of `class_days`) set in `_data/syllabus.yml`.


<div>
{%- include schedule.html -%}
</div>

