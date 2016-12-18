# A sample Gemfile
source "https://rubygems.org"

gem "sinatra", require: "sinatra/base"
gem "sinatra-contrib", require: "sinatra/contrib"
gem "will_paginate", "~>3.0.5", require: ["will_paginate", "will_paginate/active_record"]
gem "erubis", require: "erubis"
gem "mysql2", "~> 0.3.20"
gem "sinatra-activerecord", require: "sinatra/activerecord"
gem "json_world"
gem "jwt"
gem "activerecord"
gem "redcarpet"
gem "bcrypt"
gem "refile", require: ["refile", "refile/attachment/active_record"]
gem "refile-mini_magick"
gem "data_uri"
gem "rake"
gem "rack-json_schema"

group :production do
  gem "puma"
end

group :development do
  gem "pry"
  gem "hirb"
  gem "awesome_print"
  gem "sqlite3"
  gem "rubocop"
  gem "onkcop"
  gem "jdoc"
end

group :test do
  gem "factory_girl"
  gem "faker"
  gem "rspec", require: "rspec/core/rake_task"
  gem "database_cleaner"
end
