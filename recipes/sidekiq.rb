#
# Cookbook Name:: webapp
# Recipe:: sidekiq
#

package 'at'

worker_count = node[:application][:sidekiq][:worker_count]

template "/etc/monit/conf.d/sidekiq_#{node[:application][:name]}.conf" do
  owner 'root'
  group 'root'
  mode 0644
  source "monit/sidekiq.conf.erb"
  notifies :reload, 'service[monit]', :delayed
end

template "/#{node[:application][:init_path]}/start_sidekiq" do
  owner node[:application][:user][:name]
  group node[:application][:user][:group]
  mode 0755
  source "start_sidekiq.erb"
end


template "/#{node[:application][:init_path]}/stop_sidekiq" do
  owner node[:application][:user][:name]
  group node[:application][:user][:group]
  mode 0755
  source "stop_sidekiq.erb"
end

execute "restart-sidekiq" do
  command %Q{
    echo "sleep 20 && monit -g #{node[:application][:name]}_sidekiq restart all" | at now
  }
end
