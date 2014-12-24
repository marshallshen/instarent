module Instarent
  class Map
    CRAIGLIST_CITY_PREFIX = {
      "chicago" => "chicago",
      "new york" => "newyork",
      "san francisco" => "sfbay",
      "austin" => "austin"
    }.freeze

    def self.lookup_zipcode(zipcode)
      response = JSON.parse(open(zip_to_city_url(zipcode)).read)["city"]
      CRAIGLIST_CITY_PREFIX[response.downcase] if response
    end

    private
    def self.zip_to_city_url(zipcode)
      "http://ziptasticapi.com/#{zipcode}"
    end
  end
end

