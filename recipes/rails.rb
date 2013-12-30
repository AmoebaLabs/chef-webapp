## Main Rails Recipe (includes necessary sub-recipes for a rails app server)

# Rails application server support

if app.passenger_enabled && app.unicorn_enabled
  raise 'You must pick passenger or unicorn, but not both.'
end

if app.passenger_enabled
  include_recipe 'webapp::passenger'
end

if app.unicorn_enabled
  raise 'Unicorn support not yet available. You must use passenger (for now).'
end
