worker_processes 4

preload_app true

working_directory "/home/deploy/openanno"

listen "/tmp/unicorn.sock", :backlog => 1024
listen 8080, :tcp_nopush => true

timeout 30

pid "/home/deploy/openanno/unicorn.pid"

stderr_path "/home/deploy/openanno/log/unicorn-error.log"
stdout_path "/home/deploy/openanno/log/unicorn-access.log"

# REE
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server,worker|
  # setup mongo here?
end

after_fork do |server, worker|
end
