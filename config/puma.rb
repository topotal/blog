require "dotenv"
Dotenv.load

rackup "config.ru"
environment "production"

daemonize true

pidfile "tmp/pids/puma.pid"
state_path "tmp/sockets/puma.state"

stdout_redirect "log/puma.stdout.log", "log/puma.stderr.log", true

bind "unix://tmp/sockets/puma.sock"

on_restart do
  ENV.update Dotenv::Environment.new(".env")
end

workers 2
