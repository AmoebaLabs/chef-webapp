include_attribute 'webapp::nodejs'
include_recipe 'nodejs'

execute 'sudo npm install -g bower' do
  not_if 'which bower'
end