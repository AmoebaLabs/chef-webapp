node[:webapp][:passenger][:common_pkgs].each do |p|
  package p
end

# Installs passenger into the specified ruby (usually the system ruby), which
# can be different than the ruby version of the application itself.

rvm_gem 'passenger' do
  ruby_string node[:webapp][:passenger][:ruby]
  version     node[:webapp][:passenger][:version]
end

# Now run the gem command to compile it into nginx

