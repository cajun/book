require File.dirname(__FILE__) + '/../../config/boot'
require 'sinatra/test/bacon'
require 'ruby-debug'

# DataMapper.logger.close
# DataMapper::Logger.new( "#{ROOT}/logs/test.log", :debug )

#DataObjects::Sqlite3.logger.close
#DataObjects::Sqlite3.logger = DataObjects::Logger.new( "#{ROOT}/logs/test-db.log", :debug )

# puts '** Running Migrations **'
# DataMapper.auto_migrate!
# puts %Q{
# # ==========================================================================
# # = Now the database is ready we can start testing our super cool cookbook =
# # ==========================================================================
# }


module MetaTests
  def succeed
    lambda { |block|
      block.should.not.raise Bacon::Error
      true
    }
  end

  def fail
    lambda { |block|
      block.should.raise Bacon::Error
      true
    }
  end

  def equal_string(x)
    lambda { |s|
      x == s.to_s
    }
  end
  
  def not_equal( x )
    lambda { |s|
      x != s
    }
  end
end

World do |world|
  world.extend( MetaTests )
  world
end