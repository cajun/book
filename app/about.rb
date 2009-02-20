class About < Application
  use_in_file_templates!
  get '/' do
    haml :index
  end
end

__END__

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