set :branch, 'staging'
set :deploy_to, "/var/www/staging.blog.topotal.com"
server "staging.blog.topotal.com", roles: %w(app migration)
