describe "home page", type: :feature, js: true do
    it "is accessible" do
      visit '/'
      expect(page).to be_axe_clean.according_to :wcag2a
    end
end