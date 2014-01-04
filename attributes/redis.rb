appdefs.redis.user = "redis_#{app.user.name}"
appdefs.redis.group = app.redis.user

redis_dir = "/var/run/redis/#{app.name}/redis_#{app.name}"
appdefs.redis.socket  = "#{redis_dir}.sock"
appdefs.redis.port = 6379
appdefs.redis.pidfile = "#{redis_dir}.pid"
appdefs.redis.logfile = "/var/log/redis/redis_#{app.name}.log" # Set to nil to use syslog
appdefs.redis.syslogenabled = node[:application][:redis][:logfile] ? 'no' : 'yes'

appdefs.redis.monit.restart_cycles = 5

## Now, override redisio things with the attributes:
override['redisio']['version'] = app[:redis][:version] || '2.6.16'
override['redisio']['mirror'] = app[:redis][:mirror] || 'http://download.redis.io/releases'
override['redisio']['servers'] = [{
  name:           app.name,
  user:           app.redis.user,
  group:          app.redis.group,
  homedir:        "/var/lib/redis/#{app.name}",
  datadir:        "/var/lib/redis/#{app.name}/data",
  logfile:        app.redis.logfile,
  syslogenabled:  app.redis.syslogenabled,
  port:           app.redis.port,  # TCP port and Unix socket are used
  unixsocket:     app.redis.socket,
  unixsocketperm: '770'
}]
