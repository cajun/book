class Result < Couch
  attr_accessor :casted_by

  property :body
  property :rank
  property :author, :cast_as => 'Chef'
end