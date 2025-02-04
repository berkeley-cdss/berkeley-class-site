# frozen_string_literal: true

ruby file: '.tool-versions'

source 'https://rubygems.org'

# Gems at the top are used to build the site.
gem 'jekyll', '~> 4'

gem 'faraday-retry', '~> 2.2'
gem 'kramdown-parser-gfm'

group :jekyll_plugins do
  gem 'jekyll-github-metadata', '~> 2.16'
  gem 'jekyll-jupyter-notebook'
  gem 'jekyll-redirect-from'
  gem 'jekyll-sitemap'
  gem 'jemoji'
  gem 'just-the-docs'
end

# These tools are use for running tests.
group :development, :test do
  gem 'axe-core-capybara'
  gem 'axe-core-rspec'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'rack'
  gem 'rackup'
  gem 'rspec'
  gem 'selenium-webdriver'
  gem 'webrick'
end

group :development, :rubocop do
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rspec', require: false
end
