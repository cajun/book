# DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db//development.db")


configure :development do
  DataMapper::Logger.new( STDOUT, :debug )
  DataObjects::Sqlite3.logger = DataObjects::Logger.new(STDOUT, :debug)
  DataMapper.auto_migrate!
end

