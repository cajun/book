Before do
  SERVER.default_database = 'couchrest-book-test'
  SERVER.default_database.delete! rescue nil
  SERVER.default_database.create!
end