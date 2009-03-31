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

# ================
# = CRUD Pages =
# ================
get %r{/(\w+)/index} do |klass_name|
  klass = English.proper_noun( klass_name ).constantize
  instance_variable_set( "@#{klass_name.plural}", klass.all( :limit => 10 ) )
  cache( haml( klass_name.plural.to_sym) )
end

get %r{/(\w+)/new} do |klass_name|
  cache( haml( "#{klass_name}_new".to_sym ) )
end

get %r{/(\w+)/(\w+)} do |klass_name,id|
  klass = English.proper_noun( klass_name ).constantize
  instance_variable_set( "@#{klass_name}", klass.get( id ) )
  cache( haml( "#{klass_name}_show".to_sym ) )
end

post %r{/(\w+)/create} do |klass_name|
  klass = English.proper_noun( klass_name ).constantize
  expire_cache( "/#{klass_name}/index" )
  instance_variable_set( "@#{klass_name}", klass.new( params[klass_name] ) )
  var = instance_variable_get( "@#{klass_name}" )
  if( var.save )
    redirect "/#{klass_name}/#{var.id}"
  else
    haml( "#{klass_name}_new".to_sym )
  end
end

use_in_file_templates!


__END__

@@ layout
!!! 1.1
%html
  %head
    %script{ :type => 'text/javascript', :src => '/javascripts/jquery-1.3.2.min.js' }
    = page_cached_timestamp

    %title require 'cookbook'
  
  #header
    %a{ :href => '/' } Go Home!!!
    %a{ :href => '/recipe/index' } Check out the Recipes

  
  #body 
    =yield
  
  #footer
    #version
      == You are running Sinatra v#{Sinatra::VERSION}

@@ index
.center
  %h1 Welcome to require 'cookbook'

  %p
    I created this cookbook to refine the art of cooking.  Here you will be able to 
    start with a basic recipe and then refine that recipe so that it can be improved.
    While making a recipe better you will be able to see all the different variations 
    of that recipe that you have done. Here are some of the features:

    %ul
      %li Rank ANYTHING
      %li Add Results to ANYTHING
      %li Have different brands per recipe
      %li See the cost of each recipe - almost done
      %li Print recipe cards - almost done
      %li Auto discover recipes - almost done
      
@@ recipes

.title
  %content 
    - if @recipes.empty? 
      You ain't got no recipes!!!!
    - if !@recipes.empty?
      %ul
        = partial :list, :collection => @recipes

.links
  %a{ :href => "/recipe/new" } Go Here to create some

@@ list
%li
  %a{ :href => "/recipe/#{list.id}" }= list.name

@@ recipe_new

#title
  %h2 Create your new recipe

%form{ :action => '/recipe/create', :method => "post" }
  %div
    %label{ :for => 'recipe[name]' } Name
    %input{ :name => 'recipe[name]', :id => 'recipe[name]' }

  %div
    %label{ :for => 'recipe[instructions]' } Instuctions
    %textarea{ :rows => 20, :cols => 80, :name => 'recipe[instructions]', :id => 'recipe[instructions]' }

  #to_be_announced photos, videos

  %input{ :type => 'submit', :value => 'Save it!' }

@@ recipe_show

#title
  %h2= @recipe.name
  
#stuff
  %p= @recipe.instructions
  
#comments yeah you just created a new recipe

@@ chef_new

yo yo yo

@@ chef_show

i am showing you who you are