class Ingredient < Couch
  attr_accessor :casted_by
  
  property :name
  property :amount
  property :unit
end