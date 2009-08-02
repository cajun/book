unless defined?( ROOT )
  ROOT      = File.dirname(__FILE__) + "/.."
  CONFIG    = ROOT + "/config"
  DB        = ROOT + "/db"
  LIB       = ROOT + "/src"
  MODELS    = ROOT + "/src/models"
  MODULES   = ROOT + "/src/modules"
  SCRIPT    = ROOT + "/script"
  HELPERS   = ROOT + "/helpers"
  UTILS     = ROOT + '/src/util'

  require CONFIG + '/init'
end