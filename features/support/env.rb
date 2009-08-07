# 
#  env.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 

# Setting up the test couchdb

app_file = File.dirname(__FILE__) + '/../../book.rb'
require app_file
require 'minitest/unit'
require 'minitest/mock'
require 'rack/test'
require 'ruby-debug'
require 'webrat/sinatra'

SERVER.default_database = 'couchrest-book-test'
SERVER.default_database.delete! rescue nil
SERVER.default_database.create!

class Couch < CouchRest::ExtendedDocument
  use_database SERVER.default_database
end

# This is to make the app play with Webrat
class Book
  def self.app
    self
  end
end
# Webrat
Webrat.configure do |config|
  config.mode = :sinatra
end

World do
  session = Webrat::SinatraSession.new( Book )
  session.extend(Webrat::Matchers)
  session.extend(Webrat::HaveTagMatcher)
  session.extend( MiniTest::Assertions )
  session
end