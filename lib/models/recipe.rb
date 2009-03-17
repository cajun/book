class Recipe < Couch
  property :name
  property :instructions
  property :photo
  property :video
  property :ingredients, :cast_as => [ 'Ingredient' ]
  property :results, :cast_as => [ 'Result' ]
  property :chef, :cast_as => 'Chef'
  
  view_by :ingredient_name, 
  :map => "
  function(doc){
    if ((doc['couchrest-type'] == 'Recipe') && doc['ingredients']) {
       for( var ix in doc['ingredients'] ){
        emit( doc['ingredients'][ix].name,{recipe_id: doc._id, count: 1});  
      }
    }
  }",
  :reduce => "
  function( key,values,reduce){
    var count =0;
    var rec = new Array();
    var x;
    for( x in values ){
      count += values[x].count;
      rec[x] = values[x].recipe_id;
    }
    return { total: count, recipe_id: rec }
  }
  "
  
  
  def initialize( args={} )
    super( args )
    ingredients = [] if ingredients.nil?
    results = [] if ingredients.nil?
  end

  def valid?
    !name.nil? and !instructions.nil?
  end
  
  def chef=( chef )
    if Chef === chef
      self["chef_id"] = chef.id
    end
  end
  
  def chef
    Chef.get( self["chef_id"] ) if self["chef"]
  end

  def lft=( left_recipe )
    self["lft"] = left_recipe.id
  end
  
  def lft
    Recipe.get( self["lft"] ) if self["lft"]
  end

  def rht=( right_recipe )
    self["rht"] = right_recipe.id
  end
  
  def rht
    Recipe.get( self["rht"] ) if self["rht"]
  end
  
end