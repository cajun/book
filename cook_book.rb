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

set :environment, :development

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

# ================
# = CRUD Pages =
# ================
 
# index
get %r{/(\w+)/index.?(\w*)} do |klass_name,extention|
  klass = klass_name.modulize.constantize
  instance_variable_set( "@#{klass_name.plural}", klass.all( :limit => 10 ) )
  
  case extention
  when "json"
    instance_variable_get( "@#{klass_name.plural}" ).to_json
  else
    haml( "#{klass_name}/index".to_sym )
  end
end

# new
get %r{/(\w+)/new} do |klass_name|
  haml( "#{klass_name}/new".to_sym )
end

# show
get %r{/(\w+)/(\w+).?(\w*)} do |klass_name,id,extention|
  klass = klass_name.modulize.constantize
  instance_variable_set( "@#{klass_name}", klass.get( id ) )
  
  case extention
  when "json"
    instance_variable_get( "@#{klass_name}" ).to_json
  else
    haml( "#{klass_name}/show".to_sym )
  end
end

# create
post %r{/(\w+)/create.?(\w*)} do |klass_name,extention|
  klass = klass_name.modulize.constantize
  expire_cache( "/#{klass_name}/index" )
  instance_variable_set( "@#{klass_name}", klass.new( params[klass_name] ) )
  var = instance_variable_get( "@#{klass_name}" )
  
    
  if( var.save )
    redirect "/#{klass_name}/#{var.id}.#{extention}"
  else
    case extention
    when "json"
      { :errors => var.errors.to_json, :status => :error, :message => "Faild to save" }.to_json
    else
      "#{klass_name}/new".to_sym
    end
  end
end
