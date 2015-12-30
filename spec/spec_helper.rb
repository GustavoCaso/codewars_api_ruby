$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'yaml'
require 'codewars_api_ruby'
require 'pry'
# Setup shared_examples
Dir["./spec/support/shared_examples/**/*.rb"].each { |f| require f }
# Setup Codewars
config_file = YAML.load(File.read(File.expand_path('../../config/secrets.yml', __FILE__)))
CodewarsApiRuby.configure do |config|
  config.api_key = config_file['api_key']
end

# Setup for test requests
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/support/cassettes'
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
end
