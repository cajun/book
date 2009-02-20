# To use with thin
# thin start -p PORT -R config.ru
require File.dirname( __FILE__ ) + "/../config/boot"

disable :run

set :environment, :development
set :cache_enabled, false
set :public, ROOT + "/public"

# Mount our Main class with a base url of /
map "/" do
  run About
end

map '/recipes' do
  run RecipeController
end
