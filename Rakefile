require "bundler/gem_tasks"
require "instarent"

namespace :rent do
  desc "find good place to rent in Chicago"
  task :chicago do
    rent_options = {
      city: Instarent::CITY,
      bathrooms: Instarent::BATHROOMS,
      bedrooms: Instarent::BEDROOMS,
      min_price: Instarent::MIN_PRICE,
      max_price: Instarent::MAX_PRICE
    }

    # retry 3 times
    max_attempts = 3

    begin
      Instarent::Craiglist.new(rent_options).run
    rescue
      max_attempts -= 1
      if max_attempts > 0
        sleep 60
        retry
      end
      raise
    end
  end

  task :new_york do
    # TO BE CONTINUED..
  end
end

