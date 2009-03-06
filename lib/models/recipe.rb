class Recipe < Couch
  property :name
  property :instructions
  property :photo
  property :video
  property :author, :cast_as => 'User'
  property :ingredients, :cast_as => [ 'Ingredient' ]
  
  
  view_by :ingredients
  
  def valid?
    !name.nil? and !instructions.nil?
  end
end