# coding: utf-8
require "bundler/setup"
Bundler.require(:default)

Rack::Builder.parse_file("config.ru")

FactoryGirl.definition_file_paths = %w(./factories ./spec/factories)
FactoryGirl.find_definitions

100.times do
  FactoryGirl.create(:entry, :with_user)
end
