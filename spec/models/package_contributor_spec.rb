require 'rails_helper'

RSpec.describe PackageContributor, type: :model do
  let(:package_contributor) {PackageContributor.new}

  describe "Validation" do
    it{expect(package_contributor).to validate_presence_of(:package_id)}
    it{expect(package_contributor).to validate_presence_of(:contributor_id)}
    it{expect(package_contributor).to validate_presence_of(:contribution_type)}
  end

  describe "Relations" do 
    it{expect(package_contributor).to belong_to(:contributor)}
    it{expect(package_contributor).to belong_to(:package)}
  end
end
