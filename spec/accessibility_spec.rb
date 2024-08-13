# frozen_string_literal: true

# Run accessibility specs for all pages in the webiste.
# This runs the axe accessibility checker on each page in a headless browser.

# spec_helper ensures the webiste is built and can be served locally
require 'spec_helper'

ALL_PAGES = load_site_urls
puts "Running tests on #{ALL_PAGES.count} pages."
puts "  - #{ALL_PAGES.join("\n  - ")}\n#{'=' * 72}\n\n"

# Axe-core test standards groups
# See https://github.com/dequelabs/axe-core/blob/develop/doc/API.md#axe-core-tags
required_a11y_standards = %i[wcag2a wcag2aa]
complete_a11y_standards = %i[wcag21a wcag21 wcag22aa best-practice secion508]

# axe-core rules that are not required to be accessible / do not apply
# See: https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md
skipped_rules = []
# These are elements that are not required to be accessible
excluded_elements = [
  '[data-a11y-external-errors="true"]'
]

ALL_PAGES.each do |path|
  describe "page is accessible", :js, type: :feature do
    before do
      visit(path)
    end

    it "#{path} meets WCAG 2.0" do
      expect(page).to be_axe_clean
        .according_to(*required_a11y_standards, "#{path} does NOT meet WCAG 2.0 AA")
        .skipping(*skipped_rules)
        .excluding(*excluded_elements)
    end

    it "#{path} meets WCAG 2.2" do
      expect(page).to be_axe_clean
        .according_to(*complete_a11y_standards)
        .skipping(*skipped_rules)
        .excluding(*excluded_elements)
    end
  end
end
