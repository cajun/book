class Result < Couch
  property :body
  property :rank
  property :user, :cast_as => 'User'
end