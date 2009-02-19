DataMapper.setup(:default, 'sqlite3::memory:')
# DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.db")
DataMapper::Logger.new(STDOUT, :debug)
