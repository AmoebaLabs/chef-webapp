# Create app user
user app.user.name do
  comment   "#{app.name} app user"
  shell     "/bin/bash"
  home      app.user.home
  supports  :manage_home => true
end

case app.type.downcase
  when 'rails', 'passenger'
    include_recipe 'webapp::passenger'
  when 'unicorn'
    raise "Unicorn support not yet implemented"
  when 'nodejs'
    raise "NodeJS support not yet implemented"
  else
    raise "You must specify an application type (hint: passenger, unicorn, nodejs, and so forth)"
end

%w( rvm nginx capistrano cron db ).each do |r|
  include_recipe "webapp::#{r}"
end

