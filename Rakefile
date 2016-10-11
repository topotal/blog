require "bundler/setup"
Bundler.require(:default, :development, :test)

require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
  end
end

task spec: ["spec:prepare", "spec:rspec"]
namespace :spec do
  task :prepare do
    Rake::Task["db:test:prepare"].execute
  end
  RSpec::Core::RakeTask.new(:rspec) if defined?(RSpec::Core::RakeTask)
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

  desc "Update API documentation and json schema"
  task :update do
    require "jdoc"
    require_relative "./app/resources/schema.rb"
    schema_path = "./docs/schema.json"
    document_path = "./docs/schema.md"
    File.write(schema_path, Api::Schema.to_json_schema)
    File.write(document_path, Jdoc::Generator.call(JSON.parse(Api::Schema.to_json_schema)).gsub(/^ \*/, "  *"))
  end
end

task :console do
  Rack::Builder.parse_file("config.ru")
  binding.pry
end
