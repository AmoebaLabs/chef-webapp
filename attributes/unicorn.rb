# NOTE: Cannot set to 'false' if you try to use any app stuff in unicorn.rb
appdefs.unicorn.preload         = true

# Set the socket for unicorn app server
appdefs.unicorn.socket          = "#{app.run_path}/#{app.name}.socket"