require File.dirname( __FILE__ ) + "/cook_book"
root_dir = File.dirname(__FILE__)


set :app_file, File.join(root_dir, 'cook_book.rb')
set :run, false
set :environment, :development
set :cache_enabled, false

# Mount our Main class with a base url of /
run Sinatra::Application
