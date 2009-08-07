# 
#  cook_book.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
require 'rubygems'
require 'sinatra/base'

require File.dirname( __FILE__ ) + "/config/boot"

class Book < Sinatra::Base
  set :static, true
  set :app_file, __FILE__
  #set :root, ROOT
  #set :views, Proc.new { File.join(ROOT, "views") }
  set :sessions, true
  set :cache_enabled, false
  
  register Sinatra::PageCache
  register Sinatra::Crud
  register Sinatra::Login
  
  helpers Sinatra::Security
  helpers Sinatra::HTMLHelpers
  
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
end
