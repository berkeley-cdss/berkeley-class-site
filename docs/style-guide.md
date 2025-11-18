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

Labels are used on many course semester homepages to draw attention to important calendar events. 

**Lecture**{: .label .label-lecture }
**Lecture Participation**{: .label .label-lecture-participation }
**Vitamin**{: .label .label-vitamin }
**Reading**{: .label .label-reading }
**Guide**{: .label .label-reading }
**Course Notes**{: .label .label-reading }

**Section**{: .label .label-section }
**Lab**{: .label .label-lab }
**Discussion**{: .label .label-discussion }
**Tutoring**{: .label .label-tutoring }
**Exam Prep**{: .label .label-exam-prep }

**Homework**{: .label .label-homework }
**Homework Released**{: .label .label-homework-released }
**Homework Due**{: .label .label-homework-due }

**Project**{: .label .label-project }
**Exam**{: .label .label-exam }
**Quiz**{: .label .label-quiz }

Here are a few examples of how to use labels in your markdown:

```
**Section**{: .label .label-section }
**Discussion**{: .label .label-discussion }
**Lecture**{: .label .label-lecture }
```

`**Section**` controls the text of the label. `{: .label }` designates that it should be a label. `{: .label-section }` controls the color of the label as defined in `_sass/custom/custom.scss`. There is nothing technically preventing you from doing something like `**Section**{: .label .label-discussion }`. We recommend you take advantage of this if your course uses different wording for a basic element, for example above `Reading` `Guide` and `Course Notes` all use the same label: `{: .label .label-reading }`.


You can find labels defined in `_sass/custom/custom.scss`. If you would like to change any of the default colors, please place your updates in `_sass/custom/course_overrides.scss`. You don't need to delete the original definitions in  `_sass/custom/custom.scss`; the course overrides will take precedent.



## Buttons
We also have buttons that you can place at the top of your course's page. These can also be found in `_sass/custom/custom.scss`.

```
[Gradescope](https://www.gradescope.com){: .btn .btn-gradescope }

[EdStem](https://edstem.org/us/dashboard){: .btn .btn-ed }
[Pensieve](https://www.pensieve.co){: .btn .btn-bcourses }
[Zoom](https://zoom.us){: .btn .btn-zoom }

[Office Hours](https://calendar.google.com){: .btn .btn-officehours }
[Extensions](https://forms.gle/){: .btn .btn-extensions }
```
[Gradescope](https://www.gradescope.com){: .btn .btn-gradescope }

[EdStem](https://edstem.org/us/dashboard){: .btn .btn-ed }
[Pensieve](https://www.pensieve.co){: .btn .btn-bcourses }
[Zoom](https://zoom.us){: .btn .btn-zoom }

[Office Hours](https://calendar.google.com){: .btn .btn-officehours }
[Extensions](https://forms.gle/){: .btn .btn-extensions }
