require File.dirname(__FILE__) + '/../../cook_book'
require 'spec/expectations'
require 'spec/matchers'
require 'ruby-debug'

# DataMapper.logger.close
# DataMapper::Logger.new( "#{ROOT}/logs/test.log", :debug )

#DataObjects::Sqlite3.logger.close
#DataObjects::Sqlite3.logger = DataObjects::Logger.new( "#{ROOT}/logs/test-db.log", :debug )

puts '** Running Migrations **'
DataMapper.auto_migrate!
puts %Q{
# # ==========================================================================
# # = Now the database is ready we can start testing our super cool cookbook =
# # ==========================================================================
}


# Webrat
require 'webrat'
Webrat.configure do |config|
  config.mode = :sinatra
end

World do
  Webrat::SinatraSession.new
end