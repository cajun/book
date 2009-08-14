#!/usr/bin/env ruby
# 
#  cook_book.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
require 'rubygems'
require 'sinatra'
require File.dirname( __FILE__ ) + "/config/boot"

set :static, true
set :app_file, __FILE__
set :views, Proc.new { File.join(ROOT, "src", "views") }
set :sessions, true
set :cache_enabled, false

# ===============
# = Middle Ware =
# ===============
#use Rack::NestedParams
use Rack::CouchDB::Logger, LOG_DB

# ===========
# = filters =
# ===========
before do
  if( session[:chef_id] )
    Chef.current = Chef.get( session[:chef_id] )
  end
end

# ===============
# = About Pages =
# ===============
get '/' do
  haml( :index )
end

# ==============
# = Deploy Url =
# ==============
post '/deploy' do
  `cd #{File.dirname( __FILE__ )}`
  `git pull origin master`
  `touch tmp/restart.txt`
end
