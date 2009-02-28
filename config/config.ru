# To use with thin
# thin start -p PORT -R config.ru
require File.dirname( __FILE__ ) + "/../cook_book"

# Make sure all migrations have been run
DataMapper.auto_upgrade!

disable :run

set :environment, :development
set :cache_enabled, false
set :public, ROOT + "/public"


# Mount our Main class with a base url of /
run Sinatra::Application
