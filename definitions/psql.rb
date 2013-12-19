define :psql_create_user do
  username = params[:name]
  user_check = psql_query "select count(*) from pg_roles where rolname='#{username}'"
  execute "create psql user '#{username}'" do
    command   "createuser -d -R -S #{username}"
    only_if   "test 0 -eq `#{ user_check }`", :user => 'postgres'
    user      "postgres"
  end
end

define :psql_create_database, :owner => nil, :encoding => 'utf8' do
  dbname = params[:name]
  owner  = params[:owner] or dbname
  db_check = psql_query "select count(*) from pg_database where datname='#{dbname}'"
  execute "create psql database '#{dbname}'" do
    command   "createdb -E #{params[:encoding]} -O #{owner} #{dbname}"
    only_if   "test 0 -eq `#{db_check}`", :user => 'postgres'
    user      "postgres"
  end
end
