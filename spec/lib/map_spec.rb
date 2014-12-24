require "spec_helper"

describe Instarent::Map, vcr: true do
  it "looks up city based on zip code" do
    expect(Instarent::Map.lookup_zipcode(60661)).to eq("chicago")
    expect(Instarent::Map.lookup_zipcode(94101)).to eq("sfbay")
  end

  it "returns nil if zip code is invalid" do
    expect(Instarent::Map.lookup_zipcode("808FooFighter")).to be_nil
  end

  it "returns nil if city is not served" do
    expect(Instarent::Map.lookup_zipcode(97201)).to be_nil # portland
  end
end

