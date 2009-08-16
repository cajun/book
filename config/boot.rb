unless defined?( ROOT )
  ROOT        = File.dirname(__FILE__) + "/.."
  CONFIG      = ROOT + "/config"
  DB          = ROOT + "/db"
  LIB         = ROOT + "/src"
  MODELS      = ROOT + "/src/models"
  CONTROLLERS = ROOT + "/src/controllers"
  MODULES     = ROOT + "/src/modules"
  SCRIPT      = ROOT + "/script"
  HELPERS     = ROOT + "/src/helpers"
  UTILS       = ROOT + '/src/util'
  MIDDLEWARE  = ROOT + '/src/middleware/rack/couchdb'
  AUTH        = ROOT + '/src/middleware/rack/couchdb/auth'

  require CONFIG + '/init'
end
