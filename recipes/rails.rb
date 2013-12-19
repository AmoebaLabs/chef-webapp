## Main Rails Recipe (includes necessary sub-recipes for a rails app server)
# Think of this like a role

include_attribute "webapp::rvm"
include_attribute "webapp::rails"

%w(unicorn capistrano webapp rvm::user).each do |r|
  include_recipe r
end
