require 'models'
require 'instarent'
require 'jobs'
require 'vcr'

VCR.configure do |c|
  c.default_cassette_options = { record: :new_episodes }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # TODO
end

ActiveRecord::Base.logger = nil

