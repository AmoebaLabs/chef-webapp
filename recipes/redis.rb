# TODO Include other recipies from role

include_recipe 'redisio::enable'
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
monitrc process_name do
  template_source   'monit/redis.conf.erb'
  template_cookbook 'app'

  variables redis_commands.merge(process_name: process_name)
end
