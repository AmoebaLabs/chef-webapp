# Prepare dirs for capistrano deployment, similar to running `cap deploy:setup`

include_recipe 'capistrano'

cap_setup do
  path      app.path
  owner     app.user.name
  appowner  app.user.name
  group     app.user.name
end

directory app.config_path do
  owner     app.user.name
  group     app.user.name
  mode      0700
end

directory app.run_path do
  owner     app.user.name
  group     app.user.name
  mode      0755
end
