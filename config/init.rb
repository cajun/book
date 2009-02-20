# =================
# = Required libs =
# =================
require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-types'
require 'dm-is-nested_set'
require 'dm-is-state_machine'
require 'dm-is-remixable'

# ==========================
# = Database configuration =
# ==========================
require CONFIG + '/database'

# ===========
# = Modules =
# ===========
Dir.glob( File.join( MODULES, '*.rb' ) ).each{ |file| require file }

# ========
# = Data =
# ========
Dir.glob( File.join( DATA, '*.rb' ) ).each{ |file| require file }

# ===============
# = Application =
# ===============
require APP + "/application"
Dir.glob( File.join( APP, '*.rb' ) ).each{ |file| require file }