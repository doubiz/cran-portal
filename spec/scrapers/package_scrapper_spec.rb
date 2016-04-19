require 'rails_helper'

RSpec.describe PackageScraper do

  describe "Creates a new package given correct input" do
    it{expect {
      PackageScraper.new({"Package" => "gramEvol", "Version" => "2.1-2"})
      }.to change(Package,:count).by(1)}
  end

  describe "Raises error when request returns wrong response" do
    it{expect {
      PackageScraper.new({"Package" => "gramEvol", "Version" => "2.1-212"})
      }.to raise_error(RuntimeError)}
  end

  describe "Raises error when inputs are missing" do
    it{expect {
      PackageScraper.new({"Package" => "gramEvol"})
      }.to raise_error(RuntimeError)}
  end

end
