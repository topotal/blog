class Base < Sinatra::Base
  set :views, File.expand_path("../views", File.dirname(__FILE__))
  set :public_folder, File.expand_path("../../public", File.dirname(__FILE__))
  set :database_file, File.expand_path("config/database.yml", File.dirname(__FILE__))

  register Sinatra::ActiveRecordExtension

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end
end
