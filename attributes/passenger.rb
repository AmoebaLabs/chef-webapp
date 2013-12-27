# We're going to install passenger into the default / system ruby
default[:webapp][:passenger][:ruby] = node[:rvm][:default_ruby]
default[:webapp][:passenger][:common_pkgs] = %w{libcurl-devel openssl-devl zlib-devel}
default[:webapp][:passenger][:version] = '4.0.29'
default[:webapp][:passenger][:root_path] = "/usr/local/rvm/gems/#{node[:webapp][:passenger][:ruby]}/gems/passenger-#{node[:webapp][:passenger][:version]}"
default[:webapp][:passenger][:ruby_wrapper] = "/usr/local/rvm/gems/#{node[:webapp][:passenger][:ruby]}/bin/ruby"

# Add the common_pkgs to default[:packages] array so they're installed
default[:packages] = node[:webapp][:passenger][:common_pkgs]

