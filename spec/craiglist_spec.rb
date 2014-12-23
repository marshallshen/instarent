require "spec_helper"

describe Instarent::Craiglist, vcr: true do
  before(:each) { allow(Mail).to receive(:deliver) }

  context "Find apartments in Chicago" do
    let(:rent_options) { {city: "chicago", bathrooms: 1, bedrooms: 2, min_price: 1200, max_price: 2400} }

    it "returns an array of apartments" do
      expect(Instarent::Craiglist.new(rent_options).apartments).to_not be_empty
    end
  end
end
