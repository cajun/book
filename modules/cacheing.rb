module Caching 
  def cache(text) 
   # requests to / should be cached as index.html 
   uri = request.env["REQUEST_URI"] == "/" ? 'index' : request.env 
["REQUEST_URI"] 
   # Don't cache pages with query strings. 
   unless uri =~ /\?/ 
      uri << '.html' 
      # put all cached files in a subdirectory called 'cache' 
      path = File.join(File.dirname(__FILE__), 'cache', uri) 
      # Create the directory if it doesn't exist 
      FileUtils.mkdir_p(File.dirname(path)) 
      # Write the text passed to the path 
      File.open(path, 'w') { |f| f.write( text ) } 
    end 
    return text 
  end 
end 
Sinatra::Default.send :include, Caching

# Example
# get '/' do 
#   cache erb( :index, :layout => 'app.erb' ) 
# end