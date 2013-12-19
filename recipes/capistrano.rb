# Create app user
user app.user.name do
  comment   "#{app.name} app user"
  shell     "/bin/bash"
  home      app.user.home
  supports  :manage_home => true
end

# Prepare dirs for capistrano deployment, similar to running `cap deploy:setup`

include_recipe "capistrano"

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

template app.capfile do
  source    "Capfile.erb"
  owner     app.user.name
  group     app.user.name
  mode      0640
end

file app.envfile do
  owner     app.user.name
  group     app.user.name
  content   app.env_vars.map {|k, v| %{#{k}="#{v}"}}.join "\n"
end
