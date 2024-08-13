# frozen_string_literal: true

source 'https://rubygems.org'

gem 'jekyll', '~> 4'

gem 'faraday-retry', '~> 2.2'
gem 'kramdown-parser-gfm'
gem 'webrick'

group :jekyll_plugins do
  gem 'jekyll-github-metadata', '~> 2.16'
  gem 'jekyll-sitemap'
  gem 'just-the-docs'
end

group :development, :test do
  gem 'axe-core-capybara'
  gem 'axe-core-rspec'
  gem 'capybara'
  gem 'rack-jekyll', '>= 0.5.0'
  gem 'rackup'
  gem 'rspec'
  gem 'selenium-webdriver'
end

group :development, :rubocop do
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rspec', require: false
end
