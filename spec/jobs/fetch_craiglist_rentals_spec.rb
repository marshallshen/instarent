require 'spec_helper'

describe Jobs::FetchCraiglistRentals, vcr: true do
  let(:chicago_rental_options) { {city: "chicago", bathrooms: 1, bedrooms: 2, min_price: 1200, max_price: 2400, result_size: 10} }

  it 'persists lastest rentals for Chicago'
  it 'persists lastest rentals for New York'
  it 'persists lastest rentals for Austin'
end

