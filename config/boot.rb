unless defined?( ROOT )
  ROOT    = File.dirname(__FILE__) + "/.."
  CONFIG  = ROOT + "/config"
  DB      = ROOT + "/db"
  LIB     = ROOT + "/lib"
  DATA    = ROOT + "/lib/models"
  MODULES = ROOT + "/lib/modules"
  APP     = ROOT + "/lib/app"
  SCRIPTS = ROOT + "/scripts"
  TEST    = ROOT + "/test"
  UNITS   = ROOT + "/test/units"

  require CONFIG + '/init'
end