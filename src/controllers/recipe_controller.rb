module Sinatra
  module RecipeController
    def self.registered(app)
      # ================
      # = CRUD Pages =
      # ================

      # index
      app.get %r{/recipe/index.?(\w*)} do |extention|
        @recipes = Recipe.all( :limit => 10 )
        
        case extention
        when "json"
          @recipes.to_json
        else
          haml( :"recipe/index" )
        end
      end

      # new
      app.get %r{/recipe/new} do
        haml( :"recipe/new" )
      end

      # show
      app.get %r{/recipe/(\w+).?(\w*)} do |id,extention|
        @recipe = Recipe.get( id )

        case extention
        when "json"
          @recipe.to_json
        else
          haml( :"recipe/show" )
        end
      end

      # create
      app.post %r{/recipe/create.?(\w*)} do |extention|
        expire_cache( "/recipe/index" )
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
    end
  end
  
  register RecipeController
end