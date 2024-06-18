describe 'course website', type: :feature, js: true do
  before :all do
    visit('/sitemap.xml')
    sitemap_links = page.html.scan(%r{<loc>.+</loc>})
    @links = []
    sitemap_links.each do |link|
      # TODO: don't hardcode base url
      first_removed = link.sub('<loc>https://phrdang.github.io/berkeley-class-site', '')
      last_removed = first_removed.sub('</loc>', '')
      @links.push(last_removed)
    end
  end

  # TODO: run each page's axe check separately so it doesn't exit on first failure
  it 'is accessible' do
    @links.each do |link|
      visit(link)
      expect(page).to be_axe_clean.according_to :wcag2a, "path: #{link} not accessible"
    end
  end
end
