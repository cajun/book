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

# ===============
# = Middle Ware =
# ===============
use Rack::CouchDB::Logger, LOG_DB
use Rack::CouchDB::BCrypt, {:klass => Chef}



require 'ruby-debug'

set :static, true
set :app_file, __FILE__
set :views, Proc.new { File.join(ROOT, "src", "views") }
set :sessions, true
set :cache_enabled, false


Sinatra::Base.send :include, GitInfo
Sinatra::Base.send :include, PageCache


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
