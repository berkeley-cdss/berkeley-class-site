---
title: Editing Content
permalink: /docs/editing-content/
published: true
layout: page
parent: Documentation
nav_order: 1
---

# Editing Content

## Markdown and YAML
Most of your edits will be to be to markdown and YAML. If you're unfamiliar with either of these, check out the following resources:
* [Markdown guide](https://www.markdownguide.org/){:target="_blank"}
* [YAML for geginners](https://www.redhat.com/en/blog/yaml-beginners){:target="_blank"}
* [Front matter](https://jekyllrb.com/docs/front-matter/)
* [Using YAML front matter](https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter)
* [YAML validator](https://www.yamllint.com/){:target="_blank"} or [with formatting](https://jsonformatter.org/yaml-validator){:target="_blank"}

## Jekyll

[Jekyll][jekyll] is the static site generator we use to build the website. We highly recommend reading through the documentation to get an idea of what you can achieve with Jekyll, such as variables, collections, and page layouts, if you wish to customize your website further. However, if you are okay with the boilerplate collections we provide in this template, it is not strictly necessary.

### Boilerplate Collections

As part of the Berkeley Class Site template, we provide various boilerplate Jekyll collections. You can edit or create Markdown files in the `_collection_name` folders (e.g. `_staffers` for the Staffers collection).

- **Staffers**: Represents each instructor and staff member, to be displayed in `staff.md`
- **Modules**: Represents each week in the course, to be displayed in `schedule.md`
- **Calendars**: See [Calendar (Static)]({% link calendar.md %})
- **Announcements**: Weekly announcements, to be displayed in `announcements.md`
- **Labs**: Lab assignments
- **HW**: HW assignments
- **Projects**: Project assignments

### Liquid Tags

[Liquid](https://shopify.github.io/liquid/) is a template language. Liquid tags look like `{% raw %}{% tag_name ... %}{% endraw %}` and you can read more about how they work with Jekyll [here](https://jekyllrb.com/docs/liquid/).

Some tags you may find useful:

- `{% raw %}{% link <path> %}{% endraw %}` to link to a particular page on the website ([docs](https://jekyllrb.com/docs/liquid/tags/#links))

Also see [Asset Tags]({% link docs/asset-tags.md %}) for custom tags we provide to link to various types of assets.

{% raw %}
If you're adding references to files, please use `{{ 'path/to/file' | relative_url }}` instead of `{{ site.baseurl }}/path/to/file`. In most cases using the baseurl is fine, but some classes have found this problematic. 
{% endraw %}

## Just the Docs

For most website content edits, we recommend looking at the different UI components and colors offered by the [Just the Docs][jtd] theme.

[jekyll]: https://jekyllrb.com
[jtd]: https://just-the-docs.github.io/just-the-docs/
