require 'sinatra'
require_relative 'models'
require_relative 'jobs'
require_relative 'lib/instarent'

get '/' do
  erb :index
end

post '/search' do
  @email = params["email"]
  @city = params["city"]
  @bedroom = params["bedroom"]
  @max_price = params["max_price"]

  p params

  erb :search
end

