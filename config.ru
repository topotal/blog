require "sinatra"
require "sinatra/base"
require "mysql2"
require "active_record"
require "sinatra/activerecord"
require "will_paginate"
require "redcarpet"
require "securerandom"

require "./app/controllers/base"
require "./app/controllers/index_controller"
require "./app/controllers/api_controller"

require "./app/models/article"
require "./app/models/image"
require "./app/models/users"

ROUTES = {
  "/" => IndexController,
  "/api" => ApiController,
}.freeze

run Rack::URLMap.new(ROUTES)
