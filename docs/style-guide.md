---
title: Style Guide
permalink: /docs/style-guide/
published: true
layout: page
has_children: false
parent: Documentation
nav_order: 3
---

# Style Guide

The purpose of this page is to show the reasonable default for various stylings.

## Labels

Labels are used on many course semester schedules/home pages to draw attention to important calendar events.

**Lecture**{: .label .label-lecture }
**Lecture Participation**{: .label .label-lecture-participation }
**Vitamin**{: .label .label-vitamin }
**Reading**{: .label .label-reading }
**Guide**{: .label .label-reading }
**Course Notes**{: .label .label-reading }

**Section**{: .label .label-section }
**Lab**{: .label .label-lab }
**Discussion**{: .label .label-discussion }

**Project**{: .label .label-project }
**Homework**{: .label .label-homework }
**Homework Released**{: .label .label-homework-released }
**Homework Due**{: .label .label-homework }

**Exam**{: .label .label-exam }
**Exam Prep**{: .label .label-exam-prep }
**Quiz**{: .label .label-quiz }

Here are a few examples of how to use labels in your markdown:

```
**Section**{: .label .label-section }
**Discussion**{: .label .label-discussion }
**Lecture**{: .label .label-lecture }
```

`**Section**` controls the text of the label. `{: .label }` designates that it should be a label. `{: .label-section }` controls the color of the label as defined in `_sass/custom/custom.scss`. There is nothing technically preventing you from doing something like `**Section**{: .label .label-discussion }`. We recommend you take advantage of this if your course uses different wording for a basic element, for example above `Reading`, `Guide`, and `Course Notes` all use the same label: `{: .label .label-reading }`.

The styling of each label is defined in `_sass/custom/custom.scss`. If you would like to change any of the default colors, please place your updates in `_sass/custom/course_overrides.scss`. You don't need to delete the original definitions in  `_sass/custom/custom.scss`; the course overrides will take precedent.

## Buttons

We also provide buttons that you can place at the top of your course's page. These can also be found in `_sass/custom/custom.scss`. Again, if you want to change these, please place your updates in `_sass/custom/course_overrides.scss` which will take precedent over the original definitons.

The markdown for a button is like so:

```
[Gradescope](https://www.gradescope.com){: .btn .btn-gradescope }
```

[Gradescope](https://www.gradescope.com){: .btn .btn-gradescope }
[Pensieve](https://www.pensieve.co){: .btn .btn-pensieve }
[bCourses](https://bcourses.berkeley.edu/){: .btn .btn-bcourses }

[DataHub](https://datahub.berkeley.edu/){: .btn .btn-datahub }
[Zoom](https://zoom.us){: .btn .btn-zoom }
[Lectures Playlist](https://www.youtube.com/){: .btn .btn-lectures}
[EdStem](https://edstem.org/us/dashboard){: .btn .btn-ed }

[Textbook](https://inferentialthinking.com){: .btn .btn-textbook }
[Office Hours](https://calendar.google.com){: .btn .btn-officehours }
[Extensions](https://forms.gle/){: .btn .btn-extensions }

## Just the Docs UI Components

Just the Docs additionally has [UI components](https://just-the-docs.com/docs/ui-components/) you can use out of the box. Not all elements may be [accessible]({% link docs/a11y.md %}) -- be sure to double check that all [GitHub Actions]({% link docs/continuous-integration.md %}) pass after a commit!

## Note on Colors

You may find that colors that are accessible for the light color scheme may not be accessible for the dark color scheme and vice versa. In that case, we recommend defining a variable, once in `_sass/color-schemes/light.scss` to be accessible for the light color scheme and once again in `_sass/color-schemes/dark.scss` to be accessible for the dark color scheme. See `$hw-rel` for an example.
