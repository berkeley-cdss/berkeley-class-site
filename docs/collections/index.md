---
layout: page
title: Collections
parent: Documentation
nav_order: 8 
---

# Collections 

Collections are special directories in Jekyll that allow you to group related content together. In the Berkeley Class Site template, we use collections to manage various types of content, such as staff members, assignments, and announcements. Each collection has its own directory that begins with `_` (e.g., `_staffers`, `_assignments`, `_announcements`) and each item within a collection is represented by a Markdown file with front matter. 

Collections are defined in `_config.yml`. Here you can also set the `permalink` structure. Under `defaults` you can specify the default layout and subpath. For example, if you want to use a particular directory for staff pictures, you would set `subpath: /assets/images/staff-photos/`. [Example here](https://github.com/DS-100/fa25/blob/main/_config.yml#L62).
