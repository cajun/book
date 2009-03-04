# =================
# = Required libs =
# =================
require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-types'
require 'dm-is-nested_set'
require 'dm-is-state_machine'
require 'dm-is-remixable'
require 'dm-aggregates'
require 'fileutils'
require 'digest/md5'
require 'resolv'


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
