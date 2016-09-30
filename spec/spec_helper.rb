require "bundler/setup"
Bundler.require(:test)

require "rack/test"
require "active_record"

ENV["RACK_ENV"] = "test"
ENV["JWT_SECRET"] = "test_secret"
ENV["JWT_ISSUER"] = "test_issuer"

Rack::Builder.parse_file("config.ru")

FactoryGirl.definition_file_paths = %w(./factories ./spec/factories)
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
end
