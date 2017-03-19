# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "topotal-blog"
set :repo_url, "git@github.com:topotal/blog.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/blog.topotal.com"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w(config/database.yml config/secrets.yml config/puma.rb .env)

# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets/img/upload node_modules)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, {
  user: ENV["REMOTE_USER"] || "topotan",
}

set :rbenv_type, :system
set :rbenv_ruby, "2.3.0"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby pumactl)
set :bundle_flags, "--deployment --quiet --with production"

namespace :deploy do
  task :chown do
    on roles(:app) do
      sudo "chown `whoami`. -R #{deploy_to}"
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke "puma:restart"
    end
  end

  desc "Runs rake db:migrate if migrations are set"
  task :migrate do
    on roles(:migration) do
      within release_path do
        with rack_env: :production do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  task :assets do
    on roles(:app) do
      within release_path do
        sudo "npm install"
        sudo "npm run build"
      end
    end
  end

  before :starting, :chown
  after :updated, :migrate
  after :publishing, :assets
  after :assets, :restart
end
