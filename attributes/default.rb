appdefs.user.name       = app.name
appdefs.user.group      = app.user.name
appdefs.user.home       = "/home/#{app.user.name}"

appdefs.path            = app.user.home
appdefs.current_path    = "#{app.path}/current"
appdefs.shared_path     = "#{app.path}/shared"
appdefs.releases_path   = "#{app.path}/releases"
appdefs.static_path     = "#{app.current_path}/public"
appdefs.config_path     = "#{app.shared_path}/config"
appdefs.run_path        = "#{app.shared_path}/run"
appdefs.log_path        = "#{app.shared_path}/log"
appdefs.init_path       = "#{app.shared_path}/init"

appdefs.init_script     = "#{app.init_path}/#{app.name}"
appdefs.capfile         = "#{app.config_path}/Capfile"
appdefs.procfile        = "#{app.config_path}/Procfile"

# NOTE: Cannot set to 'false' if you try to use any app stuff in unicorn.rb
appdefs.preload         = true

appdefs.workers         = 2
appdefs.socket          = "#{app.run_path}/#{app.name}.socket"

repo, branch = app.repository.match(/(^.*?)(?:#([^#]+))?$/)[1..2]
appdefs.repo            = repo
appdefs.branch          = branch || 'master'
appdefs.ci              = nil

%w( env cron ).map {|a| include_attribute "webapp::#{a}"}
