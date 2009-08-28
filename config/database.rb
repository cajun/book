# Setting up the defalt db
SERVER = CouchRest.new
SERVER.default_database = 'couchrest-book'

# Setting up the logger db
couch = CouchRest.new
LOG_DB = couch.database!('couchrest-logger')

class Couch < CouchRest::ExtendedDocument
  include CouchRest::Validation
  
  use_database SERVER.default_database
  timestamps!

  
  class << self
    private
    alias :default_fetch_view :fetch_view
    
    # Fixing a view in the couch rest lib
    def fetch_view(db, view_name, opts, &block)
      retryable = true
      begin
        default_fetch_view( db, view_name, opts, &block )
      rescue RuntimeError => e
        if retryable
          save_design_doc_on(db)
          retryable = false
          retry
        else
          raise e
        end
      end
    end
  end
end

db = Couch.new.database