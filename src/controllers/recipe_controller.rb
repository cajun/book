get %r{/recipe/index.?(\w*)} do |extention|
  @recipes = Recipe.all( :limit => 10 )
  
  case extention
  when "json"
    @recipes.to_json
  else
    haml( :"recipe/index" )
  end
end

# new
get "/recipe/new" do
  @recipe = Recipe.new
  haml( :"recipe/new" )
end

# show
get '/recipe/:id' do |id|
  @recipe = Recipe.get( id )

  haml( :"recipe/show" )
end

# show
get '/recipe/edit/:id' do |id|
  @recipe = Recipe.get( id )
  haml( :"recipe/edit" )
end

post "/recipe/update/:id" do |id|
  @recipe = Recipe.get( id )
  
  @recipe.update_associations( params['recipe'] )
  if( @recipe.update_attributes( params['recipe'] ) )
    haml( :"recipe/show".to_sym )
  else
    flash['error'] = 'Sorry I could not update the recipe.'
    haml( :"recipe/edit" )
  end 
end

# create
post %r{/recipe/create.?(\w*)} do |extention|
  @recipe = Recipe.new( params["recipe"] )
  @recipe.chef = Chef.current
  
  if( @recipe.save )
    redirect "/recipe/#{@recipe.id}.#{extention}"
  else
    case extention
    when "json"
      { :errors => @recipe.errors.to_json, :status => :error, :message => "Faild to save" }.to_json
    else
      :"recipe/new"
    end
  end
end
