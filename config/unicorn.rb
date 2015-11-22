working_directory "/var/www/app/current"
pid "/var/www/app/shared/tmp/unicorn.pid"
stderr_path "/var/www/app/current/log/unicorn.log"
stdout_path "/var/www/app/current/log/unicorn.log"

listen "/tmp/unicorn.jigentter.sock"
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 4)
timeout 10

preload_app true

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', ENV['RAILS_ROOT'])
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end