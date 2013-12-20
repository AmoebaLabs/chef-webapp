if app.unicorn_enabled
  include_recipe 'unicorn'

  monitrc "#{app.name}_unicorn" do
    template_source   "monit/unicorn.conf.erb"
    template_cookbook "app"
  end

  app.workers.times do |w|
    monitrc "#{app.name}_unicorn_worker_#{w}" do
      template_source   "monit/unicorn_worker.conf.erb"
      template_cookbook "app"
      variables({ worker_id: w })
    end
  end
end

unicorn_config "#{app.config_path}/unicorn.rb" do
  preload_app         app.preload
  copy_on_write       true
  worker_timeout      30
  worker_processes    app.workers
  listen app.socket => {
    backlog: 100
  }
  pid                 "#{app.run_path}/unicorn.pid"
  stderr_path         "#{app.log_path}/unicorn.stderr.log"
  stdout_path         "#{app.log_path}/unicorn.stdout.log"
  working_directory   app.current_path
  owner               app.user.name
  group               app.user.name

  before_fork <<-END # do |server, worker|
    if defined? ActiveRecord::Base
      ActiveRecord::Base.connection.disconnect!
    end
    old_pid = "\#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
        Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
  END

  after_fork <<-END # do |server, worker|
    if defined? ActiveRecord::Base
      ActiveRecord::Base.establish_connection
    end

    worker_pidfile = server.config[:pid].sub('.pid', ".\#{worker.nr}.pid")
    system("echo \#{Process.pid} > \#{worker_pidfile}")
  END
end
