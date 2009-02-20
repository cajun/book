class RecipeController < Application
  use_in_file_templates!
  
  get '/' do
    haml( :index )
  end
end

__END__

@@ index

%content You ain't got no recipes!!!!