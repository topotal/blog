require "bundler/setup"
Bundler.require(:default)

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local

Refile.cache = Refile::Backend::FileSystem.new("tmp")
Refile.store = Refile::Backend::FileSystem.new("public/assets/img/upload")
Refile.secret_key = ENV["JWT_SECRET"] || "secret"

[
  "/app/resources/*.rb",
  "/app/uploaders/*.rb",
  "/app/controllers/*.rb",
  "/app/controllers/api/v1/*.rb",
  "/app/models/*.rb",
].each { |file| Dir[File.dirname(__FILE__) + file].each(&method(:require)) }

ROUTES = {
  "/" => IndexController,
  "/api/v1/entries" => Api::V1::EntryController,
  "/api/v1/users" => Api::V1::UserController,
  "/api/v1/images" => Api::V1::ImageController,
}.freeze

run Rack::URLMap.new(ROUTES)
