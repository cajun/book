# 
#  env.rb
#  book
#  
#  Created by Zac Kleinpeter on 2009-03-27.
#  Copyright 2009 Cajun Country. All rights reserved.
# 

# Setting up the test couchdb

ENV['RACK_ENV'] = 'test'

app_file = File.dirname(__FILE__) + '/../../book.rb'

require app_file
require 'minitest/unit'
require 'minitest/mock'
require 'rack/test'
require 'ruby-debug'
require 'webrat'
require 'rr'

SERVER.default_database = 'couchrest-book-test'
SERVER.default_database.delete! rescue nil
SERVER.default_database.create!

class Couch < CouchRest::ExtendedDocument
  use_database SERVER.default_database
end

Chef.send( :include, CouchSecurity )
Chef.send( :include, Tokens )

# Webrat
Webrat.configure do |config|
  config.mode = :sinatra
end

class SinatraWorld 
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Webrat::HaveTagMatcher
  include MiniTest::Assertions
  include RR::Adapters::RRMethods
  
  Webrat::Methods.delegate_to_session :response_code, :response_body
  
  def app
    Sinatra::Application
  end
end


World{ SinatraWorld.new }