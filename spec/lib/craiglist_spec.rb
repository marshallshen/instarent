require "spec_helper"

describe Instarent::Craiglist, vcr: true do
  context "Find apartments in Chicago" do
    let(:rent_options) { {city: "chicago", bathrooms: 1, bedrooms: 2, min_price: 1200, max_price: 2400, result_size: 10} }
    let(:craiglist) { Instarent::Craiglist.new(rent_options) }

    describe '.raw_apartment_urls' do
      it "fetches all apartment urls" do
        expect(craiglist.raw_apartment_urls.size).to be > 0
        expect(craiglist.raw_apartment_urls.size).to be <= rent_options[:result_size]
      end
    end

    describe '.apartments' do
      it "returns an array of apartments" do
        expect(craiglist.apartments).to be_a(Array)
        expect(craiglist.apartments.first).to be_a(Hash)
      end
    end

    describe '.matched_apartments' do
      it "returns an array of matched apartments for each neighborhood"
    end
  end
end

