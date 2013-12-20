include_recipe 'nodejs'

execute 'sudo npm install -g bower' do
  not_if 'which bower'
end