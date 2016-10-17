rackup "config.ru"
environment "production"

daemonize true

pidfile "/var/run/puma.pid"
state_path "/var/run/puma.state"

stdout_redirect "/tmp/puma.stdout.log", "/tmp/puma.stderr.log", true

bind "tcp://0.0.0.0:9292"
# bind "unix:///var/run/puma.sock"

port 9293

workers 2
