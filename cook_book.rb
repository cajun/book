require 'rubygems'
require 'sinatra'

require File.dirname( __FILE__ ) + "/config/boot"

set :environment, :development

get '/' do
  cache( haml( :index ) )
end

get '/recipes/index' do
  @recipes = Recipe.all
  cache( haml( :recipes ) )
end

get '/recipes/new/?' do
  cache( haml( :recipes_new ) )
end

get '/recipes/:id' do
  @recipe = Recipe.get( params[:id] )
  cache( haml( :recipe_show ) )
end

post '/recipes/create' do
  expire_cache( '/recipes/index' )
  @recipe = Recipe.new( params["recipe"] )
  if( @recipe.save )
    redirect "/recipes/#{@recipe.id}"
  else
    haml( :recipes_new )
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
    %a{ :href => '/recipes/index' } Check out the Recipes

  
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
  %a{ :href => "/recipes/new" } Go Here to create some

@@ list
%li
  %a{ :href => "/recipes/#{list.id}" }= list.name

@@ recipes_new

#title
  %h2 Create your new recipe

%form{ :action => '/recipes/create', :method => "post" }
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

