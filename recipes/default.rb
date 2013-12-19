%w( capistrano javascript rvm db nginx unicorn ssh init foreman cron resque ).map do |r|
  include_recipe "app::#{r}"
end
