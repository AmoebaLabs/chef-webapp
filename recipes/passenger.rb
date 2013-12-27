rvm_gem 'passenger' do
  ruby_string node[:webapp][:passenger][:ruby]
  version     node[:webapp][:passenger][:version]
end


