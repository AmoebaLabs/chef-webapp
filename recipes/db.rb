if app.database
  db_conf = Hash[app.database]
  db_conf.delete 'environments'
  db_conf['database'] = db_conf.delete 'name'

  # create database user
  case db_conf.delete 'type'
    when /^postgres/
      if %w(localhost 127.0.0.1).include? app.database.host
        db_conf.delete 'host'
      end
      psql_create_user      app.user.name
      psql_create_database  app.database.name do
        owner app.user.name
      end
  end

  file "#{app.config_path}/database.yml" do
    owner app.user.name
    group app.user.group
    mode  0600
    content YAML.dump(Hash[app.database.environments.map {|env, conf| [env, db_conf.merge(conf).to_hash] }])
  end
end
