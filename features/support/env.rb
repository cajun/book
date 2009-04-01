# 
#  env.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 

# Setting up the test couchdb

require File.dirname(__FILE__) + '/../../cook_book'
require 'spec/expectations'
require 'spec/matchers'
require 'ruby-debug'

SERVER.default_database = 'couchrest-book-test'
SERVER.default_database.recreate!

class Couch < CouchRest::ExtendedDocument
  use_database SERVER.default_database
end

set :public, ROOT + '/public'
set :views, ROOT + '/views'
# Webrat
require 'webrat'
Webrat.configure do |config|
  config.mode = :sinatra
end

World do
  Webrat::SinatraSession.new
end