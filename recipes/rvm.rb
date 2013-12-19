rvm_script = '$HOME/.rvm/scripts/rvm'
ensure_line "#{app.user.home}/.bashrc" do
  content %{[[ -s "#{rvm_script}" ]] && source "#{rvm_script}"}
end
ensure_line "#{app.user.home}/.bashrc" do
  content %{export PATH=$PATH:$HOME/.rvm/bin}
end
