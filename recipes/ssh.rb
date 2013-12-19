# Generate ssh key-pair
generate_keys do
  user    app.user.name
  home    app.user.home
end

# Setup ~/.ssh/authorized_keys file
authorized_keys do
  user    app.user.name
  home    app.user.home
end
