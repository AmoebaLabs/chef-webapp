# Ensure the top-level directory exists for redis' user homes
directory '/var/lib/redis' do
  user 'root'
  group 'root'
  mode 0755
end

directory '/var/log/redis' do
  user 'root'
  group 'root'
  mode 0755
end

%w(redisio::install redisio::enable).each do |r|
  include_recipe r
end

redis_commands = service_commands("redis#{app.name}")

link "#{app.run_path}/redis.sock" do
  to app.redis.socket
  owner app.user.name
  group app.user.group
end

group app.redis.group do
  action :modify
  members app.user.name
  append true
end

process_name = "#{app.name}_redis"
template "/etc/monit/conf.d/#{process_name}.conf" do
  source 'monit/redis.conf.erb'
  owner 'root'
  group 'root'
  mode  0644
  variables redis_commands.merge(process_name: process_name)
  notifies :reload, 'service[monit]', :delayed
end
