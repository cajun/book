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
require 'ruby-debug'

# ===============
# = Middle Ware =
# ===============
use Rack::Flash
use Rack::NestedParams
use Rack::Cache,
  :metastore   => 'memcached://localhost:11211/meta',
  :entitystore => 'memcached://localhost:11211/body'
  
use Rack::CouchDB::Logger, LOG_DB
use Rack::CouchDB::BCrypt, {:klass => Chef}


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


get '/login' do
  haml( :login )
end

# ==============
# = Deploy Url =
# ==============
post '/deploy' do
  `cd #{File.dirname( __FILE__ )}`
  `git pull origin master`
  `touch tmp/restart.txt`
end
