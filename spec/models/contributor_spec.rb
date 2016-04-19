require 'rails_helper'

RSpec.describe Contributor, type: :model do
  let(:contributor) {Contributor.new}

  describe "Validation" do
    it{expect(contributor).to validate_presence_of(:name)}
  end

  describe "Relations" do 
    it{expect(contributor).to have_many(:package_contributors)}
    it{expect(contributor).to have_many(:packages)}
    it{expect(contributor).to have_many(:authored_packages)}
    it{expect(contributor).to have_many(:maintaining_packages)}
  end
end
