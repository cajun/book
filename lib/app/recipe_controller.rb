class RecipeController < Application
  use_in_file_templates!
  
  get '/' do
    cache( haml( :index ) )
  end
  
  get '/new' do
    cache( haml( :new ) )
  end
end

__END__

@@ index

.title
  %content You ain't got no recipes!!!!

.links
  %a{ :href => "/recipes/new" } Go Here to create some

@@ new

#title
  %h2 Create your new recipe
  
%form
  %div
    %label{ :for => 'recipe[name]' } Name
    %input{ :name => 'recipe[name]', :id => 'recipe[name]' }
  
  %div
    %label{ :for => 'recipe[instructions]' } Instuctions
    %textarea{ :rows => 20, :cols => 80, :name => 'recipe[instructions]', :id => 'recipe[instructions]' }
  
  #to_be_announced photos, videos
  
  %button{ :type => 'button' } Save it!