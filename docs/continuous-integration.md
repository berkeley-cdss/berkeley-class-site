---
title: Continuous Integration
permalink: /docs/continuous-integration/
published: true
layout: page
parent: Documentation
nav_order: 4
---

# Continuous Integration

We use [GitHub Actions](https://docs.github.com/en/actions) to create and execute [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) workflows. You can find workflow definitions in the `.github/workflows/` directory.

- `jekyll.yml` is for deploying the website using [GitHub Pages](https://docs.github.com/en/pages)
- `linters.yml` contains the various code linters, most of which are powered by [reviewdog](https://github.com/reviewdog/reviewdog)
    - We use [pylint](https://pylint.readthedocs.io/en/stable/) and [black](https://black.readthedocs.io/en/stable/) for Python linting
    - We use [Rubocop](https://rubocop.org/) for Ruby linting
    - We use [markdownlint](https://github.com/DavidAnson/markdownlint) for Markdown linting
- `rspec.yml` runs [web accessibility tests]({% link docs/a11y.md %})

{: .note }
Run `bundle exec rubocop` to run Rubocop locally before you push. To autocorrect certain errors, run `bundle exec rubocop --autocorrect`.
