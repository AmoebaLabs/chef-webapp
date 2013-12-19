appdefs.ssl = false

if app[:http_auth]
  appdefs.http_auth.realm   = "/"
  appdefs.http_auth.exclude = []
end

appdefs.redirect_urls = []
appdefs.alias_urls = []
appdefs.url = node.fqdn

node.override['nginx']['user'] = 'nobody'
node.override['nginx']['group'] = 'nogroup'