#%w( capistrano javascript rvm db nginx unicorn ssh init foreman cron resque ).map do |r|
#  include_recipe "app::#{r}"
#end

# Create app user
user app.user.name do
  comment   "#{app.name} app user"
  shell     "/bin/bash"
  home      app.user.home
  supports  :manage_home => true
end

%w( nginx rvm capistrano cron db ).each do |r|
  include_recipe "webapp::#{r}"
end

