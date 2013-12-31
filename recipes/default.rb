# Create app user
user app.user.name do
  comment   "#{app.name} app user"
  shell     "/bin/bash"
  home      app.user.home
  supports  :manage_home => true
end

# This looks silly but is serious. We want passenger included first, if it is
# so the module can be included when nginx compiles
if node.run_list.recipes.include?('webapp::passenger')
  include_recipe 'webapp::passenger'
end

%w( rvm nginx capistrano cron db ).each do |r|
  include_recipe "webapp::#{r}"
end

