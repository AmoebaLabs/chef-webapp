define :ensure_line, :content => nil do
  filename = params[:name]
  return unless params[:content] and params[:content].count("\n") == 0
  params[:content] = [params[:content]] unless params[:content].is_a?(Array)
  safe_content = params[:content].map {|line| line.sub("'", "\'") }
  safe_content.each do |line|
    bash "ensuring #{line} in file '#{filename}'" do
      code    "echo '#{line}' >> #{filename}"
      not_if  "grep '#{line}' #{filename}"
    end
  end
end
