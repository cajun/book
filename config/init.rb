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

# ==========================
# = Database configuration =
# ==========================
require 'database'

# ===========
# = Modules =
# ===========
require Dir.globMODULES + "/"

# ========
# = Data =
# ========