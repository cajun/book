# To use with thin
# thin start -p PORT -R config.ru
require File.dirname( __FILE__ ) + "/../config/boot"

# Make sure all migrations have been run
DataMapper.auto_upgrade!

disable :run

set :environment, :development
set :cache_enabled, false
set :public, ROOT + "/public"


# Mount our Main class with a base url of /
map "/" do
  run AboutController
end

map '/recipes' do
  run RecipeController
end

map '/json/recipes' do
  run RecipeJson
end
