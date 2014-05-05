def db; appdefs.database end

db.host = "localhost"
db.name = app.name.gsub('-', '_')
db.username = app.user.name
db.password = ""
db.encoding = "utf8"
db.timeout = "5000"

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
                 if app[:postgresql] && app.postgresql[:nodes]
                   app.postgresql[:nodes].each do |host|
                     default.postgresql.pg_hba << {
                         user:     app.user.name,
                         type:     "host",
                         db:       app.database.name,
                         addr:     "#{host}/32",
                         method:   "trust"
                     }
                   end
                 end
                 if app[:postgresql] && app.postgresql[:replication]
                   app.postgresql[:nodes].each do |host|
                     next if host == app.private_ip
                     default.postgresql.pg_hba << {
                         user:     "postgres",
                         type:     "host",
                         db:       "replication",
                         addr:     "#{host}/32",
                         method:   "trust"
                     }
                   end
                   default.postgresql.config.merge!({
                        listen_addresses: "localhost,#{app.private_ip}",
                        wal_level: 'hot_standby',
                        archive_mode: 'on',
                        archive_command: 'cd .',
                        max_wal_senders: 5,
                        wal_keep_segments: 32,
                        hot_standby: 'on',
                        ssl: 'off'
                   })
                 end
                 "postgresql"
               when /^mysql/    then "mysql2"
               when /^sqlite/   then "sqlite3"
             end

db.environments[app.environment] = {}

default[:webapp][:postgresql][:monit][:restart_cycles] = 5

# Override PSQL stuffs
override[:postgresql][:password][:postgres] = false
