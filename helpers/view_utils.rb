# In order to do escaping magic
# <%= h scary_output %>
#
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  # Render the page once:
  # Usage: partial :foo
  # 
  # foo will be rendered once for each element in the array, passing in a local variable named "foo"
  # Usage: partial :foo, :collection => @my_foos    
  #
  def partial(template, options={})
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      local = template.to_s.split( '/' ).last.to_sym
      collection.inject([]) do |buffer, member|
        buffer << haml(template, options.merge(
                                  :layout => false, 
                                  :locals => { local => member}
                                )
                     )
      end.join("\n")
    else
      haml(template, options)
    end
  end
  
end