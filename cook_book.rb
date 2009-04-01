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
  cache( haml( :index ) )
end

get '/css/styles.css' do
  content_type 'text/css', :charset => 'utf-8'
  cache( sass( :'css/styles' ) )
end

# ================
# = CRUD Pages =
# ================
get %r{/(\w+)/index} do |klass_name|
  klass = English.proper_noun( klass_name ).constantize
  instance_variable_set( "@#{klass_name.plural}", klass.all( :limit => 10 ) )
  cache( haml( "#{klass_name}/index".to_sym ) )
end

get %r{/(\w+)/new} do |klass_name|
  cache( haml( "#{klass_name}/new".to_sym ) )
end

get %r{/(\w+)/(\w+)} do |klass_name,id|
  klass = English.proper_noun( klass_name ).constantize
  instance_variable_set( "@#{klass_name}", klass.get( id ) )
  cache( haml( "#{klass_name}/show".to_sym ) )
end

post %r{/(\w+)/create} do |klass_name|
  klass = English.proper_noun( klass_name ).constantize
  expire_cache( "/#{klass_name}/index" )
  instance_variable_set( "@#{klass_name}", klass.new( params[klass_name] ) )
  var = instance_variable_get( "@#{klass_name}" )
  if( var.save )
    redirect "/#{klass_name}/#{var.id}"
  else
    haml( "#{klass_name}/new".to_sym )
  end
end
