# 
#  string.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-29.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class String
  # Borrowed from Rails
  def constantize
    names = self.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end
end