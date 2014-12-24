module Jobs
  class FetchCraiglistRentals
    def self.perform(options)
      rents = Instarent::Craiglist.new(options).apartments

      rents.each do |rent|
        Rent.create!({
          bathrooms: options[:bathrooms],
          bedrooms: options[:bedrooms],
          city: options[:city],
          longtitude: rent[:longtitude],
          latitude: rent[:latitude],
          price: rent[:price],
          url: rent[:url]
        })
      end
    end
  end
end

