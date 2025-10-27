---
title: Documentation
permalink: /docs/
published: true
layout: page
has_children: true
---

# Berkeley Class Site

The documentation here is intended for both course staff and developers of the Berkeley Class Site template.

## Tech Stack

This website is built using [Jekyll][jekyll], a static site generator, and deployed using [GitHub Pages][gh_pages]. When you push to GitHub, the website is automatically compiled and updated. It uses the [Just the Docs][jtd] Jekyll theme with some boilerplate and styling overrides from [Just the Class](https://kevinl.info/just-the-class/) and our own Berkeley/course-specific branding.

## Getting Started

1. Follow the instructions in the [GitHub repository README](https://github.com/berkeley-cdss/berkeley-class-site/blob/main/README.md).
2. Delete the `docs/` directory from your fork or set `published: false` on the pages in the directory. (That directory contains documentation for how to use the template, the page you are reading right now.)
3. Configure your course's settings in the `_config.yml` file of your fork. If you have previously used the template, copy over any relevant files.
4. [Edit content]({% link docs/editing-content.md %}) in the website as you wish.

[jekyll]: https://jekyllrb.com
[gh_pages]: https://pages.github.com
[jtd]: https://just-the-docs.github.io/just-the-docs/
