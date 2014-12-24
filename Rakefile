require 'rake/task'
require './app'


namespace :instarent do
  desc "fetch craiglist rentals"
  task :fetch_craiglist do
    rent_options = [{city: "chicago", bathrooms: 1, bedrooms: 2, min_price: 1200, max_price: 2400, result_size: 10}]
    rent_options.each do |rent_option|
      Jobs::FetchCraiglistRentals.perform(rent_option)
    end
  end
end

