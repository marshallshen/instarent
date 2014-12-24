module Instarent
  class Craiglist
    attr_reader :city, :bathrooms, :bedrooms, :min_price, :max_price, :result_size
    def initialize(options)
      @city = options[:city]
      @bathrooms = options[:bathrooms]
      @bedrooms = options[:bedrooms]
      @min_price = options[:min_price]
      @max_price = options[:max_price]
      @result_size = options[:result_size]
    end

    def apartments
      # 1. fetch apt urls
      urls = raw_apartment_urls || []
      # 2. fetch apt with geo location: [{"apt_url": [123, 321]}]
      urls.reduce([]) do |candidate_pools, apartment_url|
        candidate_pools << apartment_location(apartment_url)
      end.compact
    end

    # 3. return apt of interest in each neighborhood:
    # {old_town: [["apt_url1", "google map url"]], lake_view: [["apt_url1", "Google map url"]]}
    def matched_apartments(candidate_apartments)
      candidate_apartments.reduce(Hash.new{|k,v| k[v] = []}) do |apts_per_neighborhood, candidate|
        NEIGHBORHOOD_RANGE.each_pair do |neighborhood, geo_range|
          if within_geo_range?(geo_range, candidate)
            apts_per_neighborhood[neighborhood].push([candidate[:url], google_map_url(candidate[:latitude], candidate[:longtitude])])
          end
        end
        apts_per_neighborhood
      end
    end

    def raw_apartment_urls
      nodes = raw_search_contents.reduce([]) do |url_nodes, parsed_rent_node|
        url_nodes.push(parsed_rent_node.elements.find{|element| element.name == "a"})
      end

      nodes.compact!.map{|l| l.attributes["href"].value}[0..result_size-1]
    end

    private
    def apartment_location(apartment_url)
      if (content = raw_apartment_content(apartment_url).at_css("#map"))
        latitude = content.attributes["data-latitude"].value
        longtitude = content.attributes["data-longitude"].value
        return {url: "#{base_url}#{apartment_url}", latitude: latitude, longtitude: longtitude}
      end
    end

    def raw_apartment_content(apartment_url)
      Nokogiri::HTML(open("#{base_url}#{apartment_url}"))
    end

    def raw_search_contents
      @raw_contents ||= Nokogiri::HTML(open("#{base_url}#{search_url}")).at_css(".content").elements
    end

    def base_url
      "http://#{@city}.craigslist.org"
    end

    def search_url
      "/search/chc/apa?bathrooms=#{@bathrooms}&bedrooms=#{@bedrooms}&maxAsk=#{@max_price}&minAsk=#{@min_price}"
    end

    def google_map_url(latitude, longtitude)
      "http://maps.google.com/maps?q=#{latitude},#{longtitude}"
    end

    def within_geo_range?(geo_range, candidate)
      within?(geo_range[:latitude], candidate[:latitude]) &&
        within?(geo_range[:longtitude], candidate[:longtitude])
    end

    def within?(interval, point)
      point.to_f >= interval[0].to_f && point.to_f <= interval[1].to_f
    end

    #def mailer
    #  @mailer ||= Instarent::Mailer.new
    #end
  end
end

