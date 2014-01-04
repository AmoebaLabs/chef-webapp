appdefs.redis.user = "redis_#{app.user.name}"
appdefs.redis.group = app.redis.user

redis_dir = "/var/run/redis/#{app.name}/redis_#{app.name}"
appdefs.redis.socket  = "#{redis_dir}.sock"
appdefs.redis.pidfile = "#{redis_dir}.pid"

appdefs.redis.port = 6379
appdefs.redis.monit.restart_cycles = 5

override['redisio']['version'] = app[:redis][:version] || '2.6.16'
override['redisio']['mirror'] = app[:redis][:mirror] || 'http://download.redis.io/releases'

override['redisio']['servers'] = [{
  name:           app.name,
  user:           app.redis.user,
  group:          app.redis.group,
  homedir:        "/var/lib/redis/#{app.name}",
  datadir:        "/var/lib/redis/#{app.name}/data",
  port:           app.redis.port,  # TCP port and Unix socket are used
  unixsocket:     app.redis.socket,
  unixsocketperm: '770'
}]
