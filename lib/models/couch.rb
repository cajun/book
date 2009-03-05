class Couch < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  timestamps!
end