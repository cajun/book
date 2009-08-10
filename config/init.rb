# =================
# = Required libs =
# =================
require 'rubygems'
require 'sinatra'
require 'fileutils'
require 'couchrest'
require 'resolv'
require 'bcrypt'
require 'linguistics'
require 'facets/string'
require 'haml'
require 'grit'

Linguistics::use( :en, :installProxy => true )
English = Linguistics::EN


$COUCHREST_DEBUG = true
# ==========================
# = Database configuration =
# ==========================
require CONFIG + '/database'

# ===========
# = Modules =
# ===========
Dir.glob( File.join( MODULES, '*.rb' ) ).each{ |file| load file }

# ========
# = Data =
# ========
Dir.glob( File.join( MODELS, '*.rb' ) ).each{ |file| load file }

# ===========
# = Helpers =
# ===========
# NOTE: theses need to be loaded revery request
Dir.glob( File.join( HELPERS, '*.rb' ) ).each{ |file| load file }

# ===========
# = Utils =
# ===========
# NOTE: theses need to be loaded revery request
Dir.glob( File.join( UTILS, '*.rb' ) ).each{ |file| load file }

# ===============
# = Controllers =
# ===============
# NOTE: theses need to be loaded revery request
Dir.glob( File.join( CONTROLLERS, '*.rb' ) ).each{ |file| load file }