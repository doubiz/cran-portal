require 'rails_helper'

RSpec.describe CranScraper do

  describe "Gets a list of all packages from Cran url" do
    scraper = CranScraper.new(false)
    it{expect(scraper.unparsed_packages.count).to be > 0}
  end

end
