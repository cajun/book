unless defined?( ROOT )
  ROOT      = File.dirname(__FILE__) + "/.."
  CONFIG    = ROOT + "/config"
  DB        = ROOT + "/db"
  LIB       = ROOT + "/lib"
  MODELS    = ROOT + "/lib/models"
  MODULES   = ROOT + "/lib/modules"
  SCRIPT    = ROOT + "/script"
  HELPERS   = ROOT + "/helpers"

  require CONFIG + '/init'
end