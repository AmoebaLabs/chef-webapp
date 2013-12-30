include_recipe 'webapp::nginx_source'

if app.web_enabled
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

# site nginx config which goes into sites-available/
template "#{node[:nginx][:dir]}/sites-available/#{app.name}.conf" do
  source "nginx.site.conf.erb"
  notifies :reload, resources(:service => "nginx")
end

nginx_site "#{app.name}.conf"

if app[:http_auth]
  package "apache2-utils"

  htpasswd "#{node[:nginx][:dir]}/htpasswd" do
    user      app.http_auth.user
    password  app.http_auth.password
  end
end
