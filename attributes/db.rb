def db; appdefs.database end

db.host = "localhost"
db.name = app.name.gsub('-', '_')
db.username = app.user.name
db.password = ""
db.encoding = "utf8"

# Eventually it would be awesome if we could specify a node in the kitchen
# to use as the DB host. So we should modify this accordingly:
#
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

default[:webapp][:postgresql][:monit][:restart_cycles] = 5

# Override PSQL stuffs
override[:postgresql][:password][:postgres] = false
