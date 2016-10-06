require "bundler/setup"
Bundler.require(:default)

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local

require "./app/resources/entry_resource.rb"

require "./app/controllers/base_controller"
require "./app/controllers/index_controller"

require "./app/controllers/api/v1/base_controller.rb"
require "./app/controllers/api/v1/entry_controller.rb"
require "./app/controllers/api/v1/user_controller.rb"

require "./app/models/entry"
require "./app/models/image"
require "./app/models/user"

ROUTES = {
  "/" => IndexController,
  "/api/v1/entries" => Api::V1::EntryController,
  "/api/v1/users" => Api::V1::UserController,
}.freeze

run Rack::URLMap.new(ROUTES)
