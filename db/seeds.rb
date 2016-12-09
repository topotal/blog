# coding: utf-8
require "bundler/setup"
Bundler.require(:default)

Rack::Builder.parse_file("config.ru")

FactoryGirl.definition_file_paths = %w(./factories ./spec/factories)
FactoryGirl.find_definitions

profiles = FactoryGirl.create_list(:user_profile, 10, :with_user)

100.times do
  FactoryGirl.create(:entry, user_id: profiles.sample.user_id)
end
