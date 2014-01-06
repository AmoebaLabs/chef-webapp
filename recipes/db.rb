db_conf = Hash[app.database]
db_conf.delete 'environments'
db_conf['database'] = db_conf.delete 'name'

db_type = db_conf.delete('type').downcase

# create database user
case db_type
  when /^postgres/
    if %w(localhost 127.0.0.1).include? app.database.host
      db_conf.delete 'host'
    end

    include_recipe 'postgresql::server'

    psql_create_user      app.user.name
    psql_create_database  app.database.name do
      owner app.user.name
    end
  else
    raise "You must specify a valid database type in your application config"
end

# Ensure monit has a monitor of the DB
template "/etc/monit/conf.d/#{db_type}.conf" do
  source "monit/#{db_type}.conf.erb"
  owner 'root'
  group 'root'
  mode  0644
  notifies :reload, 'service[monit]', :delayed
end

file "#{app.config_path}/database.yml" do
  owner app.user.name
  group app.user.group
  mode  0600
  content YAML.dump(Hash[app.database.environments.map {|env, conf| [env, db_conf.merge(conf).to_hash] }])
end
