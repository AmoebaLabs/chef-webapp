def app; node.application end
def appdefs; default.application end

def app_init(c, *a)
  "/bin/su #{app.user.name} -c '#{app.init_script} #{c} #{a.join ' '}'"
end

# Note: this must be called in recipe context
def service_commands(service_name, actions=%w(start stop))
  service = @run_context.resource_collection.find(service: service_name)
  Hash[actions.map {|a| ["#{a}_command", service.instance_variable_get("@#{a}_command")]}]
end
