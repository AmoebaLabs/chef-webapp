appdefs.redis.user = "redis_#{app.user.name}"
appdefs.redis.group = app.redis.user

redis_dir = "/var/run/redis/#{app.name}/redis_#{app.name}"
appdefs.redis.socket  = "#{redis_dir}.sock"
appdefs.redis.pidfile = "#{redis_dir}.pid"

override['redisio']['version'] = app.redis.version || '2.6.16'
override['redisio']['mirror'] = app.redis.mirror || 'http://download.redis.io/releases'

override['redisio']['servers'] = [{
  name:     app.name,
  user:     app.redis.user,
  group:    app.redis.group,
  homedir:  "#{app.path}/redis",
  datadir:  "#{app.path}/redis/data",

  port: '0',  # use Unix socket instead of TCP port
  unixsocket: app.redis.socket,
  unixsocketperm: '770',
}]