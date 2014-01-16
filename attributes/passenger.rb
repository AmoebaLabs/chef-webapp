include_attribute 'webapp::rvm' # RVM must be included before this... for ruby version
include_attribute 'webapp::nginx' # Need nginx attributes to set configure flags

# We're going to install passenger into the default / system ruby
default[:webapp][:passenger][:ruby] = node[:global_ruby_version]
default[:webapp][:passenger][:common_pkgs] = %w( libssl-dev zlib1g-dev libcurl4-openssl-dev )
default[:webapp][:passenger][:version] = '4.0.29'
default[:webapp][:passenger][:root_path] = "/usr/local/rvm/gems/#{node[:webapp][:passenger][:ruby]}/gems/passenger-#{node[:webapp][:passenger][:version]}"
default[:webapp][:passenger][:ruby_wrapper] = "/usr/local/rvm/rubies/#{node[:webapp][:passenger][:ruby]}/bin/ruby"

# nginx config value defaults
default[:webapp][:passenger][:max_pool_size] = 6
default[:webapp][:passenger][:spawn_method] = 'smart'
default[:webapp][:passenger][:buffer_response] = 'off'
default[:webapp][:passenger][:min_instances] = 1
default[:webapp][:passenger][:max_instances_per_app] = 0
default[:webapp][:passenger][:pool_idle_time] = 300
default[:webapp][:passenger][:max_requests] = 0

# Add passenger config flag
override['nginx']['configure_flags'] = node.override['nginx']['configure_flags'] |
  ["--add-module=#{node[:webapp][:passenger][:root_path]}/ext/nginx"]

# Override values for nginx passenger.conf
override['nginx']['passenger']['root'] = node[:webapp][:passenger][:root_path]
override['nginx']['passenger']['ruby'] = node[:webapp][:passenger][:ruby_wrapper]
override['nginx']['passenger']['max_pool_size'] = node[:webapp][:passenger][:max_pool_size]
override['nginx']['passenger']['spawn_method'] = node[:webapp][:passenger][:spawn_method]
override['nginx']['passenger']['buffer_response'] = node[:webapp][:passenger][:buffer_response]
override['nginx']['passenger']['min_instances'] = node[:webapp][:passenger][:min_instances]
override['nginx']['passenger']['max_instances_per_app'] = node[:webapp][:passenger][:max_instances_per_app]
override['nginx']['passenger']['pool_idle_time'] = node[:webapp][:passenger][:pool_idle_time]
override['nginx']['passenger']['max_requests'] = node[:webapp][:passenger][:max_requests]