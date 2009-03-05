class Recipe < Couch
  property :name
  property :instructions
  property :photo
  property :video
  property :author, :cast_as => 'User'
  property :ingredients, :cast_as => [ 'Ingredient' ]
end