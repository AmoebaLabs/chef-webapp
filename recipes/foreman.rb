appdefs.gems = %w(foreman)

directory app.init_path do
  owner     app.user.name
  group     app.user.name
  mode      0755
end

template app.init_script do
  source "init.erb"
  mode 0755
end
