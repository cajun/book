class Recipe < Couch
  property :name
  property :instructions
  property :photo
  property :video
  property :ingredients, :cast_as => [ 'Ingredient' ]
  property :results, :cast_as => [ 'Result' ]
  property :chef, :cast_as => 'Chef'
  
  view_by :ingredients
  
  def initialize( args={} )
    super( args )
    self.ingredients =[] unless self.ingredients
    self.results =[] unless self.results
  end
  
  def valid?
    !name.nil? and !instructions.nil?
  end

  # ==============
  # = Call Backs =
  # ==============
  save_callback :before, :save_assoications

  def save_assoications
    ingredients.each{ |i| i.save if i }
    results.each{ |r| r.save if r }
    chef.save if Chef === chef
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