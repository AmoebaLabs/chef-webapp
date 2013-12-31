# node[:application][:environment] must be defined (no default)

appdefs.user.name       = app.name
appdefs.user.group      = app.user.name
appdefs.user.home       = "/home/#{app.user.name}"

appdefs.path            = app.user.home
appdefs.current_path    = "#{app.path}/current"
appdefs.shared_path     = "#{app.path}/shared"
appdefs.releases_path   = "#{app.path}/releases"
appdefs.static_path     = "#{app.current_path}/public"
appdefs.config_path     = "#{app.shared_path}/config"
appdefs.system_path     = "#{app.shared_path}/system"
appdefs.run_path        = "#{app.shared_path}/run"
appdefs.log_path        = "#{app.shared_path}/log"
appdefs.init_path       = "#{app.shared_path}/init"

appdefs.init_script     = "#{app.init_path}/#{app.name}"
appdefs.capfile         = "#{app.config_path}/Capfile"
appdefs.procfile        = "#{app.config_path}/Procfile"

# NOTE: Cannot set to 'false' if you try to use any app stuff in unicorn.rb
appdefs.preload         = true

# This attribute controls if we should start the web server
appdefs.web_enabled       = true

# Note that passenger and unicorn are mutually exclusive
appdefs.unicorn_enabled   = false # Future TODO
appdefs.passenger_enabled = true

# Foreman support (will start & monitor foreman)
appdefs.foreman_enabled   = false # Future TODO

# Unicorn/Passenger options (not all apply to both):
appdefs.workers         = 2
appdefs.socket          = "#{app.run_path}/#{app.name}.socket"

repo, branch = app.repository.match(/(^.*?)(?:#([^#]+))?$/)[1..2]
appdefs.repo            = repo
appdefs.branch          = branch || 'master'
appdefs.ci              = nil

appdefs.env_vars = {
  'RAILS_ENV' => app.environment,
  'DEFAULT_HOST' => app.url
}
