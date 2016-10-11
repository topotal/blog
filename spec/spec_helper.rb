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

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean

Dir["./spec/supports/**/*.rb"].each(&method(:require))

RSpec.configure do |config|
  config.include ApiHelpers
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
end
