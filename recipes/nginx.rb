include_recipe 'webapp::nginx_source'
include_recipe 'nginx::commons_conf'

if app[:nginx][:enabled]
  service "nginx" do
    action :start
  end
else
  service "nginx" do
    action :stop
  end
  service "nginx" do
    action :disable
  end
end

# Can't force ssl w/o ssl
if app.ssl.force && !app.ssl.enabled
  raise "Can't force ssl in your application if ssl is not enabled!"
end

# site nginx config which goes into sites-available/
template "#{node[:nginx][:dir]}/sites-available/#{app.name}.conf" do
  source "nginx.site.conf.erb"
  notifies :reload, resources(:service => "nginx")
end

nginx_site 'default' do
  enable false
end

nginx_site "#{app.name}.conf"

if app[:http_auth]
  package "apache2-utils"

  htpasswd "#{node[:nginx][:dir]}/htpasswd" do
    user      app.http_auth.user
    password  app.http_auth.password
  end
end

# Finally ensure monit has a nginx config
template "/etc/monit/conf.d/nginx.conf" do
  source 'monit/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode  0644
  notifies :reload, 'service[monit]', :delayed
end
