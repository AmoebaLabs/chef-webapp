node.override.rvm.user_installs = [{
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

include_recipe 'rvm::user'

rvm_script = '$HOME/.rvm/scripts/rvm'
ensure_line "#{app.user.home}/.bashrc" do
  content %{[[ -s "#{rvm_script}" ]] && source "#{rvm_script}"}
end
ensure_line "#{app.user.home}/.bashrc" do
  content %{export PATH=$PATH:$HOME/.rvm/bin}
end
