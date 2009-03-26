SERVER = CouchRest.new
SERVER.default_database = 'couchrest-book'

class Couch < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  timestamps!

  def valid?
    true
  end
end

$db = Couch.new.database