# 
#  chef.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 
class Chef < Couch
  include CouchSecurity
  attr_accessor :casted_by

  property :first_name
  property :last_name
  
  view_by :last_name
  view_by :first_name
  
  def initialize( args={} )
    password = args.delete( :password ) unless args.nil?
    super( args )
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end