rackup "config.ru"
environment "production"

daemonize true

pidfile "/var/run/puma.pid"
state_path "/var/run/puma.state"

stdout_redirect "/tmp/puma.stdout.log", "/tmp/puma.stderr.log", true

bind "unix:///var/run/puma.sock"

on_restart do
  ENV.update Dotenv::Environment.new('.env')
end

workers 2
