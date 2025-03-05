# Berkeley Class Site

[![Pages Deployment](https://github.com/berkeley-cdss/berkeley-class-site/actions/workflows/jekyll.yml/badge.svg)](https://github.com/berkeley-cdss/berkeley-class-site/actions/workflows/jekyll.yml) •
[![a11y specs](https://github.com/berkeley-cdss/berkeley-class-site/actions/workflows/rspec.yml/badge.svg)](https://github.com/berkeley-cdss/berkeley-class-site/actions/workflows/rspec.yml)

A template for UC Berkeley class websites (with a focus on EECS/CS/DS courses).

## Installation

### Install Ruby and Bundler
**The berkeley-class-site template requires Ruby 3.3.7 or higher and bundler >= 2.6**
Install Ruby before continuing. You can check your Ruby version by running:

```bash
ruby --version
bundle --version
```

Prerequisites:

- You have everything that [Jekyll requires](https://jekyllrb.com/docs/installation/)
- You have installed [Bundler](https://bundler.io/): Run `gem install jekyll bundler`

1. [Fork](https://github.com/berkeley-eecs/berkeley-class-site/fork) the repository.
2. Clone your fork (replace `YOUR_GITHUB_USERNAME` and `YOUR_REPO` accordingly).
```
git clone git@github.com:YOUR_GITHUB_USERNAME/YOUR_REPO.git
```
3. Install dependencies:

```
cd YOUR_REPO
bundle install
```

## Usage

To run the site locally, run:

```
bundle exec jekyll serve
```

Note that if you alter `_config.yml`, you will need to rerun the above command to see the changes reflected.

Search throughout the repository for TODO items called `TODO(setup)` and complete them to customize the site for your course.

## Deployment

The easiest way to deploy your site is with [GitHub Pages](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll).

## Contributing

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for instructions on how to develop this site as part of course staff or if you're interested in contributing to this template repository.

## License

[MIT](LICENSE)
