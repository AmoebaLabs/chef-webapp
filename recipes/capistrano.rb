# Prepare dirs for capistrano deployment, similar to running `cap deploy:setup`

directory app.path do
  owner app.user.name
  group app.user.group
  mode 0755
end

[app.releases_path, app.shared_path, app.log_path, app.system_path, app.run_path].each do |dir|
  directory dir do
    owner app.user.name
    group app.user.group
    mode 0775
  end
end

directory app.config_path do
  owner     app.user.name
  group     app.user.group
  mode      0700
end