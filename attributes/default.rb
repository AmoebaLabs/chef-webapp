# node[:application][:environment] must be defined (no default)

appdefs.user.name       = app.name
appdefs.user.group      = app.user.name
appdefs.user.home       = "/home/#{app.user.name}"

appdefs.path            = app.user.home
appdefs.current_path    = "#{app.path}/current"
appdefs.shared_path     = "#{app.path}/shared"
appdefs.releases_path   = "#{app.path}/releases"
appdefs.static_path     = "#{app.current_path}/public"
appdefs.config_path     = "#{app.current_path}/config"
appdefs.system_path     = "#{app.shared_path}/system"
appdefs.run_path        = "#{app.shared_path}/run"
appdefs.log_path        = "#{app.shared_path}/log"
appdefs.init_path       = "#{app.shared_path}/init"

# Note that passenger and unicorn are mutually exclusive. Defaults to passenger.
# Type is mandatory and you must pick one and only one
# TODO Future unicorn & nodejs support
appdefs.type            = 'passenger'

repo, branch = app.repository.match(/(^.*?)(?:#([^#]+))?$/)[1..2]
appdefs.repo            = repo
appdefs.branch          = branch || 'master'
appdefs.ci              = nil

appdefs.env_vars = {
  'RAILS_ENV' => app.environment,
  'DEFAULT_HOST' => app.url
}
