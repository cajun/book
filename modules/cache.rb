module Cache 
  set :cache_enabled, true
  # default extension for caching
  set :cache_page_extension, '.html'
  # set Cache dir to Root of Public.
  set :cache_dir, ''  # set to empty, since the ideal 'system/cache/' does not work with Passenger & mod_rewrite :(
  
  
  def cache( content, options={} ) 
    return content unless Sinatra::Application.cache_enabled

    unless content.nil?
      path = cache_page_path(request.path_info,options)
      FileUtils.makedirs(File.dirname(path))
      open(path, 'wb+') { |f| f << content }

      content
    end

  end
  
  def expire_cache(path = nil, options={})
    return unless Sinatra::Application.cache_enabled
    
    path = path.nil? ? cache_page_path( request.path_info ) : cache_page_path( path )
    if File.exist?( path )
      File.delete( path )
    end
  end
  
  def page_cached_timestamp
     "<!-- page cached: #{Time.now.strftime("%Y-%d-%m %H:%M:%S")} -->" if Sinatra::Application.cache_enabled
  end
  
  # establishes the file name of the cached file from the path given
  def cache_file_name( path, options={} )
    name = (path.empty? || path == "/") ? "index" : Rack::Utils.unescape(path.sub(/^(\/)/,'').chomp('/'))
    name << Sinatra::Application.cache_page_extension unless (name.split('/').last || name).include? '.'
    return name
  end
  
  # sets the full path to the cached page/file
  # Dependent upon Sinatra.options .public and .cache_dir variables being present and set.
  # 
  def cache_page_path(path,options={})
    "#{Sinatra::Application.public}/#{Sinatra::Application.cache_dir}#{cache_file_name(path,options)}"
  end
end 
Sinatra::Base.send :include, Cache

# Example
# get '/' do 
#   cache erb( :index, :layout => 'app.erb' ) 
# end