define :ensure_line, :content => nil do
  filename = params[:name]
  return unless params[:content] and params[:content].count("\n") == 0
  safe_content = params[:content].sub("'", "\'")
  bash "ensuring line in file '#{filename}'" do
    code    "echo '#{safe_content}' >> #{filename}"
    not_if  "grep '#{safe_content}' #{filename}"
  end
end
