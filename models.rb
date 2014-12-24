require 'sinatra/activerecord'

if Sinatra::Base.development?
  db = URI.parse('postgres://mshen@localhost/mshen')
elsif Sinatra::Base.production?
  db = URI.parse('postgres://yehdmjypldzzyb:D6_qQngtqiYcenOicDQrc6z2Zh@ec2-107-20-166-127.compute-1.amazonaws.com:5432/dd0923icne3tdo')
end

ActiveRecord::Base.establish_connection(
  adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: 'utf8'
)

class Notification < ActiveRecord::Base
  # useremail
  # city
  # bedroom
  # max_price
  # deactivate_at
end

