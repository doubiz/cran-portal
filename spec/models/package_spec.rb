require 'rails_helper'

RSpec.describe Package, type: :model do
  let(:package) {Package.new}

  describe "Validation" do
    it{expect(package).to validate_presence_of(:name)}
    it{expect(package).to validate_presence_of(:version)}
  end

  describe "Relations" do 
    it{expect(package).to have_many(:contributors)}
    it{expect(package).to have_many(:authors)}
    it{expect(package).to have_many(:maintainers)}
    it{expect(package).to have_many(:package_contributors)}
  end
end
