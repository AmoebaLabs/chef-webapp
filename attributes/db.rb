def db; appdefs.database end

db.host = "localhost"
db.name = app.name.gsub('-', '_')
db.username = app.user.name
db.password = ""
db.encoding = "utf8"

#if URI.parse(app.database.host).scheme == 'node'
#  search :node, "name:#{app.database.host}" do |host|
#    override.database.host = host.name
#  end
#end

db.adapter = case app.database[:type]
               when /^postgres/
                 default.postgresql.pg_hba = [
                   {
                     user:     app.user.name,
                     type:     "local",
                     db:       app.database.name,
                     addr:     nil,
                     method:   "peer"
                   }
                 ]
                 "postgresql"
               when /^mysql/    then "mysql2"
               when /^sqlite/   then "sqlite3"
             end

db.environments[app.environment] = {}

# Override PSQL stuffs
override[:postgresql][:password][:postgres] = false
