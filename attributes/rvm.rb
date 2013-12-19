appdefs.ruby_version = '1.9.3'
appdefs.gems = []
override.rvm.user_installs = [{
  'user'          => app.user.name,
  'home'          => app.user.home,
  'default_ruby'  => app.ruby_version,
  'rvmrc'         => {
   'rvm_project_rvmrc'     => 1,
   'rvm_trust_rvmrcs_flag' => 1
  },
  'global_gems'   => [
   { 'name'    => 'rubygems-bundler',
     'action'  => 'remove'
   }
  ] + app.gems.map {|g| { 'name' => g } }
}]
