username = app.user.name
template app.procfile do
  source    "Procfile.erb"
  owner     username
  group     username
  mode      0755
end
