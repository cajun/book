require 'rubygems'
require 'sinatra'

require File.dirname( __FILE__ ) + "/config/boot"


get '/' do
  cache( haml( :index ) )
end

get '/recipes' do
  cache( haml( :recipes ) )
end

get '/recipes/new' do
  cache( haml( :recipes_new ) )
end

get '/recipes/(\d+)' do
  cache( haml( :recipe_show ) )
end

post '/recipes/create' do
  # NOTE: this is just for now until we get users inplace
  params["recipe"].merge!( "user_id" => "1" )
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
    %a{ :href => '/recipes/' } Check out the Recipes

  
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
  %content You ain't got no recipes!!!!

.links
  %a{ :href => "/recipes/new" } Go Here to create some

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

  %button{ :type => 'button' } Save it!

@@ recipe_show

#title
  %h2 = @recipe.name
  
#stuff
  %p = @recipe.instructions
  
# yeah you just created a new recipe

