## Main Rails Recipe (includes necessary sub-recipes for a rails app server)
# Think of this like a role

%w( webapp).each do |r|
  include_recipe r
end
