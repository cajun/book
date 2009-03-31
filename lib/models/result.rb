# 
#  result.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Result < Couch
  attr_accessor :casted_by

  property :body
  property :rank
  property :author, :cast_as => 'Chef'
end