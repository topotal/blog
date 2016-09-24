require "bundler/setup"
Bundler.require(:default)

require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
  end
end

namespace :schema do
  desc "Dump resource json schema"
  task :dump do
    require_relative "./app/resources/schema.rb"
    puts Api::Schema.to_json_schema
  end

  desc "Dump API documentation from json schema"
  task :doc do
    require "jdoc"
    require_relative "./app/resources/schema.rb"
    puts Jdoc::Generator.call(JSON.parse(Api::Schema.to_json_schema)).gsub(/^ \*/, "  *")
  end
end
