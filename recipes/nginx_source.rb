require 'digest/sha1'

#include_recipe 'nginx::source' (not working due to ohai plugin and chef 11)
# Grabbing most of the cookbook of nginx::source here, and including the parts that I can
#

nginx_url = node['nginx']['source']['url'] ||
  "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

node.set['nginx']['binary']          = node['nginx']['source']['sbin_path']
node.set['nginx']['daemon_disable']  = true

include_recipe 'nginx::commons_dir'
include_recipe 'nginx::commons_script'
include_recipe 'build-essential::default'

src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}.tar.gz"

packages = %w(libpcre3 libpcre3-dev libssl-dev)

packages.each do |name|
  package name
end

remote_file nginx_url do
  source   nginx_url
  checksum node['nginx']['source']['checksum']
  path     src_filepath
  backup   false
end

node.run_state['nginx_force_recompile'] = false
node.run_state['nginx_configure_flags'] =
  node['nginx']['source']['default_configure_flags'] | node['nginx']['configure_flags']

cookbook_file "#{node['nginx']['dir']}/mime.types" do
  source 'mime.types'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

# Unpack downloaded source so we could apply nginx patches
# in custom modules - example http://yaoweibin.github.io/nginx_tcp_proxy_module/
# patch -p1 < /path/to/nginx_tcp_proxy_module/tcp.patch
bash 'unarchive_source' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)}
  EOH
  not_if { ::File.directory?("#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}") }
end

node['nginx']['source']['modules'].each do |ngx_module|
  include_recipe ngx_module
end

# Calculate the version information (based on version number and compile flags)
configure_flags = node.run_state['nginx_configure_flags']
version_info    = node['nginx']['source']['version'].to_s + ' ' +  configure_flags.sort.join(' ')
version_info = Digest::SHA1.hexdigest(version_info)
previous_version_info = ''
if ::File.exist?('/etc/nginx/version-info')
  previous_version_info = ::File.read('/etc/nginx/version-info').chomp
end

rvm_shell 'compile_nginx_source' do
  ruby_string node[:global_ruby_version]

  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    cd nginx-#{node['nginx']['source']['version']} &&
    ./configure #{node.run_state['nginx_configure_flags'].join(" ")} &&
    make && make install
  EOH

  not_if do
    # Check the version-info file, if it matches our current version_info, don't bother compiling
     version_info == previous_version_info
  end

  notifies :restart, 'service[nginx]'
end

## Upstart init

# we rely on this to set up nginx.conf with daemon disable instead of doing
# it in the upstart init script.
node.set['nginx']['daemon_disable']  = node['nginx']['upstart']['foreground']

template '/etc/init/nginx.conf' do
  source 'nginx-upstart.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

service 'nginx' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action   :nothing
end

node.run_state.delete('nginx_configure_flags')
node.run_state.delete('nginx_force_recompile')

# Write out a hash to determine if we need to recompile later
file '/etc/nginx/version-info' do
  owner 'root'
  group 'root'
  mode '0644'
  content version_info
end
