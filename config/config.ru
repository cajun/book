# To use with thin
# thin start -p PORT -R config.ru
require File.dirname( __FILE__ ) + "/../config/boot"

# Mount our Main class with a base url of /
map "/" do
  run About
end
 
# Mount our Blog class with a base url of /blog
# map "/blog" do
#   run Sample::Blog
# end
# 