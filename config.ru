require 'bundler/setup'
Bundler.require(:default)

require "./app/controllers/base"
require "./app/controllers/index_controller"
require "./app/controllers/api_controller"

require "./app/models/article"
require "./app/models/image"
require "./app/models/user"

ROUTES = {
  "/" => IndexController,
  "/api" => ApiController,
}.freeze

run Rack::URLMap.new(ROUTES)
