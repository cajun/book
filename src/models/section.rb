# 
#  ingredient.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Section < Couch
  attr_accessor :casted_by
  
  property :header
  property :text
end