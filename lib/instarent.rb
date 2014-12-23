require "instarent/craiglist"
module Instarent
  CITY = 'chicago'
  BATHROOMS = 1
  BEDROOMS = 2
  MIN_PRICE = 1200
  MAX_PRICE = 2400

  RESULT_SIZE = 20.freeze

  NEIGHBORHOOD_RANGE = {
    logan_square: { latitude: [41.914, 41.931], longtitude: [-87.717, -87.687]},
    old_town: { latitude: [41.903, 41.913], longtitude: [-87.648, -87.629]},
    liconln_park: { latitude: [41.922, 41.914], longtitude: [-87.658, -87.649]},
    lake_view: { latitude: [41.935, 41.947], longtitude: [-87.664, -87.652]},
    rosco_village: { latitude: [41.940, 41.950], longtitude: [-87.679, -87.663]},
  }.freeze

  RECIPIENTS = ["shen.marshall@gmail.com", "brian.dellabetta@gmail.com"]
end

