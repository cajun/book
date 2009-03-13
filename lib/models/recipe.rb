class Recipe < Couch
  property :name
  property :instructions
  property :photo
  property :video
  property :ingredients, :cast_as => [ 'Ingredient' ]
  property :author, :cast_as => 'User'
  
  view_by :ingredients
  
  def valid?
    !name.nil? and !instructions.nil?
  end

  def author=( user )
    self["author"] = user.id
  end
  
  def author
    User.get( self["author"] ) if self["author"]
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