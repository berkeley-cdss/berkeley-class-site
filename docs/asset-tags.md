---
title: Asset Tags
permalink: /docs/asset-tags/
published: true
layout: page
parent: Documentation
---

# Asset Tags

We include a script that defines a set of custom [Liquid](https://shopify.github.io/liquid/) tags to make it easier to include links to various types of assets (slides, code, notebooks, recordings, etc.) in lecture notes and other pages. See `plugins/asset_tags.rb` for the implementation of these tags.

## Lecture

`{% lec n %}` where n is the lecture number defined in the frontmatter.

The lecture tag is the most built out tag at this time. You can use this tag to reference lectures automatically linking to the correct lecture page. The tag includes the lecture label. The lecture tag enables you to set the release date and time for when links to lecture pages should appear. For example if you set the front matter of the lecture `.md` file to be:
```yaml
date: 2025-9-28
time: 15:00
```
Then this link won't appear on the homepage until September 28, 2025 at 3pm. By default, if we don't define the release time, then lectures will be released at 10am. This is defined in `_config.yml` under `defaults` for lectures. We assume that all lectures have a date defined in the front matter.

Do not place any sensitive information in the lecture pages that you do not want students to see even if it is before the lecture relase date/time. Savy viewers may be able to access the content before the release date/time by looking at the raw markdown files in the GitHub repository (if public) or by figuring out the lecture's URL.


## Other Assets
Other basic asset tags are provided. See `plugins/asset_tags.rb` for what is available. If you make new asset tags, please open a PR on the template repository to include them for everyone!