# frozen_string_literal: true

# Run accessibility specs for all pages in the webiste.
# This runs the axe accessibility checker on each page in a headless browser.

# spec_helper ensures the webiste is built and can be served locally
require 'spec_helper'

def site_url
  @site_url ||= YAML.load_file(RSPEC_CONFIG_FILE)['url'] + YAML.load_file(RSPEC_CONFIG_FILE)['baseurl']
end

def load_site_urls
  puts "Running accessibility tests, expected deploy URL: #{site_url}"
  # TODO: Handle case where build is not in _site
  sitemap_text = File.read('_site/sitemap.xml')
  sitemap_links = sitemap_text.scan(%r{<loc>.+</loc>})
  sitemap_links.filter_map do |link|
    link = link.gsub("<loc>#{site_url}", '').gsub('</loc>', '')
    # Skip non-html pages
    # (FUTURE?) Are there other pages that should be audited for accessibility?
    # (e.g. PDFs, documents. They'd need a different checker.)
    next unless link.end_with?('.html') || link.end_with?('/')

    link
  end.sort
end

ALL_PAGES = load_site_urls
puts "Running tests on #{ALL_PAGES.count} pages."
puts "  - #{ALL_PAGES.join("\n  - ")}\n#{'=' * 72}\n\n"

# Axe-core test standards groups
# See https://github.com/dequelabs/axe-core/blob/develop/doc/API.md#axe-core-tags
required_a11y_standards = %i[wcag2a wcag2aa]
# These are currently skipped until the basic tests are passing.
complete_a11y_standards = %i[wcag21a wcag21 wcag22aa best-practice secion508]

# axe-core rules that are not required to be accessible / do not apply
# See: https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md
skipped_rules = []
# These are elements that are not required to be accessible
excluded_elements = [
  '[data-a11y-external-errors="true"]'
]

ALL_PAGES.each do |path|
  describe "'#{path}' is accessible", :js, type: :feature do
    before do
      visit(path)
    end

    # These tests should always be enabled.
    it 'according to WCAG 2.0 AA' do
      expect(page).to be_axe_clean
        .according_to(*required_a11y_standards, "#{path} does NOT meet WCAG 2.0 AA")
        .skipping(*skipped_rules)
        .excluding(*excluded_elements)
    end

    it 'according to WCAG 2.2 AA',
       skip: 'Berkeley: (June 2024) these tests are skipped until the basic tests are passing' do
      expect(page).to be_axe_clean
        .according_to(*complete_a11y_standards)
        .skipping(*skipped_rules)
        .excluding(*excluded_elements)
    end
  end
end
