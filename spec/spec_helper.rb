# frozen_string_literal: true

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'jekyll'
require 'rspec'
require 'rack'
require 'yaml'
require 'webrick'

require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara-screenshot/rspec'
require 'capybara/session'

require 'rack/test'
require 'axe-rspec'
require 'axe-capybara'

# ------------
# Tools to build / compile the Jekyll site and extract the sitemap
def site_config
  # TODO(template): We should standardize the build for specs
  # Consider simplifying baseurl
  # Consider forcing the desination folder
  # Override the local URL too? Would it break the sitemap?
  # Note: Config keys must be strings and thus use => style hashes.
  @config ||= ::Jekyll.configuration({
    'sass' => { 'quiet_deps' => true }
  })
end

@site = ::Jekyll::Site.new(site_config)
@site.process
puts "Site build complete"

def load_site_urls
  puts "Running accessibility tests"
  sitemap_text = File.read('_site/sitemap.xml')
  sitemap_links = sitemap_text.scan(%r{<loc>.+</loc>})
  sitemap_links.filter_map do |link|
    link = link.gsub("<loc>#{site_config['url']}", '').gsub('</loc>', '')
    # Skip non-html pages
    # (FUTURE?) Are there other pages that should be audited for accessibility?
    # (e.g. PDFs, documents. They'd need a different checker.)
    next unless link.end_with?('.html') || link.end_with?('/')

    link
  end.sort
end
# --------

# This is the root of the repository, e.g. the bjc-r directory
# Update this is you move this file.
REPO_ROOT = File.expand_path('../', __dir__)

# https://nts.strzibny.name/how-to-test-static-sites-with-rspec-capybara-and-webkit/
class StaticSite
  attr_reader :root, :server

  # TODO: Rack::File will be deprecated soon. Find a better solution.
  def initialize(root)
    @root = root
    @server = Rack::Files.new(root)
  end

  def call(env)
    # Remove the /baseurl prefix, which is present in all URLs, but not in the file system.
    path = env['PATH_INFO'].gsub(site_config['baseurl'], '/')
    path = "_site#{path}"

    # Use index.html for / paths
    if path.end_with?('/') && exists?('index.html')
      env['PATH_INFO'] = 'index.html'
    elsif path.end_with?('/') && exists?(path + 'index.html')
      env['PATH_INFO'] = path + 'index.html'
    elsif !exists?(path) && exists?(path + '.html')
      env['PATH_INFO'] = "#{path}.html"
    else
      env['PATH_INFO'] = path
    end

    server.call(env)
  end

  def exists?(path)
    File.exist?(File.join(root, path))
  end
end
# ---------

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  # macbook air ~13" screen size, with an absurd height for full size screenshots.
  options.add_argument('--window-size=1280,4000')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

# Change default_driver to :selenium_chrome if you want to actually see the tests running in a browser locally.
# Should be :chrome_headless in CI though.
Capybara.default_driver = :chrome_headless
Capybara.javascript_driver = :chrome_headless

Capybara::Screenshot.register_driver(:chrome_headless) do |driver, path|
  driver.save_screenshot(path)
end

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "tmp/capybara/screenshot_#{example.description.gsub('/', '-').gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
end

Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.append_timestamp = false
Capybara::Screenshot.prune_strategy = :keep_last_run

# Setup for Capybara to serve static files served by Rack
Capybara.server = :webrick
Capybara.app = Rack::Builder.new do
  use Rack::Lint
  run StaticSite.new(REPO_ROOT)
  # map '/' do
  # end
end.to_app

# ---------
RSpec.configure do |config|
  # Allow rspec to use `--only-failures` and `--next-failure` flags
  # Ensure that `tmp` is in your `.gitignore` file
  config.example_status_persistence_file_path = 'tmp/rspec-failures.txt'

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Capybara::DSL
end
