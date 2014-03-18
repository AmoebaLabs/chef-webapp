# Attributes for Sidekiq module. Note: This is an optional module and
# is not included by default with the base recipe.

default[:application][:sidekiq][:worker_count] = 1
default[:application][:sidekiq][:monit_timeout] = 90
