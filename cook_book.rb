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
require MODULES + "/crud"

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

get '/login' do
  haml( '/login' )
end

post '/login' do
  @chef = Chef.authenticate( params[:login], params[:password] )
  if( @chef )
    # logged in 
    session[:chef_id] = @chef.id
    @chef.set_env( request )
    haml( "/" )
  else
    # failed
    haml( "/" )
  end
end

post '/logout' do
end


