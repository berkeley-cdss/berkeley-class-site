---
title: Lectures
permalink: /docs/collections/lectures/
published: true
layout: page
parent: Collections
nav_order: 3
---

# Lectures

## Lectures Front Matter Schema

Additional fields may be configured in `layout/lecture.html` as needed. The only required field is `title`. 

See [here](https://github.com/berkeley-cdss/berkeley-class-site/blob/main/_lectures/intro.md){:target="_blank"} for an example of a lecture file. Anything outside of the front matter will be included at the bottom of the lecture's page.

```yaml
title:
  type: string
  required: true
presented_by:
  type: string
  required: false
date:
  type: string
  format: YYYY-MM-DD | YYYY-M-D | YYYY-M-DD | YYYY-MM-D
  required: false
  note: See {% link docs/asset-tags.md %} for release date/time functionality
time:
  type: string
  format: HH:MM (24-hour clock)
  required: false
  note: See {% link docs/asset-tags.md %} for release date/time functionality
recording:
  type: string
  required: false
  note: Must be a valid URL
askademia:
  type: string
  required: false
  note: Must be a valid URL. Treated the same as "recording"
slido:
    type: string
    required: false
    note: Must be a valid URL
files:
  slides:
    type: string
    required: false
    note: Must be a valid URL or relative path
  pdf_slides:
    type: string
    required: false
    note: Must be a valid URL or relative path
  notes:
    type: string
    required: false
    note: Must be a valid URL
  reading:
    type: string
    required: false
    note: Must be a valid URL (likely to your textbook or other reading materials)
  code:
    type: string
    required: false
    note: Must be a valid URL (e.g. file on GitHub) or relative path
  code_html:
    type: string
    required: false
    note: Must be a valid URL or relative path
  jupyter_notebook:
      type: string
    required: false
    note: Must be a valid URL (e.g. nbgitpuller link) or relative path
  additional_files:
    name:
      type: string
      required: false
      note: Descriptive name of the additional file to be displayed
    link:
      type: string
      required: false
      note: Must be a valid URL or relative path
    target:
      type: string
      required: false
      note: either set to "_blank" (open in new tab) or don't include/leave empty
```