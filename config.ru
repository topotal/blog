require "bundler/setup"
Bundler.require(:default)

require "./app/controllers/base_controller"
require "./app/controllers/index_controller"
require "./app/controllers/api_controller"

require "./app/models/entry"
require "./app/models/image"
require "./app/models/user"

ROUTES = {
  "/" => IndexController,
  "/api" => ApiController,
}.freeze

run Rack::URLMap.new(ROUTES)
