include_recipe 'nodejs'

execute "sudo npm install -g bower#{app[:bower_version].present? ? '@'+app[:bower_version] : ''}" do
  not_if 'which bower'
end