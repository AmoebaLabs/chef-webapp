# We're going to install passenger into the default / system ruby
default[:webapp][:passenger][:ruby] = node[:global_ruby_version]
default[:webapp][:passenger][:common_pkgs] = %w( libssl-dev zlib1g-dev libcurl4-openssl-dev )
default[:webapp][:passenger][:version] = '4.0.29'
default[:webapp][:passenger][:root_path] = "/usr/local/rvm/gems/#{node[:webapp][:passenger][:ruby]}/gems/passenger-#{node[:webapp][:passenger][:version]}"
default[:webapp][:passenger][:ruby_wrapper] = "/usr/local/rvm/gems/#{node[:webapp][:passenger][:ruby]}/bin/ruby"
