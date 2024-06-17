describe "course website", type: :feature, js: true do
  LINKS = []
  def setup
    visit('/sitemap.xml')
    sitemap_links = page.html.scan(/<loc>.+<\/loc>/)
    # @links = []
    sitemap_links.each do |link|
      # TODO don't hardcode base url
      first_removed = link.sub('<loc>https://phrdang.github.io/berkeley-class-site', '')
      last_removed = first_removed.sub('</loc>', '')
      LINKS.push(last_removed)
    end
    return LINKS
  end

  def format_links(links)
    if links.empty?
      "\t No pages"
    else
      "\t -" + links.join("\n\t- ")
    end
  end

  before :all do
    setup
  end

  # TODO run each page's axe check separately so it doesn't exit on first failure
  # context "is accessible" do
  it "all pages are accessible" do
    results = {
      passed: [],
      failed: []
    }
    puts "links> #{LINKS}"
    LINKS.each do |link|
      visit(link)
      # TODO: how do you pass an axe config?
      axe_run = Axe::API::Run.new
      audit = Axe::Core.new(page).call axe_run

      puts "Checking #{link}"
      puts "Result: #{audit.passed?}"
      if !audit.passed?
        results[:failed].push(link)
        puts audit.failure_message
        puts "\n\n" + "-" * 50 + "\n\n"
      end
      # binding.irb
      # begin
      #   expect(page).to be_axe_clean
      # rescue
      #   result = false
      # end
    end
    puts "=" * 50
    puts "Final audit:"
    puts "Passed:\n#{format_links(results[:passed])}"
    puts "Failed:\n#{format_links(results[:failed])}"
    expect(results[:failed]).to be_empty
  end
end
# end
