class Ingredient < Couch
  attr_accessor :casted_by
  
  property :name
  property :measurements, :cast_as => ["Measurement"]
end