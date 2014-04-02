# This is the app ruby version
appdefs[:ruby_version] = 'ruby-1.9.3-p484'

# The ruby wrapper for the application itself
appdefs[:ruby_wrapper] = "#{node[:application][:user][:home]}/.rvm/rubies/#{node[:application][:ruby_version]}/bin/ruby"

# These are the app's gems. Append by setting to node.default
appdefs[:gems] = %w( bundler rake )

# And finally, some overall (not per-app) RVM settings:
default[:webapp][:rvm][:common_pkgs] = %w( qt4-qmake libqt4-dev )

# This is the system-level (global) ruby. Each app can have its own as well.
default[:global_ruby_version] = 'ruby-2.0.0-p353'

### End of defaults for webapp::rvm. Overrides and such below:

override[:rvm][:default_ruby] = node[:global_ruby_version]
