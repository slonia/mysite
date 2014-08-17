USER = 'berlin'

worker_processes 2

working_directory "/home/#{USER}/web-app"

listen "/home/#{USER}/web-app/tmp/sockets/unicorn.studentime.sock", :backlog => 64

pid "/home/#{USER}/web-app/tmp/pids/unicorn.studentime.pid"

preload_app true

stderr_path "/home/#{USER}/web-app/log/unicorn.stderr.log"
stdout_path "/home/#{USER}/web-app/log/unicorn.stdout.log"


after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
